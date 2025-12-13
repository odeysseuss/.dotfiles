return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        require("conform").setup({
            format_on_save = {
                timeout_ms = 5000,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                lua = { "stylua" },
                rust = { "rustfmt" },
                python = { "ruff" },
                sh = { "shfmt" },
                zsh = { "shfmt" },
                typst = { "typstyle" },
                json = { "biome" },
                jsonc = { "biome" },
                css = { "biome" },
                yaml = { "yamlfmt" },
                toml = { "taplo" },
            },
            formatters = {
                typstyle = {
                    append_args = { "-t", "4" },
                },
            },
            vim.keymap.set("n", "<leader>f", function()
                require("conform").format({ bufnr = 0 })
            end),
        })
    end,
}
