--- @diagnostic disable: unused-local

return {
    "L3MON4D3/LuaSnip",
    config = function()
        require("luasnip").setup({ enable_autosnippets = true })
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node

        vim.keymap.set({ "i", "s" }, "<C-j>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-k>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })
    end,
}
