local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

local function floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_conf = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, win_conf)

    return { buf = buf, win = win }
end

vim.api.nvim_create_user_command("Floaterminal", function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = floating_window({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
            vim.cmd("startinsert")
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end, {})

vim.keymap.set({ "n", "t" }, "<leader>ft", "<cmd>Floaterminal<CR>", {})
