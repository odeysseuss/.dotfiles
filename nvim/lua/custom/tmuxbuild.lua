local function get_effective_cmds()
    -- check for Makefile first
    if vim.fn.filereadable("Makefile") == 1 then
        return {
            build = "make -j$(nproc)",
            exec = "make run",
            test = "make test",
            errorformat = vim.b.errorformat or vim.o.errorformat or "",
        }
    end

    -- use buffer variables
    return {
        build = vim.b.makeprg or vim.o.makeprg or "",
        exec = vim.b.execprg or "",
        test = vim.b.testprg or "",
        errorformat = vim.b.errorformat or vim.o.errorformat or "",
    }
end

local function RunWithQuickfix(cmd, errorformat)
    if cmd == "" or not cmd or errorformat == "" or not errorformat then
        vim.notify("Configuration for this filetype is unavailable", vim.log.levels.ERROR, {})
        return
    end

    vim.notify("[CMD]: " .. cmd, vim.log.levels.INFO, {})

    local output_lines = {}

    local function handle_out(data)
        if data then
            for _, line in ipairs(data) do
                if line ~= "" then
                    table.insert(output_lines, line)
                end
            end
        end
    end

    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            handle_out(data)
        end,
        on_stderr = function(_, data)
            handle_out(data)
        end,
        on_exit = function(_, exit_code)
            vim.schedule(function()
                vim.fn.setqflist({}, "r", {
                    title = cmd,
                    lines = output_lines,
                    efm = errorformat,
                })
                vim.cmd("copen")

                if exit_code == 0 then
                    vim.notify("[OK]: " .. cmd, vim.log.levels.INFO, {})
                else
                    vim.notify("[FAIL]: " .. cmd, vim.log.levels.ERROR, {})
                end
            end)
        end,
    })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        local effective_cmds = get_effective_cmds()

        -- build cmd
        vim.keymap.set("n", "<leader>b", function()
            RunWithQuickfix(effective_cmds.build, effective_cmds.errorformat)
        end, { buffer = true, desc = "Build with quickfix" })
        vim.keymap.set("n", "<leader>B", function()
            SendToTmux(effective_cmds.build)
        end, { buffer = true, desc = "Tmux build" })

        -- exec cmd
        vim.keymap.set("n", "<leader>r", function()
            SendToTmux(effective_cmds.exec)
        end, { buffer = true, desc = "Execute" })

        -- test cmd
        vim.keymap.set("n", "<leader>tt", function()
            RunWithQuickfix(effective_cmds.test, effective_cmds.errorformat)
        end, { buffer = true, desc = "Test with quickfix" })
        vim.keymap.set("n", "<leader>T", function()
            SendToTmux(effective_cmds.test)
        end, { buffer = true, desc = "Tmux test" })
    end,
})
