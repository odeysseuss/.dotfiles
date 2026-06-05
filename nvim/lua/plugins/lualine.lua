local colors = require("custom.colors")

local lualineTheme = function()
    local hl = colors.active
    return {
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
            a = { bg = hl.black, fg = hl.purple, gui = "bold" },
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
end

require("lualine").setup({
    options = {
        theme = lualineTheme,
        always_show_tabline = false,
        globalstatus = true,
        component_separators = "",
        section_separators = "",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
            -- {
            --     "filetype",
            --     icon_only = true,
            --     padding = { left = 1, right = 0 },
            -- },
            "filename",
        },
        lualine_x = { {
            "diagnostics",
            symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
            },
        } },
        lualine_y = { {
            "lsp_status",
            symbols = {
                done = "",
            },
        } },
        lualine_z = { "progress", "location" }
    },
    tabline = {
        lualine_c = { "filename" },
        lualine_z = { "tabs" },
    },
})
