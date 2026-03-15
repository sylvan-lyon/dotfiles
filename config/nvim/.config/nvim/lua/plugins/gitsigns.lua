return {
    "lewis6991/gitsigns.nvim",
    -- cond = false,
    event = "User LazyFilePost",
    config = function()
        local icon = " "
        require("gitsigns").setup({})
        require("utils").keyset({
            -- hunk navigation
            { "[h",         function() require("gitsigns").nav_hunk("prev") end,            desc = "previous [h]unk",  icon = icon },
            { "]h",         function() require("gitsigns").nav_hunk("next") end,            desc = "next [h]unk",      icon = icon },

            -- view
            { "<leader>vh", function() require("gitsigns").preview_hunk() end,              desc = "[v]iew [h]unk",    icon = icon },
            { "<leader>vb", function() require("gitsigns").blame_line() end,                desc = "[v]iew [b]lame",   icon = icon },

            -- toggle blame
            { "<leader>tb", function() require("gitsigns").toggle_current_line_blame() end, desc = "[t]oggle [b]lame", icon = icon },
        })
    end
}
