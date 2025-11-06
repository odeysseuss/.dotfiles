function Navigate(direction)
    local current_win = vim.api.nvim_get_current_win()

    vim.cmd('wincmd ' .. direction)
    local new_win = vim.api.nvim_get_current_win()

    if current_win == new_win and vim.env.TMUX then
        local directions = { h = 'L', j = 'D', k = 'U', l = 'R' }
        local cmd = 'tmux select-pane -' .. directions[direction]
        vim.fn.system(cmd)
    end
end

vim.keymap.set('n', '<C-h>', '<cmd>lua Navigate("h")<cr>', { silent = true })
vim.keymap.set('n', '<C-j>', '<cmd>lua Navigate("j")<cr>', { silent = true })
vim.keymap.set('n', '<C-k>', '<cmd>lua Navigate("k")<cr>', { silent = true })
vim.keymap.set('n', '<C-l>', '<cmd>lua Navigate("l")<cr>', { silent = true })

vim.keymap.set('t', '<C-h>', '<C-\\><C-n><cmd>lua Navigate("h")<cr>', { silent = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><cmd>lua Navigate("j")<cr>', { silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><cmd>lua Navigate("k")<cr>', { silent = true })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><cmd>lua Navigate("l")<cr>', { silent = true })
