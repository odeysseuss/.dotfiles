return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        local Fugitive = vim.api.nvim_create_augroup("Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git("push")
                end, { buffer = bufnr, remap = false, desc = "Fugitive git push" })

                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({ "pull", "--rebase" })
                end, {
                    buffer = bufnr,
                    remap = false,
                    desc = "Fugitive git pull rebase",
                })

                vim.keymap.set(
                    "n",
                    "<leader>t",
                    ":Git push -u origin ",
                    { buffer = bufnr, remap = false, desc = "Fugitive git push to origin" }
                )
            end,
        })

        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Fugitive get remote" })
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Fugitive get local" })
    end,
}
