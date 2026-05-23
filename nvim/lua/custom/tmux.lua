-- === Navigate between neovim and tmux ===

-- navigate between neovim windows and tmux pane with same keymaps
local navigate = function(direction)
    local current_win = vim.api.nvim_get_current_win()

    vim.cmd("wincmd " .. direction)
    local new_win = vim.api.nvim_get_current_win()

    if current_win == new_win and vim.env.TMUX then
        local directions = { h = "L", j = "D", k = "U", l = "R" }
        local cmd = "tmux select-pane -" .. directions[direction]
        vim.fn.system(cmd)
    end
end

vim.keymap.set("n", "<C-h>", function() navigate("h") end, { silent = true })
vim.keymap.set("n", "<C-j>", function() navigate("j") end, { silent = true })
vim.keymap.set("n", "<C-k>", function() navigate("k") end, { silent = true })
vim.keymap.set("n", "<C-l>", function() navigate("l") end, { silent = true })

-- === Execute commands in tmux ===
local tmux_pane = nil

-- executing tmux command asynchronously
local execCmd = function(tmux_cmd, callback)
    vim.fn.jobstart(tmux_cmd, {
        on_exit = function()
            if callback then
                vim.schedule(callback)
            end
        end,
    })
end

local runCmd = function(cmd)
    cmd = cmd:gsub("%%", vim.fn.expand("%"))

    if not tmux_pane or vim.fn.system("tmux list-panes -F '#{pane_id}' | wc -l") == "1\n" then
        execCmd("tmux split-window -h -c '#{pane_current_path}' -d", function()
            execCmd(string.format("tmux send-keys -t %s 'clear && %s' C-m",
                tmux_pane or ".1", cmd))
        end)
        tmux_pane = ".1"
    else
        execCmd(string.format("tmux send-keys -t %s 'clear && %s' C-m", tmux_pane,
            cmd))
    end
end

-- kill tmux_pane
local killPane = function()
    if tmux_pane == nil then return end

    vim.fn.jobstart("tmux kill-pane -t " .. tmux_pane, {
        on_exit = function()
            vim.schedule(function()
                tmux_pane = nil
            end)
        end,
    })
end

-- nvim commands
vim.api.nvim_create_user_command("TmuxRunCmd", function(opts)
    runCmd(opts.args)
end, { nargs = "+" })

-- run visually selected line in tmux
vim.api.nvim_create_user_command("TmuxSendRange", function(opts)
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    local cmd = table.concat(lines, ";")
    runCmd(cmd)
end, { range = true })

vim.keymap.set("n", "<leader>X", function() killPane() end, { desc = "Tmux kill pane" })

-- === Run language specific commands in tmux ===
local langs = {
    c = { exec = "make run", test = "make test" },
    cpp = { exec = "make run", test = "make test" },
    rust = { exec = "cargo run", test = "cargo test" },
    sh = { exec = "./%" },
    lua = { exec = "luajit ./%" },
    python = { exec = "python3 ./%" },
}

vim.keymap.set("n", "<leader>r", function()
    local ft = vim.bo.filetype

    if langs[ft] and langs[ft].exec then
        runCmd(langs[ft].exec)
    end
end)

vim.keymap.set("n", "<leader>t", function()
    local ft = vim.bo.filetype
    if langs[ft] and langs[ft].test then
        runCmd(langs[ft].test)
    end
end)
