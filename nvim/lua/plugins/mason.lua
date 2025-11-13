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
                "cmake-language-server",
                "rust-analyzer",
                "gopls",
                "zls",
                "pyright",
                "tinymist",
                "typstyle",
                "shfmt",
                "ruff",
                "codelldb",
            },
            auto_update = true,
            run_on_start = true,
        })
    end,
}
