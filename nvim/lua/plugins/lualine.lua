local hl = require("custom.colors")

local theme = {
    normal = {
        a = { bg = hl.black, fg = hl.green, gui = "bold" },
        b = { bg = hl.black, fg = hl.red, gui = "bold" },
        c = { bg = hl.black, fg = hl.blue, gui = "bold" },
        y = { bg = hl.black, fg = hl.blue, gui = "bold" },
        z = { bg = hl.black, fg = hl.blue, gui = "bold" },
    },
    insert = {
        a = { bg = hl.black, fg = hl.blue, gui = "bold" },
        z = { bg = hl.black, fg = hl.blue, gui = "bold" },
    },
    visual = {
        a = { bg = hl.black, fg = hl.pink, gui = "bold" },
        z = { bg = hl.black, fg = hl.blue, gui = "bold" },
    },
    replace = {
        a = { bg = hl.black, fg = hl.red, gui = "bold" },
        z = { bg = hl.black, fg = hl.blue, gui = "bold" },
    },
    command = {
        a = { bg = hl.black, fg = hl.yellow, gui = "bold" },
        z = { bg = hl.black, fg = hl.blue, gui = "bold" },
    },
}

require("lualine").setup({
    options = {
        theme = theme,
        always_show_tabline = false,
    },

    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = { "diagnostics" },
        lualine_y = { "filetype", "progress" },
        lualine_z = { "location" }
    },

    tabline = {
        lualine_c = { "filename" },
        lualine_z = { "tabs" }
    },
})
