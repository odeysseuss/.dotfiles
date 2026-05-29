-- gruvbox
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_ui_contrast = "high"
vim.g.gruvbox_material_float_style = "bright"
vim.g.gruvbox_material_statusline_style = "material"
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_enable_italic = 0

-- kanagawa
require('kanagawa').setup({
    compile = true,
    commentStyle = { italic = false },
    functionStyle = {},
    keywordStyle = { italic = false },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = false,
    terminalColors = true,
    theme = "dragon",
    background = {
        dark = "dragon",
        light = "wave"
    },
})
