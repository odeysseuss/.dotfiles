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
