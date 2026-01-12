return {
    "Jorenar/nvim-dap-disasm",
    dependencies = {
        "mfussenegger/nvim-dap",
        "igorlfs/nvim-dap-view",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        require("nvim-dap-virtual-text").setup({})
        local dap = require("dap")
        dap.set_log_level("DEBUG")

        dap.adapters.codelldb = {
            type = "executable",
            command = "codelldb",
        }

        local codelldb_defaults = {
            type = "codelldb",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            stopAtBeginningOfMainSubprogram = false,
            initCommands = { "settings set target.x86-disassembly-flavor intel" },
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
        }

        dap.configurations.c = {
            vim.tbl_deep_extend("force", codelldb_defaults, {
                name = "Launch",
                request = "launch",
            }),

            vim.tbl_deep_extend("force", codelldb_defaults, {
                name = "Attach",
                request = "attach",
                pid = function()
                    local name = vim.fn.input("Executable name (filter): ")
                    return require("dap.utils").pick_process({ filter = name })
                end,
            }),

            vim.tbl_deep_extend("force", codelldb_defaults, {
                name = "Remote",
                request = "attach",
                target = "localhost:1234",
            }),
        }

        dap.configurations.cpp = dap.configurations.c
        dap.configurations.rust = dap.configurations.c
        dap.configurations.zig = dap.configurations.c

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Nvim-Dap set breakpoint" })
        vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Nvim-Dap set conditional breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Nvim-Dap continue" })
        vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Nvim-Dap step into function" })
        vim.keymap.set("n", "<F2>", dap.step_out, { desc = "Nvim-Dap step out of function" })
        vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Nvim-Dap step over function" })
        vim.keymap.set("n", "<F4>", dap.step_back, { desc = "Nvim-Dap step back" })
        vim.keymap.set("n", "<F12>", dap.restart, { desc = "Nvim-Dap restart" })

        require("dap-view").setup({
            winbar = {
                show = true,
                sections = {
                    "repl",
                    "scopes",
                    "watches",
                    "exceptions",
                    "breakpoints",
                    "threads",
                    "disassembly",
                    -- "sessions",
                },
            },
            windows = {
                size = 0.40,
                position = "right",
                terminal = {
                    size = 0.30,
                    position = "below",
                },
            },
            auto_toggle = true,
        })

        require("dap-disasm").setup({
            dapview_register = true,
            repl_commands = true,
            sign = "DapStopped",
            ins_before_memref = 16,
            ins_after_memref = 32,
            controls = {
                step_into = "Step Into",
                step_over = "Step Over",
                step_back = "Step Back",
            },
            columns = {
                -- "address",
                -- "instructionBytes",
                "instruction",
            },
        })
    end,
}
