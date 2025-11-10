local border = "#1d2021"
local status_bg = "#121618"
local status_fg = "#928374"
local cmd_fg = "#a89984"
local error_fg = "#f2594b"
local warn_fg = "#e9b143"
local info_fg = "#80aa9e"
local hint_fg = "#d3869b"

function ColorMyPencils()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = border })
    -- Cmd
    vim.api.nvim_set_hl(0, "MsgArea", { bg = status_bg, fg = cmd_fg, bold = true })
    -- Cmp
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none", fg = border })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none", fg = border })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = border })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "none", fg = border })
    -- Statusline
    vim.api.nvim_set_hl(0, "StatusStyle", { bg = status_bg, fg = status_fg, bold = true })
    vim.api.nvim_set_hl(0, "StatusDiagERROR", { bg = status_bg, fg = error_fg })
    vim.api.nvim_set_hl(0, "StatusDiagWARN", { bg = status_bg, fg = warn_fg })
    vim.api.nvim_set_hl(0, "StatusDiagINFO", { bg = status_bg, fg = info_fg })
    vim.api.nvim_set_hl(0, "StatusDiagHINT", { bg = status_bg, fg = hint_fg })
end

return {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_transparent_background = 1
        vim.g.gruvbox_material_foreground = "mix"
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_ui_contrast = "high"
        vim.g.gruvbox_material_float_style = "bright"
        vim.g.gruvbox_material_statusline_style = "material"
        vim.g.gruvbox_material_cursor = "aqua"
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_disable_italic_comment = 1
        -- vim.g.gruvbox_material_enable_italic = 1
    end,
}
