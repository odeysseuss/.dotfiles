require("oil").setup({
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    columns = {
        "icon",
        "permissions",
    },
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set("n", "<leader>o", vim.cmd.Oil, { desc = "Oil" })
