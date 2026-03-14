return {
    "lewis6991/gitsigns.nvim",
    -- cond = false,
    event = "User LazyFilePost",
    config = function()
        require("gitsigns").setup({})
        require("utils").keyset({
            -- hunk navigation
            { "[h",         function() require("gitsigns").nav_hunk("prev") end, desc = "previous [h]unk" },
            { "]h",         function() require("gitsigns").nav_hunk("next") end, desc = "next [h]unk" },

            -- preview
            { "<leader>ph", function() require("gitsigns").preview_hunk() end,   desc = "[p]review [h]unk" },
        })
    end
}
