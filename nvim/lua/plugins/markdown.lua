require("render-markdown").setup({
    file_types = { "markdown", "c", "rust" },
    pipe_table = {
        preset = "round",
        alignment_indicator = "",
    }
})

local enabled = true
vim.keymap.set("n", "<leader>P", function()
    if enabled then
        vim.cmd("RenderMarkdown disable")
        enabled = false
    else
        vim.cmd("RenderMarkdown enable")
        enabled = true
    end
end, { desc = "Render markdown toggle" })
