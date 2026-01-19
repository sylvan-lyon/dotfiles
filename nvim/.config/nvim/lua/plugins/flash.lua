return {
    "folke/flash.nvim",
    -- event = "VeryLazy",
    -- keys = {
    --     { "s",     mode = { "n", "x", "o" }, desc = "Flash" },
    --     { "S",     mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
    --     { "r",     mode = "o",               desc = "Remote Flash" },
    --     { "R",     mode = { "o", "x" },      desc = "Treesitter Search" },
    --     { "<c-s>", mode = { "c" },           desc = "Toggle Flash Search" },
    -- },
    event = "User LazyFilePost",
    config = function()
        require("flash").setup({
            modes = {
                char = {
                    jump_labels = true,
                }
            },
            jump = {
                nohlsearch = true,
                autojump = true
            }
        })
        require("config.keymaps").set_keymaps({
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        })
    end
}
