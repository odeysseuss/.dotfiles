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
    -- cmp
    vim.api.nvim_set_hl(0, "PMenu", { bg = hl.black, fg = hl.light })
    vim.api.nvim_set_hl(0, "PMenuSel", { bg = hl.dark })
    vim.api.nvim_set_hl(0, "PMenuKind", { bg = hl.black, fg = hl.green })
    vim.api.nvim_set_hl(0, "PMenuThumb", { bg = hl.black, fg = hl.dark })
    vim.api.nvim_set_hl(0, "PMenuBorder", { bg = hl.black, fg = hl.dark })
    -- blink
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = hl.black, fg = hl.dark })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = hl.black, fg = hl.dark })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = hl.dark })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = hl.black, fg = hl.dark })
    -- Dap
    vim.api.nvim_set_hl(0, "NvimDapViewTab", { bg = hl.bg })
    vim.api.nvim_set_hl(0, "NvimDapViewTabSelected", { bg = hl.bg, fg = hl.fg, bold = true })
end

return hl
