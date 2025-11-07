vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Open help in vertical split",
    pattern = "help",
    command = "wincmd L",
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Don't continue auto comment",
    callback = function()
        vim.opt_local.formatoptions:remove({ "o" })
    end
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Sync nvim with the terminal",
    command = "wincmd ="
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    desc = "Show active cursorline",
    group = vim.api.nvim_create_augroup("active-cursorline", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    desc = "Hide inactive cursorline",
    group = "active-cursorline",
    callback = function()
        vim.opt_local.cursorline = false
    end
})
