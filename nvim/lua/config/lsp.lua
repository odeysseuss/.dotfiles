vim.lsp.enable({
    "lua_ls",
    "bashls",
    "clangd",
    "rust_analyzer",
    "gopls",
    "ts_ls",
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

        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "ge", vim.diagnostic.open_float)

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
                if client:supports_method("textDocument/formatting") then
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end
            end,
        })

        if client:supports_method("textDocument/foldingRange") then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true)
        end

        -- if client:supports_method("textDocument/completion") then
        --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        -- end
    end,
})

-- diagnostic
vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
    jump = {
        on_jump = function(_, bufnr)
            vim.diagnostic.open_float({
                bufnr = bufnr,
                scope = "cursor",
                focus = false,
            })
        end,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },

    vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist)
})
