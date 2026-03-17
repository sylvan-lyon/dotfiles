return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = "nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
    config = function()
        require("render-markdown").setup({
            completions = {
                blink = { enabled = true },
                lsp = { enabled = true },
            },
            sign = { enabled = false },
            code = {
                border = "thin",
            },
            heading = {
                border = true,
                render_modes = true,
                icons = { "󰲠  ", "󰲢  ", "󰲤  ", "󰲦  ", "󰲨  ", "󰲪  " },
            },
            checkbox = {
                checked = {
                    icon = "󰄵"
                },
                unchecked = {
                    icon = "󰄱",
                },
                custom = {},
            },
            pipe_table = {
                alignment_indicator = "─",
                border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
            },
            anti_conceal = {
                disabled_modes = { "n" },
                ignore = {
                    bullet = true,
                    head_border = true,
                    head_background = true,
                    link = true,
                }
            },
            -- overrides = {
            --     buftype = {
            --         nofile = {
            --             enabled = false,
            --         },
            --     },
            -- },
        })
    end
}
