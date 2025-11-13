return {
    cmd = { "gopls" },
    filetypes = { "go" },
    root_markers = {
        ".git/",
        "go.mod",
        "go.sum",
    },
    init_options = {
        hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
        },
    },
}
