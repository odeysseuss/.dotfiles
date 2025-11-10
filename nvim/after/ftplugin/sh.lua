vim.opt_local.formatprg = "shfmt -i 4"
vim.keymap.set("n", "<leader>f", function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("silent! normal! ggVGgq")
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end, { buffer = true, desc = "Format entire file" })
