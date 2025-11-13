return {
    cmd = {
        "rustup",
        "run",
        "stable",
        "rust-analyzer",
    },
    filetypes = { "rust" },
    root_markers = {
        ".git/",
        "Cargo.toml",
        "Cargo.lock",
    },
    init_options = {
        inlayHints = {
            bindingModeHints = {
                enable = false,
            },
            chainingHints = {
                enable = true,
            },
            closingBraceHints = {
                enable = true,
                minLines = 25,
            },
            closureReturnTypeHints = {
                enable = "never",
            },
            lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
            },
            maxLength = 25,
            parameterHints = {
                enable = true,
            },
            reborrowHints = {
                enable = "never",
            },
            renderColons = true,
            typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
            },
        },
    },
}
