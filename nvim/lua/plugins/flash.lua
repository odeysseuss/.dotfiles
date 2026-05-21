vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump({
        remote_op = {
            restore = true,
            motion = nil,
        }
    })
end, { desc = "Flash: Flash jump with remote op" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end, { desc = "Flash: Flash Treesitter select" })
