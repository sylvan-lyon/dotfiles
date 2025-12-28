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
    opts = {
        popup_border_style = "",
        default_component_configs = {
            indent = {
                indent_marker = "│",
                last_indent_marker = "╰",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
            }
        },
    }
}
