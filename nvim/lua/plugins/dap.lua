vim.api.nvim_create_augroup("DapGroup", { clear = true })

local function navigate(args)
    local buffer = args.buf

    local wid = nil
    local win_ids = vim.api.nvim_list_wins() -- Get all window IDs
    for _, win_id in ipairs(win_ids) do
        local win_bufnr = vim.api.nvim_win_get_buf(win_id)
        if win_bufnr == buffer then
            wid = win_id
        end
    end

    if wid == nil then
        return
    end

    vim.schedule(function()
        if vim.api.nvim_win_is_valid(wid) then
            vim.api.nvim_set_current_win(wid)
        end
    end)
end

local function create_nav_options(name)
    return {
        group = "DapGroup",
        pattern = string.format("*%s*", name),
        callback = navigate
    }
end

return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    lazy = false,
    config = function()
        require("nvim-dap-virtual-text").setup()
        local dap = require("dap")
        local dapui = require("dapui")
        dap.set_log_level("DEBUG")

        dap.adapters.gdb = {
            type = "executable",
            command = "/usr/bin/gdb",
            args = { "--interpreter=dap", "-q" },
        }

        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtEntry = true,
            },
        }

        dap.configurations.cpp = dap.configurations.c

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Dap set breakpoint" })
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Dap set conditional breakpoint" })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Dap continue" })
        vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Dap step over" })
        vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Dap step into" })
        vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Dap step out" })

        local function layout(name)
            return {
                elements = {
                    { id = name },
                },
                enter = true,
                size = .40,
                position = "bottom",
            }
        end
        local name_to_layout = {
            repl = { layout = layout("repl"), index = 0 },
            stacks = { layout = layout("stacks"), index = 0 },
            scopes = { layout = layout("scopes"), index = 0 },
            console = { layout = layout("console"), index = 0 },
            watches = { layout = layout("watches"), index = 0 },
            breakpoints = { layout = layout("breakpoints"), index = 0 },
        }
        local layouts = {}

        for name, config in pairs(name_to_layout) do
            table.insert(layouts, config.layout)
            name_to_layout[name].index = #layouts
        end

        local function toggle_debug_ui(name)
            dapui.close()
            local layout_config = name_to_layout[name]

            if layout_config == nil then
                error(string.format("bad name: %s", name))
            end

            local uis = vim.api.nvim_list_uis()[1]
            if uis ~= nil then
                layout_config.size = uis.width
            end

            pcall(dapui.toggle, layout_config.index)
        end

        vim.keymap.set("n", "<leader>dr", function() toggle_debug_ui("repl") end,
            { desc = "Debug: toggle repl ui" })
        vim.keymap.set("n", "<leader>ds", function() toggle_debug_ui("stacks") end,
            { desc = "Debug: toggle stacks ui" })
        vim.keymap.set("n", "<leader>dS", function() toggle_debug_ui("scopes") end,
            { desc = "Debug: toggle scopes ui" })
        vim.keymap.set("n", "<leader>dw", function() toggle_debug_ui("watches") end,
            { desc = "Debug: toggle watches ui" })
        vim.keymap.set("n", "<leader>db", function() toggle_debug_ui("breakpoints") end,
            { desc = "Debug: toggle breakpoints ui" })
        vim.keymap.set("n", "<leader>de", function() require("dapui").eval() end,
            { desc = "Debug: show one time expression" })

        vim.api.nvim_create_autocmd("BufEnter", {
            group = "DapGroup",
            pattern = "*dap-repl*",
            callback = function()
                vim.wo.wrap = true
            end,
        })

        vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("dap-repl"))
        vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Watches"))

        dapui.setup({
            layouts = layouts,
            enter = true,
        })

        dap.listeners.before.attach.dapui_config = function()
            toggle_debug_ui("repl")
        end
        dap.listeners.before.launch.dapui_config = function()
            toggle_debug_ui("repl")
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
