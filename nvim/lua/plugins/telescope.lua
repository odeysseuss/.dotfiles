return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        -- prequisites
        -- ripgrep make
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },

    config = function()
        require("telescope").load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", function()
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

        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope keymaps" })
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope live grep" })

        vim.keymap.set("n", "<leader>w", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Telescope search word under cursor in CWD" })
        vim.keymap.set("n", "<leader>W", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Telescope search WORD (case sensitive) under cursor in CWD" })

        vim.keymap.set("n", "<leader>fd", function()
            builtin.find_files({ cwd = "~/.dotfiles/" })
        end, { desc = "Telescope find dotfiles" })
    end,
}
