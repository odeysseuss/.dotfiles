---@diagnostic disable: undefined-global
local fzf = require("fzf-lua")

fzf.setup({
    defaults = {
        file_icons = "mini",
    },

    actions = {
        files = {
            ["enter"]  = FzfLua.actions.file_edit_or_qf,
            ["ctrl-s"] = FzfLua.actions.file_split,
            ["ctrl-v"] = FzfLua.actions.file_vsplit,
            ["ctrl-q"] = {
                fn = FzfLua.actions.file_sel_to_qf,
                prefix = "select-all"
            },
        },
    },
})

vim.keymap.set("n", "<leader>ff", function() fzf.files() end,
    { desc = "FzfLua: Search Files" })
vim.keymap.set("n", "<leader>fb", function() fzf.buffers() end,
    { desc = "FzfLua: Search Buffers" })

vim.keymap.set("n", "<leader>fh", function() fzf.help_tags() end,
    { desc = "FzfLua: Search help tags" })
vim.keymap.set("n", "<leader>fm", function() fzf.manpages() end,
    { desc = "FzfLua: Search manpages" })

vim.keymap.set("n", "<leader>fk", function() fzf.keymaps() end,
    { desc = "FzfLua: Search keymaps" })

vim.keymap.set("n", "<leader>gw", function() fzf.git_worktrees() end,
    { desc = "FzfLua: Search git worktrees" })

vim.keymap.set("n", "<leader>G", function() fzf.live_grep() end,
    { desc = "FzfLua: Live grep current project" })
vim.keymap.set("n", "<leader>w", function() fzf.grep_cword() end,
    { desc = "FzfLua: Grep word under cursor" })
vim.keymap.set("n", "<leader>W", function() fzf.grep_cWORD() end,
    { desc = "FzfLua: Grep WORD under cursor" })
