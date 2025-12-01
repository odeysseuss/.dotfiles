local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE"
config.window_background_opacity = 0.9
config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
}

config.force_reverse_video_cursor = true
config.colors = require("cyberdream")
config.window_background_gradient = {
    colors = {
        "#070709",
        "#1b1871",
        "#580a8f",
    },
    orientation = {
        Linear = { angle = 111.4 }
    },
}

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

config.hyperlink_rules = {
    -- Match URLs within brackets
    {
        regex = "[\\(\\[\\{<](\\w+://\\S+)[\\)\\]\\}>]",
        format = "$1",
        highlight = 1,
    },
    -- Match bare URLs
    {
        regex = "\\b(\\w+://[\\S]+[a-zA-Z0-9/])",
        format = "$1",
        highlight = 1,
    },
    -- Match email addresses
    {
        regex = "\\b\\w+@[\\w-]+\\.[a-z]{2,}\\b",
        format = "mailto:$0",
    },
}

return config
