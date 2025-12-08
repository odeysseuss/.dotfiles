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
                yaml = { "yamlfmt" },
                toml = { "taplo" },
            },
            formatters = {
                ruff = {
                    command = "ruff",
                    args = { "format", "--stdin-filename", "$FILENAME" },
                    stdin = true,
                },
                typstyle = {
                    command = "typstyle",
                    args = { "-t", "4", "-i", "$FILENAME" },
                    stdin = false,
                },
            },
            vim.keymap.set("n", "<leader>f", function()
                require("conform").format({ bufnr = 0 })
            end),
        })
    end,
}
