return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter")
            treesitter.setup({
                install_dir = vim.fn.stdpath('data') .. '/site'
            })
            treesitter.install({
                "lua",
                "bash",
                "c",
                "cpp",
                "rust",
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        branch = "main",
        config = function()
            require("nvim-treesitter-textobjects").setup()
            -- local sel = require("nvim-treesitter-textobjects.select").select_textobject
            local ts_swap = require("nvim-treesitter-textobjects.swap")
            -- local ts_move = require("nvim-treesitter-textobjects.move")
            -- local tsrepeat = require("nvim-treesitter-textobjects.repeatable_move")

            vim.keymap.set("n", "<leader>si", function()
                ts_swap.swap_next "@parameter.inner"
            end)
            vim.keymap.set("n", "<leader>so", function()
                ts_swap.swap_previous "@parameter.inner"
            end)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
                on_attach = nil,
            })
        end,
    },
}
