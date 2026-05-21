local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>A", function() harpoon:list():add() end,
    { desc = "Harpoon: Add file to harpoon list" })
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "Harpoom: Toggle harpoon UI" })

vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end,
    { desc = "Harpoon: Jump to first item in the list" })
vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end,
    { desc = "Harpoon: Jump to second item in the list" })
vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end,
    { desc = "Harpoon: Jump to third item in the list" })
vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end,
    { desc = "Harpoon: Jump to fourth item in the list" })
