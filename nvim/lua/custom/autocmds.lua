local colors = require("custom.colors")

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ThemeCustomOverrides", { clear = true }),
    callback = function()
        colors.updatePallete()
        colors.colorMyPencils()

        package.loaded["lualine"] = nil
        local lualine = require("lualine")
        lualine.setup(lualine.get_config())
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("editing", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Sync nvim with the terminal",
    group = vim.api.nvim_create_augroup("windows", { clear = true }),
    command = "wincmd =",
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    desc = "Show active cursorline",
    group = vim.api.nvim_create_augroup("cursorline", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    desc = "Hide inactive cursorline",
    group = "cursorline",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Disable completion in dap-repl",
    group = vim.api.nvim_create_augroup("dap", { clear = true }),
    pattern = { "*dap-repl*", "*dap-disassembly*" },
    callback = function()
        vim.opt_local.completion = false
        vim.opt_local.wrap = true
    end,
})

local langs = {
    ["c"] = "make -j$(nproc)",
    ["cpp"] = "make -j$(nproc)",
    ["rust"] = "cargo build",
}

local dev_group = vim.api.nvim_create_augroup("dev", { clear = true })

for ft, cmd in pairs(langs) do
    vim.api.nvim_create_autocmd("FileType", {
        desc = "Define makeprg for languages",
        group = dev_group,
        pattern = ft,
        command = "setlocal makeprg=" .. vim.fn.escape(cmd, " ")
    })
end

vim.api.nvim_create_autocmd("FileType", {
    desc = "Treesitter highlight, indent",
    group = vim.api.nvim_create_augroup("tree-sitter", { clear = true }),
    callback = function()
        local has_started = pcall(vim.treesitter.start)
        if has_started then
            vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
