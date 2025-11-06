vim.opt_local.linebreak = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.conceallevel = 2

vim.keymap.set("n", "<leader>b", function()
    local word = vim.fn.expand("<cWORD>")
    vim.cmd("spellgood " .. word)
end, {})
