-- nvim treesitter
-- requirements: node, tree-sitter-cli
local treesitter = require("nvim-treesitter")
treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})
treesitter.install({
    "lua",
    "bash",
    "zsh",
    "c",
    "cpp",
    "rust",
    "vimdoc",
})

-- treesitter textobjects
require("nvim-treesitter-textobjects").setup()

local ts_swap = require("nvim-treesitter-textobjects.swap")
-- local select = require("nvim-treesitter-textobjects.select").select_textobject
-- local move = require("nvim-treesitter-textobjects.move")
-- local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")

vim.keymap.set("n", "[a", function() ts_swap.swap_next("@parameter.inner") end,
    { desc = "Treesitter: Swap next parameter" })
vim.keymap.set("n", "]a", function() ts_swap.swap_previous("@parameter.inner") end,
    { desc = "Treesitter: Swap previous parameter" })

-- treesitter context
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

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Treesitter: Jump to the current context" })
