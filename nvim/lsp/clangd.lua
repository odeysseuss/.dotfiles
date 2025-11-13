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
            "-I" .. vim.fn.getcwd() .. "/include",
            "-Wall",
            "-Wextra",
            "-pedantic",
            "-D_GNU_SOURCE",
        },
        InlayHints = {
            Designators = true,
            Enabled = true,
            ParameterNames = true,
            DeducedTypes = true,
        },
    },
    on_new_config = function(new_config)
        local ft = vim.bo.filetype
        local std_flag = ft == "c" and "-std=c99" or "-std=c++17"

        new_config.init_options = new_config.init_options or {}
        new_config.init_options.fallbackFlags = new_config.init_options.fallbackFlags or {}

        table.insert(new_config.init_options.fallbackFlags, 1, std_flag)
    end,
}
