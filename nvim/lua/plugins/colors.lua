local dark = "#1d2021"

local status = {
    bg = "#111111",
    fg = "#80aa9e",
    mode = "#b0b846",
    branch = "#f2594b",
    error = "#f2594b",
    warn = "#e9b143",
    info = "#80aa9e",
    hint = "#d3869b",
    cmd = "#a89984",
}

function ColorMyPencils()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = dark })
    -- Cmd
    vim.api.nvim_set_hl(0, "MsgArea", { bg = status.bg, fg = status.cmd, bold = true })
    -- Statusline
    vim.api.nvim_set_hl(0, "StatusStyle", { bg = status.bg, fg = status.fg, bold = true })
    vim.api.nvim_set_hl(0, "StatusDiagERROR", { bg = status.bg, fg = status.error })
    vim.api.nvim_set_hl(0, "StatusDiagWARN", { bg = status.bg, fg = status.warn })
    vim.api.nvim_set_hl(0, "StatusDiagINFO", { bg = status.bg, fg = status.info })
    vim.api.nvim_set_hl(0, "StatusDiagHINT", { bg = status.bg, fg = status.hint })
    vim.api.nvim_set_hl(0, "StatusMode", { bg = status.bg, fg = status.mode, bold = true })
    vim.api.nvim_set_hl(0, "StatusBranch", { bg = status.bg, fg = status.branch, bold = true })
    -- Cmp
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none", fg = dark })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none", fg = dark })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = dark })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "none", fg = dark })
    -- Dap
    vim.api.nvim_set_hl(0, "NvimDapViewTab", { bg = status.bg })
    vim.api.nvim_set_hl(0, "NvimDapViewTabSelected", { bg = status.bg, fg = status.fg, bold = true })
end

return {
    {
        "sainnhe/gruvbox-material",
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_foreground = "mix"
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_ui_contrast = "high"
            vim.g.gruvbox_material_float_style = "bright"
            vim.g.gruvbox_material_statusline_style = "material"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_disable_italic_comment = 1
            vim.g.gruvbox_material_enable_italic = 1
        end,
    },
}
