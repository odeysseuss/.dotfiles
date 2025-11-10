vim.lsp.enable({
    "lua_ls",
    "bashls",
    "clangd",
    "cmake",
    "rust_analyzer",
    "tinymist",
})

local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require("blink.cmp").get_lsp_capabilities()
)

vim.lsp.config("*", {
    capabilities = capabilities,
    root_markers = {
        "Session.vim", ".git/"
    },
})

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = {
                disable = {
                    "undefined-global",
                },
            },
            runtime = {
                version = "LuaJit",
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
})

vim.lsp.config("bashls", {
    cmd = {
        "bash-language-server",
        "start",
    },
    filetypes = { "sh", "zsh" },
})

vim.lsp.config("clangd", {
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
    },
    on_new_config = function(new_config)
        local ft = vim.bo.filetype
        local std_flag = ft == "c" and "-std=c99" or "-std=c++17"

        new_config.init_options = new_config.init_options or {}
        new_config.init_options.fallbackFlags = new_config.init_options.fallbackFlags or {}

        table.insert(new_config.init_options.fallbackFlags, 1, std_flag)
    end,
})

vim.lsp.config("cmake", {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    init_options = {
        buildDirectory = 'build',
    },
})

vim.lsp.config("rust_analyzer", {
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
})

vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go" },
    root_markers = {
        ".git/",
        "go.mod",
        "go.sum",
    },
})

vim.lsp.config("zls", {
    cmd = { "zls" },
    filetypes = { "zig" },
})

vim.lsp.config("tinymist", {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    settings = {
        formatterMode = "typstyle",
        formatterIndentSize = 4,
        exportPdf = "never",
        semanticTokens = "disable",
    },
})

-- diagnostic
vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
