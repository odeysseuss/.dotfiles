return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "orjangj/neotest-ctest",
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-ctest").setup({})
            }
        })

        vim.keymap.set("n", "<leader>tr", function()
            neotest.run.run({
                suite = false,
                testify = true,
            })
        end, { desc = "Test: Running Nearest Test" })

        vim.keymap.set("n", "<leader>tv", function()
            neotest.summary.toggle()
        end, { desc = "Test: Summary Toggle" })

        vim.keymap.set("n", "<leader>ts", function()
            neotest.run.run({
                suite = true,
                testify = true,
            })
        end, { desc = "Test: Running Test Suite" })

        vim.keymap.set("n", "<leader>td", function()
            neotest.run.run({
                suite = false,
                testify = true,
                strategy = "dap",
            })
        end, { desc = "Test: Debug Nearest Test" })

        vim.keymap.set("n", "<leader>to", function()
            neotest.output.open()
        end, { desc = "Test: Open test output" })
    end
}
