return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "User LazyFilePost",
    config = function()
        require("todo-comments").setup({
            -- TODO:
            -- FIX:
            -- HACK:
            -- WARN:
            -- PERF:
            -- TESTING:
            keywords = {
                TODO = { icon = "󰄳" },
                FIX = { icon = "" },
                HACK = { icon = "" },
                WARN = { icon = "", alt = { "WARNING" } },
                PERF = { icon = "", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                TEST = { icon = "", alt = { "TESTING", "PASSED", "FAILED" } }
            }
        })

        vim.keymap.set("n",  "<leader>ft", "<CMD>TodoTelescope<CR>", { desc = "[telescope] [f]ind [t]odo-comments" })
    end
}
