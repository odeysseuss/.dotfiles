local gh = "https://github.com/"

vim.pack.add({
    { src = gh .. "sainnhe/gruvbox-material",                    name = "gruvbox" },
    { src = gh .. "nvim-mini/mini.icons",                        name = "icons" },
    { src = gh .. "stevearc/oil.nvim",                           name = "oil" },
    { src = gh .. "ibhagwan/fzf-lua",                            name = "fzflua" },
    { src = gh .. "mg979/vim-visual-multi",                      name = "multicursor" },
    { src = gh .. "folke/flash.nvim",                            name = "flash" },
    { src = gh .. "j-hui/fidget.nvim",                           name = "fidget" },
    { src = gh .. "mbbill/undotree",                             name = "undotree" },
    -- treesitter
    { src = gh .. "nvim-treesitter/nvim-treesitter",             name = "treesitter" },
    { src = gh .. "nvim-treesitter/nvim-treesitter-textobjects", name = "ts-textobjects" },
    { src = gh .. "nvim-treesitter/nvim-treesitter-context",     name = "ts-context" },
    -- harpoon
    {
        src = gh .. "ThePrimeagen/harpoon",
        name = "harpoon",
        version = "harpoon2",
    },
    { src = gh .. "nvim-lua/plenary.nvim",   name = "plenary" },
    -- git
    { src = gh .. "NeogitOrg/neogit",        name = "neogit" },
    { src = gh .. "lewis6991/gitsigns.nvim", name = "gitsigns" },
    { src = gh .. "sindrets/diffview.nvim",  name = "diffview" },
    -- cmp
    {
        src = gh .. "saghen/blink.cmp",
        name = "blink",
        version = vim.version.range("1.*")
    },
    { src = gh .. "rafamadriz/friendly-snippets", name = "friendly-snippets" },
    { src = gh .. "L3MON4D3/LuaSnip",             name = "luasnip" },
    -- dap
    { src = gh .. "mfussenegger/nvim-dap",        name = "dap" },
    { src = gh .. "igorlfs/nvim-dap-view",        name = "dap-view" },
    { src = gh .. "Jorenar/nvim-dap-disasm",      name = "dap-disasm" },
})

-- mini.icons
require("mini.icons").setup({})
require("mini.icons").mock_nvim_web_devicons()

-- git
vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit, { desc = "Open Neogit UI" })
vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>",
    { desc = "Preview Gitsigns inline diff" })

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree toggle" })

-- plugin configs
require("plugins.cmp")
require("plugins.colors")
require("plugins.dap")
require("plugins.flash")
require("plugins.fzf")
require("plugins.harpoon")
require("plugins.luasnip")
require("plugins.oil")
require("plugins.treesitter")
