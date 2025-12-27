return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
        require("catppuccin").setup({
            float = {
                transparent = true,
                solid = false
            },
            highlight_overrides = {
                all = function(colors)
                    return {
                        Folded = { fg = colors.flamingo, bg = colors.surface0, style = { "bold" } },
                        FoldColumn = { fg = colors.flamingo, bg = colors.surface0, style = { "bold" } },
                    }
                end
            },
            flavour = "mocha",
            transparent_background = true,
            auto_integrations = true,
            default_integrations = true,
        })
        vim.cmd([[colorscheme catppuccin]])
    end,
}
