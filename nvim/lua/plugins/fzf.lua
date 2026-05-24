---@diagnostic disable: undefined-global
local fzf = require("fzf-lua")

fzf.setup({
    defaults = {
        file_icons = "mini",
    },

    actions = {
        files = {
            ["enter"]  = FzfLua.actions.file_edit_or_qf,
            ["ctrl-s"] = FzfLua.actions.file_split,
            ["ctrl-v"] = FzfLua.actions.file_vsplit,
            ["ctrl-q"] = {
                fn = FzfLua.actions.file_sel_to_qf,
                prefix = "select-all"
            },
        },
    },
})

vim.keymap.set("n", "<leader>ff", function() fzf.files() end,
    { desc = "FzfLua: Search Files" })
vim.keymap.set("n", "<leader>fb", function() fzf.buffers() end,
    { desc = "FzfLua: Search Buffers" })

vim.keymap.set("n", "<leader>fh", function() fzf.help_tags() end,
    { desc = "FzfLua: Search help tags" })
vim.keymap.set("n", "<leader>fm", function() fzf.manpages() end,
    { desc = "FzfLua: Search manpages" })

vim.keymap.set("n", "<leader>fk", function() fzf.keymaps() end,
    { desc = "FzfLua: Search keymaps" })

vim.keymap.set("n", "<leader>gw", function() fzf.git_worktrees() end,
    { desc = "FzfLua: Search git worktrees" })

vim.keymap.set("n", "<leader>G", function() fzf.live_grep() end,
    { desc = "FzfLua: Live grep current project" })
vim.keymap.set("n", "<leader>w", function() fzf.grep_cword() end,
    { desc = "FzfLua: Grep word under cursor" })
vim.keymap.set("n", "<leader>W", function() fzf.grep_cWORD() end,
    { desc = "FzfLua: Grep WORD under cursor" })

-- run selected commands in a tmux pane
local cmds = {
    "perf stat -e cycles,instructions,bus-cycles,cpu-clock,task-clock <path>",
    "perf stat -e branches,branch-misses,caches,cache-misses <path>",
    "perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores <path>",
    "perf stat -e dTLB-loads,dTLB-load-misses,dTLB-prefetch-misses <path>",
    "perf stat -e LLC-loads,LLC-load-misses,LLC-stores,LLC-prefetches <path>",
    "perf record -F 99 --call-graph dwarf <path>",
    "perf script report flamegraph",
    "xdg-open <path>",
    "perf report",
}

vim.keymap.set("n", "<leader>tt", function()
    fzf.fzf_exec(cmds, {
        actions = {
            ["default"] = function(selected)
                if not selected or #selected == 0 then return end

                local cmd = selected[1]

                if cmd:find("<path>") then
                    local input = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    if not input or input == "" then return end

                    local final_cmd = cmd:gsub("<path>", input)
                    vim.cmd("TmuxRunCmd " .. final_cmd)
                else
                    vim.cmd("TmuxRunCmd " .. cmd)
                end
            end,
        }
    })
end, { desc = "FzfLua: Run Perf commands in tmux" })
