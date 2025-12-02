return {
    "williamboman/mason.nvim",
    dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
        require("mason").setup()
        require("mason-tool-installer").setup({
            ensure_installed = {
                "lua-language-server",
                "bash-language-server",
                "rust-analyzer",
                -- "gopls",
                "typescript-language-server",
                -- "zls",
                -- "pyright",
                -- "tinymist",
                "biome",
                -- "typstyle",
                "shfmt",
                -- "ruff",
                "codelldb",
            },
            auto_update = true,
            run_on_start = true,
        })
    end,
}
