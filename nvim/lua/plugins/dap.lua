local dap = require("dap")
dap.set_log_level("DEBUG")

-- adapter config
dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb",
}

local codelldb_defaults = {
    type = "codelldb",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    stopAtBeginningOfMainSubprogram = false,
    initCommands = {
        "settings set target.x86-disassembly-flavor intel",
    },
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
}

-- language specific config
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

-- dap keymaps
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Dap: Start or continue debugging" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Dap: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Dap: Add conditional breakpoint" })

dap.listeners.after.event_initialized["dap_keymaps"] = function()
    vim.keymap.set("n", "<Right>", dap.step_into, { desc = "Dap: Step into a function" })
    vim.keymap.set("n", "<Left>", dap.step_out, { desc = "Dap: Step out of a function" })
    vim.keymap.set("n", "<Up>", dap.restart_frame, { desc = "Dap: Restart a frame" })
    vim.keymap.set("n", "<Down>", dap.step_over, { desc = "Dap: Step over a function" })
end

local reset_dap_keys = function()
    if not next(dap.sessions()) then
        pcall(vim.keymap.del, "n", "<Right>")
        pcall(vim.keymap.del, "n", "<Left>")
        pcall(vim.keymap.del, "n", "<Up>")
        pcall(vim.keymap.del, "n", "<Down>")
    end
end

dap.listeners.after.event_terminated["dap_keymaps"] = reset_dap_keys
dap.listeners.after.event_exited["dap_keymaps"] = reset_dap_keys
dap.listeners.after.disconnect["dap_keymaps"] = reset_dap_keys

-- dap-view config
require("dap-view").setup({
    winbar = {
        show = true,
        sections = {
            "repl",
            "scopes",
            "watches",
            "threads",
            "breakpoints",
            "exceptions",
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

    virtual_text = {
        enabled = true,
    },

    auto_toggle = true,
})

vim.keymap.set("n", "<leader>dr", "<cmd>DapViewJump repl<CR>",
    { desc = "DapView: Jump to repl window" })
vim.keymap.set("n", "<leader>dt", "<cmd>DapViewJump terminal<CR>",
    { desc = "DapView: Jump to terminal window" })
vim.keymap.set("n", "<leader>dw", "<cmd>DapViewJump watches<CR>",
    { desc = "DapView: Jumo to watches window" })
vim.keymap.set("n", "<leader>w", "<cmd>DapViewWatch<CR>",
    { desc = "DapView: Add expr under cursor to dap watches" })
vim.keymap.set("n", "<leader>h", "<cmd>DapViewHover<CR>",
    { desc = "DapView: Hover over the variable under cursor" })

-- da-disasm config
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
        "address",
        -- "instructionBytes",
        "instruction",
    },
})
