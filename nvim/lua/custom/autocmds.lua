vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
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
    desc = "Open help in vertical split",
    pattern = "man",
    callback = function()
        vim.opt_local.wrap = false
        vim.cmd("wincmd L")
    end,
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

vim.api.nvim_create_autocmd("FileType", {
    desc = "Dap Repl",
    group = vim.api.nvim_create_augroup("dap", { clear = true }),
    pattern = "*dap-repl*",
    callback = function()
        vim.b.completion = false
        vim.wo.wrap = true
    end
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Treesitter highlight, indent",
    group = vim.api.nvim_create_augroup("tree-sitter", { clear = true }),
    callback = function()
        local hasStarted = pcall(vim.treesitter.start)
        if hasStarted then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end
})

vim.api.nvim_create_autocmd("BufRead", {
    desc = "Auto install parsers",
    group = "tree-sitter",
    callback = function(event)
        local bufnr = event.buf
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

        if filetype == "" then
            return
        end

        local parser_name = vim.treesitter.language.get_lang(filetype)
        if not parser_name then
            return
        end

        local parser_configs = require("nvim-treesitter.parsers")
        if not parser_configs[parser_name] then
            return -- parser not available, skip silently
        end

        require("nvim-treesitter").install({ parser_name })
    end,
})
