return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJit",
            },
            hint = {
                enable = true,
            },
            diagnostics = {
                disable = {
                    "undefined-global",
                },
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    max_line_length = "100",
                },
            },
        },
    },
}
