return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    init_options = {
        analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
        },
    },
}
