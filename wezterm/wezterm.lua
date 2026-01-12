local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_background_opacity = 0.95
config.window_padding = {
    left = 10,
    right = 10,
    top = 5,
    bottom = 5,
}

config.default_cursor_style = "SteadyBlock"
config.force_reverse_video_cursor = true
config.colors = require("cyberdream")
config.window_background_gradient = {
    colors = {
        "#580a8f",
        "#1b1871",
        "#050507",
    },
    orientation = {
        Linear = { angle = 111.4 },
    },
}

config.line_height = 1.2
config.font_size = 16
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

return config
