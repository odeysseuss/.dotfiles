-- git branch
function StatusGitHead()
    local branch = vim.b.gitsigns_head
    if not branch then return "" end

    return "󰊢 " .. branch
end

-- file icons
function StatusFileIcon()
    local filename = vim.fn.expand("%:t")
    if filename == "" then
        return ""
    end

    ---@diagnostic disable-next-line: undefined-global
    local icon, hl = MiniIcons.get("file", filename)
    if icon then
        local fg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = hl }).fg)
        vim.api.nvim_set_hl(0, "StatusFile", { bg = "#111111", fg = fg, bold = true })
        return icon
    end

    return ""
end

-- diagnostics
local icons = {
    ERROR = " ",
    WARN = " ",
    INFO = " ",
    HINT = " ",
}

function StatusDiag(severity_str)
    local severity = vim.diagnostic.severity[severity_str]
    if not severity then return "" end

    local count = #vim.diagnostic.get(0, { severity = severity })
    if count == 0 then return "" end

    local icon = icons[severity_str] or ""

    return icon .. count .. " "
end

--  mode name
function StatusMode()
    local mode_map = {
        n = "NORMAL",
        v = "VISUAL",
        V = "V-LINE",
        [""] = "V-BLOCK",
        i = "INSERT",
        c = "COMMAND",
        t = "TERMINAL",
        R = "REPLACE",
        s = "SELECT",
        S = "S-LINE",
        [""] = "S-BLOCK",
    }
    return " " .. (mode_map[vim.fn.mode()] or "ABNORMAL")
end

-- === Statusline ===
vim.opt.statusline = table.concat({
    "%#StatusMode# %{v:lua.StatusMode()}",                  -- mode name
    "%#StatusBranch# %{v:lua.StatusGitHead()}",
    "%#StatusFile# %{v:lua.StatusFileIcon()} %<%t%h%w%m%r", -- file icon, name and flags
    "%=",                                                   -- right align

    -- diagnostics
    "%#StatusDiagERROR#%{v:lua.StatusDiag('ERROR')}",
    "%#StatusDiagWARN#%{v:lua.StatusDiag('WARN')}",
    "%#StatusDiagINFO#%{v:lua.StatusDiag('INFO')}",
    "%#StatusDiagHINT#%{v:lua.StatusDiag('HINT')}",

    "%#StatusStyle# %l:%c %P ", -- line:column and percentage
})
