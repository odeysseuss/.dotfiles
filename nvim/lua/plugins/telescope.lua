return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },

    config = function()
        require("telescope").load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sj", function()
            builtin.find_files({
                find_command = {
                    "rg",
                    "--files",
                    "--hidden",
                    "--glob",
                    "!**/.git/*",
                },
                file_ignore_patterns = { "^.git/", "^node_modules/" },
            })
        end, { desc = "Telescope find files" })

        vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Telescope keymaps" })
        vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "Telescope command history" })

        vim.keymap.set("n", "<leader>sw", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Telescope search word under cursor in CWD" })
        vim.keymap.set("n", "<leader>sW", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Telescope search WORD (case sensitive) under cursor in CWD" })

        vim.keymap.set("n", "<leader>sl", function()
            builtin.find_files({ cwd = "~/.dotfiles/" })
        end, { desc = "Telescope find dotfiles" })
    end,
}
