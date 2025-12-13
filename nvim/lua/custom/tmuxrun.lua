local command_pane = nil

-- execute tmux commands in the background
local function execute_tmux_command(tmux_cmd, callback)
    vim.notify("[CMD]: " .. tmux_cmd, vim.log.levels.INFO, {})
    vim.fn.jobstart(tmux_cmd, {
        on_exit = function(_, exit_code)
            if callback then
                vim.schedule(callback)
            end
            if exit_code == 0 then
                vim.notify("[OK]: " .. tmux_cmd, vim.log.levels.INFO, {})
            else
                vim.notify("[FAIL]: " .. tmux_cmd, vim.log.levels.ERROR, {})
            end
        end,
    })
end

function SendToTmux(cmd)
    cmd = cmd:gsub("%%", vim.fn.expand("%"))

    if not command_pane or vim.fn.system("tmux list-panes -F '#{pane_id}' | wc -l") == "1\n" then
        execute_tmux_command("tmux split-window -v -c '#{pane_current_path}' -d", function()
            execute_tmux_command(string.format("tmux send-keys -t %s 'clear && %s' C-m", command_pane or ".1", cmd))
        end)
        command_pane = ".1"
    else
        execute_tmux_command(string.format("tmux send-keys -t %s 'clear && %s' C-m", command_pane, cmd))
    end
end

function KillPane()
    if command_pane then
        vim.fn.jobstart("tmux kill-pane -t " .. command_pane, {
            on_exit = function()
                vim.schedule(function()
                    command_pane = nil
                    vim.notify("Tmux pane killed", vim.log.levels.INFO, {})
                end)
            end,
        })
    end
end

-- nvim commands
vim.api.nvim_create_user_command("TmuxRunCmd", function(opts)
    SendToTmux(opts.args)
end, { nargs = "+" })

-- run visually selected line in tmux
vim.api.nvim_create_user_command("TmuxSendRange", function(opts)
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    local cmd = table.concat(lines, " ")
    SendToTmux(cmd)
end, { range = true })

vim.api.nvim_create_user_command("TmuxKillPane", function()
    KillPane()
end, {})

vim.keymap.set("n", "<leader>X", "<cmd>TmuxKillPane<CR>", { desc = "Tmux kill pane" })
vim.keymap.set("v", "<leader>R", "<cmd>TmuxSendRange<CR>", { desc = "Tmux send visual selection" })
