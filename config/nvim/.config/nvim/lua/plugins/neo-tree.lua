return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { mode = "n", "<leader>e", "<CMD>Neotree position=float toggle=true reveal=true<CR>", desc = "file [e]xplorer" }
    },
    cmd = { "Neotree" },
    config = function()
        require("neo-tree").setup({
            popup_border_style = "",
            default_component_configs = {
                indent = {
                    indent_marker = "│",
                    last_indent_marker = "╰",
                },
                ---@diagnostic disable-next-line: missing-fields
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                }
            },
        })
    end
}
