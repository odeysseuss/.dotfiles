--- @diagnostic disable: missing-fields
--- @diagnostic disable: missing-parameter

return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        require("nvim-dap-virtual-text").setup()
        local dap = require("dap")
        dap.set_log_level("DEBUG")
        local dapui = require("dapui")
        dapui.setup({
            layouts = {
                {
                    elements = {
                        {
                            id = "stacks",
                            size = 0.33,
                        },
                        {
                            id = "watches",
                            size = 0.33,
                        },
                        {
                            id = "scopes",
                            size = 0.34,
                        },
                    },
                    position = "right",
                    size = 40,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.5,
                        },
                        {
                            id = "console",
                            size = 0.5,
                        },
                    },
                    position = "bottom",
                    size = 10,
                },
            },
        })

        dap.adapters.codelldb = {
            type = "executable",
            command = "codelldb",
        }

        dap.configurations.c = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                console = "integratedTerminal",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Attach",
                type = "codelldb",
                request = "attach",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                pid = function()
                    local name = vim.fn.input("Executable name (filter): ")
                    return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = "${workspaceFolder}",
                console = "integratedTerminal",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Remote",
                type = "codelldb",
                request = "attach",
                target = "localhost:1234",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                console = "integratedTerminal",
                stopAtBeginningOfMainSubprogram = false,
            },
        }

        dap.configurations.cpp = dap.configurations.c
        dap.configurations.rust = dap.configurations.c
        dap.configurations.zig = dap.configurations.c

        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Dap continue" })
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Dap set breakpoint" })
        vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Dap set conditional breakpoint" })
        vim.keymap.set("n", "<leader>de", function()
            dapui.eval()
        end, { desc = "Dap evaluate expression" })
        vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Dap step over" })
        vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Dap step into" })
        vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Dap step out" })

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
        dap.listeners.after.event_output.dapui_config = function(_, body)
            if body.category == "console" then
                dapui.eval(body.output) -- sends stdout/stderr to Console
            end
        end
    end,
}
