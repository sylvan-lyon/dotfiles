return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/snacks.nvim"
    },
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

        vim.keymap.set(
            "n", "<leader>st",
            ---@diagnostic disable-next-line: undefined-global
            function() Snacks.picker.todo_comments() end,
            { desc = "[s]earch [t]odo comments" }
        )
    end
}
