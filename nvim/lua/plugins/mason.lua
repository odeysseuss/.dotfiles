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
                "tinymist",
                "typstyle",
                "zls",
                "codelldb",
                "shfmt",
            },
            auto_update = true,
            run_on_start = true,
        })
    end,
}
