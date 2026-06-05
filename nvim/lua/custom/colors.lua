local M = {}

M.palettes = {
    gruvbox = {
        dark = "#1d2021",
        light = "#d5c4a1",
        black = "#111111",
        red = "#f2594b",
        green = "#b0b846",
        blue = "#80aa9e",
        yellow = "#e9b143",
        purple = "#d3869b",
        grey = "#a89984",
    },
    kanagawa = {
        dark = "#1d2021",
        light = "#c5c9c5",
        black = "#0d0c0c",
        red = "#c4746e",
        green = "#8a9a7b",
        blue = "#8ba4b0",
        yellow = "#c4b28a",
        purple = "#a292a3",
        grey = "#9e9b93",
    }
}

M.active = {}

function M.updatePallete()
    local current_scheme = vim.g.colors_name or "gruvbox-material"
    local palette = M.palettes[current_scheme] or M.palettes.gruvbox

    for k, v in pairs(palette) do
        M.active[k] = v
    end
end

M.updatePallete()

function M.colorMyPencils()
    local hl = M.active

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
    -- dap
    vim.api.nvim_set_hl(0, "NvimDapViewTab", { bg = hl.dark })
    vim.api.nvim_set_hl(0, "NvimDapViewTabSelected", { bg = hl.dark, fg = hl.light, bold = true })
    -- fzf-lua
    vim.api.nvim_set_hl(0, "FzfLuaBorder", { bg = hl.black, fg = hl.dark })
    vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { bg = hl.black, fg = hl.dark })
end

return M
