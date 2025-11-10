-- /*
-- == INFO: NEEDED TO SET THESE VARIABLES IN (after/ftplugin/<ft>.lua)
-- vim.b.makeprg = ""
-- vim.b.execprg = ""
-- vim.b.testprg = ""
-- vim.b.errorformat = "" -- use default one if supported by nvim
-- */

-- === build, run and test with populating quickfix list
local function has_makefile()
    return vim.fn.filereadable("Makefile") == 1
end

local function get_effective_cmds()
    -- check for Makefile first
    if has_makefile() then
        return {
            build = "make",
            exec = "make run",
            test = "make test",
            errorformat = "%f:%l:%c: %m"
        }
    end

    -- use buffer variables
    return {
        build = vim.b.makeprg or "",
        exec = vim.b.execprg or "",
        test = vim.b.testprg or "",
        errorformat = vim.b.errorformat or ""
    }
end

local function RunWithQuickfix(cmd, errorformat)
    if cmd == "" or not cmd then
        vim.notify("No command configured for this filetype", vim.log.levels.WARN, {})
        return
    end

    vim.notify("[CMD]: " .. cmd, vim.log.levels.INFO, {})

    local output_lines = {}

    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then
                for _, line in ipairs(data) do
                    if line ~= "" then
                        table.insert(output_lines, line)
                    end
                end
            end
        end,
        on_stderr = function(_, data)
            if data then
                for _, line in ipairs(data) do
                    if line ~= "" then
                        table.insert(output_lines, line)
                    end
                end
            end
        end,
        on_exit = function(_, exit_code)
            vim.schedule(function()
                if #output_lines > 0 then
                    vim.fn.setqflist({}, 'r', {
                        title = cmd,
                        lines = output_lines,
                        efm = errorformat
                    })
                    vim.cmd("Trouble qflist toggle")
                end

                if exit_code == 0 then
                    vim.notify("[OK]: " .. cmd, vim.log.levels.INFO, {})
                else
                    vim.notify("[FAIL]: " .. cmd, vim.log.levels.ERROR, {})
                end
            end)
        end
    })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        local effective_cmds = get_effective_cmds()

        -- build cmd
        if effective_cmds.build and effective_cmds.build ~= "" then
            vim.keymap.set("n", "<leader>b", function()
                if effective_cmds.errorformat and effective_cmds.errorformat ~= "" then
                    RunWithQuickfix(effective_cmds.build, effective_cmds.errorformat)
                end
            end, { buffer = true, desc = "Build with quickfix" })
            vim.keymap.set("n", "<leader>B", function()
                SendToTmux(effective_cmds.build)
            end, { buffer = true, desc = "Tmux build" })
        end

        -- exec cmd
        if effective_cmds.exec and effective_cmds.exec ~= "" then
            vim.keymap.set("n", "<leader>r", function()
                SendToTmux(effective_cmds.exec)
            end, { buffer = true, desc = "Execute" })
        end

        -- test cmd
        if effective_cmds.test and effective_cmds.test ~= "" then
            vim.keymap.set("n", "<leader>tt", function()
                if effective_cmds.errorformat and effective_cmds.errorformat ~= "" then
                    RunWithQuickfix(effective_cmds.test, effective_cmds.errorformat)
                end
            end, { buffer = true, desc = "Test with quickfix" })
            vim.keymap.set("n", "<leader>T", function()
                SendToTmux(effective_cmds.test)
            end, { buffer = true, desc = "Tmux test" })
        end
    end,
})
