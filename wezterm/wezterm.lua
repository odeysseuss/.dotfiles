local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false

config.line_height = 1.2
config.font_size = 20
config.font = wezterm.font({
    family = "Maple Mono NF",
    weight = "SemiBold",
    harfbuzz_features = {
        "cv03",
        "cv09",
        "cv10",
        "cv42",
        "cv43",
        "cv66",
        "ss03",
        "ss07",
        "ss08",
        "ss09",
        "ss10",
        "ss11",
        "zero",
    },
})

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE"
config.window_background_opacity = 0.8
config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
}

config.hyperlink_rules = {
    -- Matches: a URL in parens: (URL)
    {
        regex = "\\((\\w+://\\S+)\\)",
        format = "$1",
        highlight = 1,
    },
    -- Matches: a URL in square brackets: [URL]
    {
        regex = "\\[(\\w+://\\S+)\\]",
        format = "$1",
        highlight = 1,
    },
    -- Matches: a URL in curly braces: {URL}
    {
        regex = "\\{(\\w+://\\S+)\\}",
        format = "$1",
        highlight = 1,
    },
    -- Matches: a URL in angle brackets: <URL>
    {
        regex = "<(\\w+://\\S+)>",
        format = "$1",
        highlight = 1,
    },
    -- Then handle URLs not wrapped in brackets
    {
        regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
        format = "$1",
        highlight = 1,
    },
}

return config
