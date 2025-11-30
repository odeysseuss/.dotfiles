return {
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    opts = {
        signs = {
            add = { text = '+' },
            delete = { text = '_' },
            change = { text = '~' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
    },
}
