-- === File icons ===
function StatusFileIcon()
    local filename = vim.fn.expand("%:t")
    if filename == "" then
        return ""
    end

    -- -- nvim-web-devicons
    -- local extension = vim.fn.expand("%:e")
    -- local icon, icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    -- if icon then
    --     vim.api.nvim_set_hl(0, "StatusFile", { bg = "#111111", fg = icon_color, bold = true })
    --     return icon
    -- end

    local icon, hl = MiniIcons.get("file", filename)
    if icon then
        local fg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = hl }).fg)
        vim.api.nvim_set_hl(0, "StatusFile", { bg = "#111111", fg = fg, bold = true })
        return icon
    end

    return ""
end

-- === Diagnostics ===
local icons = {
    ERROR = " ",
    WARN = " ",
    -- WARN  = " ",
    INFO = " ",
    HINT = " ",
}

function StatusDiagErr()
    local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    return count > 0 and icons.ERROR .. count .. " " or ""
end

function StatusDiagWarn()
    local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    return count > 0 and icons.WARN .. count .. " " or ""
end

function StatusDiagInfo()
    local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    return count > 0 and icons.INFO .. count .. " " or ""
end

function StatusDiagHint()
    local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    return count > 0 and icons.HINT .. count .. " " or ""
end

--  === Mode name ===
function StatusMode()
    local mode_map = {
        n = "NORMAL",
        v = "VISUAL",
        V = "V-LINE",
        [""] = "V-BLOCK",
        i = "INSERT",
        R = "REPLACE",
        c = "COMMAND",
        t = "TERMINAL",
        s = "SELECT",
        S = "S-LINE",
        [""] = "S-BLOCK",
    }
    return " " .. (mode_map[vim.fn.mode()] or "ABNORMAL")
end

-- === Statusline ===
vim.o.statusline = table.concat({
    "%#StatusMode# %{v:lua.StatusMode()} ", -- mode name
    "%#StatusBranch# %{FugitiveStatusline()}", -- git branch
    "%#StatusFile# %{v:lua.StatusFileIcon()} %<%t%h%w%m%r ", -- file icon, name and flags
    "%=", -- right align

    -- diagnostics
    "%#StatusDiagERROR#%{v:lua.StatusDiagErr()}",
    "%#StatusDiagWARN#%{v:lua.StatusDiagWarn()}",
    "%#StatusDiagINFO#%{v:lua.StatusDiagInfo()}",
    "%#StatusDiagHINT#%{v:lua.StatusDiagHint()}",

    "%#StatusStyle# %l:%c %P ", -- line:column and percentage
})
