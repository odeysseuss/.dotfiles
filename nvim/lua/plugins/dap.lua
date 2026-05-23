local dap = require("dap")
dap.set_log_level("DEBUG")

-- lldb-dap
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-dap",
    name = "lldb",
}

local lldb_defaults = {
    type = "lldb",
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = true,
    args = { "--local-lldbinit" },
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    initCommands = {
        "process handle -p true -s false -n true SIGWINCH",
        "settings set target.x86-disassembly-flavor intel",
    },
}

-- codelldb
dap.adapters.codelldb = {
    type = "executable",
    command = os.getenv("HOME") .. "/.local/bin/codelldb",
}

---@diagnostic disable-next-line: unused-local
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
    vim.tbl_deep_extend("force", lldb_defaults, {
        name = "Launch",
        request = "launch",
    }),

    vim.tbl_deep_extend("force", lldb_defaults, {
        name = "Attach",
        request = "attach",
        pid = function()
            local name = vim.fn.input("Executable name (filter): ")
            return require("dap.utils").pick_process({ filter = name })
        end,
    }),

    vim.tbl_deep_extend("force", lldb_defaults, {
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
vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Dap: Start or continue debugging" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Dap: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Dap: Add conditional breakpoint" })

local keys = {
    ["<Right>"]   = dap.step_into,
    ["<Left>"]    = dap.step_out,
    ["<Up>"]      = dap.restart_frame,
    ["<Down>"]    = dap.step_over,
    ["<C-Down>"]  = dap.run_to_cursor,
    ["<leader>w"] = "<cmd>DapViewWatch<CR>",
    ["K"]         = "<cmd>DapViewHover<CR>",
    ["B"]         = "<cmd>DapViewJump breakpoints<CR>",
    ["C"]         = "<cmd>DapViewJump console<CR>",
    ["D"]         = "<cmd>DapViewJump disassembly<CR>",
    ["E"]         = "<cmd>DapViewJump exceptions<CR>",
    ["R"]         = "<cmd>DapViewJump repl<CR>",
    ["S"]         = "<cmd>DapViewJump scopes<CR>",
    ["T"]         = "<cmd>DapViewJump threads<CR>",
    ["W"]         = "<cmd>DapViewJump watches<CR>",
}

local setDapKeys = function()
    for key, cmd in pairs(keys) do
        vim.keymap.set("n", key, cmd, { silent = true })
    end
end

local resetDapKeys = function()
    if not next(dap.sessions()) then
        for lhs, _ in pairs(keys) do
            pcall(vim.keymap.del, "n", lhs)
        end
    end
end

dap.listeners.after.event_initialized["dap_keymaps"] = setDapKeys
dap.listeners.after.event_terminated["dap_keymaps"] = resetDapKeys
dap.listeners.after.event_exited["dap_keymaps"] = resetDapKeys
dap.listeners.after.disconnect["dap_keymaps"] = resetDapKeys

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
            "console",
        },
    },

    windows = {
        size = 0.40,
        position = "right",
        -- terminal = {
        --     size = 0.30,
        --     position = "below",
        -- },
    },

    virtual_text = {
        enabled = true,
    },

    auto_toggle = true,
})

-- dap-disasm config
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
