return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
        "--query-driver=/usr/bin/clang*",
    },
    filetypes = { "c", "cpp" },
    root_markers = {
        ".git/",
        ".xmake/",
        ".clangd",
        "compile_commands.json",
        "compile_flags.txt",
        "xmake.lua",
        "CMakeLists.txt",
        "Makefile",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
        fallbackFlags = {
            "-Wall",
            "-Wextra",
            "-pedantic",
        },
        InlayHints = {
            Designators = true,
            Enabled = true,
            ParameterNames = true,
            DeducedTypes = true,
        },
    },
}
