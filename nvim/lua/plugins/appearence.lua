return {
    {
        -- 配色方案
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd([[colorscheme catppuccin]])
        end,
        opts = {
            float = {
                transparent = true,
                solid = false
            },
            flavour = "mocha",
            transparent_background = true,
            auto_integrations = true,
            default_integrations = true,
        }
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        keys = {
            { mode = "n", "<leader>e", "<CMD>Neotree position=left toggle=true reveal=true<CR>", desc = "[neotree] 打开文件树" }
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
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
        main = "rainbow-delimiters.setup",
        submodules = false,
        opts = {}
    },
}
