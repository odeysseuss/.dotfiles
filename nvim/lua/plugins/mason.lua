return {
    "mason-org/mason.nvim",
    dependencies = {
        -- prequisites:
        -- make npm python-venv unzip wget
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {},
    config = function()
        require("mason").setup()
        require("mason-tool-installer").setup({
            ensure_installed = {
                "clangd",
                "lua-language-server",
                "bash-language-server",
                "rust-analyzer",
                -- "gopls",
                -- "typescript-language-server",
                -- "zls",
                -- "pyright",
                -- "tinymist",

                "clang-format",
                "stylua",
                "shfmt",
                "taplo",
                "yamlfmt",
                -- "biome",
                -- "typstyle",
                -- "ruff",

                "codelldb",
            },
        })
    end,
}
