return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
            vim.keymap.set("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph --parents<CR>", {})

            vim.api.nvim_create_autocmd("BufWinEnter", {
                group = vim.api.nvim_create_augroup("Fugitive", {}),
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= ("fugitive" or "git") then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { buffer = bufnr, remap = false }

                    vim.keymap.set("n", "<leader>p", "<cmd>Git push<CR>", opts)
                    vim.keymap.set("n", "<leader>P", "<cmd>Git pull --rebase<CR>", opts)
                end,
            })

            vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Git get remote diff" })
            vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Git get local diff" })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "+" },
                delete = { text = "_" },
                change = { text = "~" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
}
