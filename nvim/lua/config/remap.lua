vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "=ap", "ma=ap'a")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<leader><leader>", "<cmd>w<CR>")
vim.keymap.set("n", "<C-m>", "@")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "r", "<C-r>")
vim.keymap.set({ "n", "t" }, "<C-b>", "<cmd>b#<CR>")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>D", '"_d')

vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- diagnostic
vim.keymap.set("n", "ge", vim.diagnostic.open_float, {})
vim.keymap.set("n", "gj", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "gk", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "<leader>sd", vim.diagnostic.setqflist, {})
vim.keymap.set("n", "<leader>sD", vim.diagnostic.setloclist, {})
vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>", {})
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>", {})

-- git diff
vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Git get remote diff" })
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Git get local diff" })

-- terminal commands
vim.keymap.set("n", "<leader>x", "<cmd>!chmod 755 %<CR>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
