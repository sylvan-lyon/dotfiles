return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "auto",
            float = {
                transparent = true,
                solid = false
            },
            background = {
                light = "frappe",
                dark = "mocha",
            },
            no_bold = false,
            no_italic = false,
            no_underline = false,
            styles = {           -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" }, -- Change the style of comments
                conditionals = { "italic" },
                loops = {},
                functions = { "bold" },
                keywords = { "italic" },
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
                -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            highlight_overrides = {
                all = function(colors)
                    return {
                        -- fold text
                        Folded = { fg = colors.flamingo, bg = colors.surface0, style = { "bold" } },
                        FoldColumn = { fg = colors.flamingo, bg = colors.surface0, style = { "bold" } },

                        -- flash.nvim labels
                        FlashLabel = { fg = colors.mantle, bg = colors.lavender },
                    }
                end
            },
            transparent_background = true,
            auto_integrations = true,
            default_integrations = true,
        })
        vim.cmd([[colorscheme catppuccin-nvim]])
    end,
}
