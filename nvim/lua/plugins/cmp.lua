return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
        },
    },

    version = "1.*",

    opts = {
        keymap = { preset = "enter" },
        term = { enabled = false },
        snippets = { preset = "luasnip" },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        completion = {
            menu = {
                min_width = 25,
                border = "rounded",
                scrollbar = false,
                draw = {
                    treesitter = { "lsp" },
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "kind" },
                    },
                },
            },
            documentation = {
                auto_show = false,
                treesitter_highlighting = true,
                window = { border = "rounded" },
            },
        },
        cmdline = {
            completion = { menu = { auto_show = true } },
        },
        signature = { enabled = true },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "omni" },
            -- providers = {
            --     cmdline = {
            --         enabled = function()
            --             return vim.fn.getcmdtype() ~= ":"
            --                 or not (
            --                     vim.fn.getcmdline():match("^term")
            --                     or vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
            --                     or vim.fn.getcmdline():match("^checkhealth")
            --                 )
            --         end,
            --     },
            -- },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
}
