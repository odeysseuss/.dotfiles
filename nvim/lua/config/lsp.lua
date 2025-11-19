vim.lsp.enable({
    "lua_ls",
    "bashls",
    "clangd",
    "rust_analyzer",
    "gopls",
    "zls",
    "pyright",
    "tinymist",
})

local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require("blink.cmp").get_lsp_capabilities()
)

vim.lsp.config("*", {
    capabilities = capabilities,
    root_markers = {
        ".git",
        ".gitignore",
        ".editorconfig",
    },
})

-- on attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
        else
            -- via formatprg
            vim.keymap.set("n", "<leader>f", function()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                vim.cmd("silent! normal! ggVGgq")
                vim.api.nvim_win_set_cursor(0, cursor_pos)
            end, { buffer = true, desc = "Format entire file" })
        end
        if client:supports_method("textDocument/foldingRange") then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
        if client:supports_method("textDocument/inlayHint") then
            vim.keymap.set("n", "<leader>h", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { desc = "Toggle inlay hints" })
        end
    end,
})


-- diagnostic
vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
