vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
        else
            -- via formatprg
            vim.keymap.set("n", "<leader>f", function()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                vim.cmd("silent! normal! ggVGgq")
                vim.api.nvim_win_set_cursor(0, cursor_pos)
            end, { buffer = true, desc = "Format entire file" })
        end
        if client:supports_method("textDocument/foldingRange") then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Open help in vertical split",
    pattern = "help",
    command = "wincmd L",
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Sync nvim with the terminal",
    command = "wincmd ="
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Don't continue auto comment",
    callback = function()
        vim.opt_local.formatoptions:remove({ "o" })
    end
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    desc = "Show active cursorline",
    group = vim.api.nvim_create_augroup("active-cursorline", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    desc = "Hide inactive cursorline",
    group = "active-cursorline",
    callback = function()
        vim.opt_local.cursorline = false
    end
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Dap Repl",
    group = vim.api.nvim_create_augroup("dap-group", { clear = true }),
    pattern = "*dap-repl*",
    callback = function()
        vim.b.completion = false
        vim.wo.wrap = true
    end
})

-- running health checks in the background
vim.api.nvim_create_user_command("HealthCheck", function()
    local state = vim.fn.stdpath("state")
    local filename = state .. "/healthcheck.log"

    vim.fn.jobstart({
        "nvim",
        "--headless",
        "-c", "checkhealth | w " .. filename .. " | qa"
    }, {
        on_exit = function()
            vim.schedule(function()
                vim.cmd("edit " .. filename)
                print("Health check done")
            end)
        end
    })

    print("Running health checks...")
end, {})
