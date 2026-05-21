local hl = {
    dark = "#1d2021",
    light = "#d5c4a1",
    black = "#111111",
    blue = "#80aa9e",
    green = "#b0b846",
    red = "#f2594b",
    yellow = "#e9b143",
    pink = "#d3869b",
    grey = "#a89984",
}

function ColorMyPencils()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = hl.dark })
    -- cmdline
    vim.api.nvim_set_hl(0, "MsgArea", { bg = hl.black, fg = hl.grey, bold = true })
    -- tabline
    vim.api.nvim_set_hl(0, "TabLine", { bg = hl.black, fg = hl.grey, bold = true })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = hl.black })
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = hl.blue, fg = hl.dark, bold = true })
    -- statusline
    vim.api.nvim_set_hl(0, "StatusStyle", { bg = hl.black, fg = hl.blue, bold = true })
    vim.api.nvim_set_hl(0, "StatusDiagERROR", { bg = hl.black, fg = hl.red })
    vim.api.nvim_set_hl(0, "StatusDiagWARN", { bg = hl.black, fg = hl.yellow })
    vim.api.nvim_set_hl(0, "StatusDiagINFO", { bg = hl.black, fg = hl.blue })
    vim.api.nvim_set_hl(0, "StatusDiagHINT", { bg = hl.black, fg = hl.pink })
    vim.api.nvim_set_hl(0, "StatusMode", { bg = hl.black, fg = hl.green, bold = true })
    vim.api.nvim_set_hl(0, "StatusBranch", { bg = hl.black, fg = hl.red, bold = true })
    -- cmp
    vim.api.nvim_set_hl(0, "PMenu", { bg = hl.black, fg = hl.light })
    vim.api.nvim_set_hl(0, "PMenuSel", { bg = hl.dark })
    vim.api.nvim_set_hl(0, "PMenuKind", { bg = hl.black, fg = hl.green })
    vim.api.nvim_set_hl(0, "PMenuThumb", { bg = hl.black, fg = hl.dark })
    vim.api.nvim_set_hl(0, "PMenuBorder", { bg = hl.black, fg = hl.dark })
end

vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_ui_contrast = "high"
vim.g.gruvbox_material_float_style = "bright"
vim.g.gruvbox_material_statusline_style = "material"
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_enable_italic = 1
