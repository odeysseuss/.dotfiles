-- === build, run and test with populating quickfix list
local lang_maps = {
    c = {
        build = "xmake f -m debug && xmake build -a -v",
        exec = "xmake run",
        test = "xmake -r test",
        errorformat = "%f:%l:%c: %m"
    },
    cpp = {
        build = "xmake f -m debug && xmake build -a -v",
        exec = "xmake run",
        test = "xmake -r test",
        errorformat = "%f:%l:%c: %m"
    },
    rust = {
        build = "cargo build",
        exec = "cargo run",
        test = "cargo test",
        errorformat = "%f:%l:%c: %m"
    },
    go = {
        build = "go build",
        exec = "go run .",
        test = "go test ./...",
        errorformat = "%f:%l:%c: %m"
    },
    sh = {
        exec = "./%"
    },
    python = {
        exec = "python %",
        test = "python -m pytest",
        errorformat = "%f:%l: %m"
    },
}

local makefile_cmds = {
    build = "make",
    exec = "make run",
    test = "make test",
    errorformat = "%f:%l:%c: %m"
}

local function has_makefile()
    return vim.fn.filereadable("Makefile") == 1
end

local function RunWithQuickfix(cmd, errorformat)
    -- capture and execute command
    local handle = io.popen(cmd .. " 2>&1")
    -- check for nil
    if not handle then
        print("Error: Failed to execute: " .. cmd)
        return
    end
    local output = handle:read("*a")
    handle:close()

    -- split output into lines
    local lines = {}
    for line in output:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    -- populate quickfix list with errorformat
    vim.fn.setqflist({}, 'r', {
        title = "make",
        lines = lines,
        efm = errorformat
    })

    vim.cmd("Trouble qflist toggle")
end

for lang, cmds in pairs(lang_maps) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = lang,
        callback = function()
            local effective_cmds = cmds
            if has_makefile() then
                effective_cmds = makefile_cmds
            end

            -- build cmd
            if effective_cmds.build then
                vim.keymap.set("n", "<leader>b", function()
                    if effective_cmds.errorformat then
                        RunWithQuickfix(effective_cmds.build, effective_cmds.errorformat)
                    end
                end, { buffer = true, desc = "Tmux build with quickfix" })
                vim.keymap.set("n", "<leader>B", function()
                    SendToTmux(effective_cmds.build)
                end, { buffer = true, desc = "Tmux build" })
            end

            -- exec cmd
            if effective_cmds.exec then
                vim.keymap.set("n", "<leader>r", function()
                    SendToTmux(effective_cmds.exec)
                end, { buffer = true, desc = "Tmux execute" })
            end

            -- test cmd
            if effective_cmds.test then
                vim.keymap.set("n", "<leader>tt", function()
                    if effective_cmds.errorformat then
                        RunWithQuickfix(effective_cmds.test, effective_cmds.errorformat)
                    end
                end, { buffer = true, desc = "Tmux run test with quickfix" })
                vim.keymap.set("n", "<leader>T", function()
                    SendToTmux(effective_cmds.test)
                end, { buffer = true, desc = "Tmux run test" })
            end
        end,
    })
end
