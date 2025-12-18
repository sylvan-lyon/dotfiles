return {
    {
        -- 配色方案
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
        opts = {
            float = {
                transparent = true,
                solid = true,
            },
            flavour = "mocha",
            transparent_background = true,
            auto_integrations = true,
            default_integrations = false,
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


    {
        -- 底部栏美化
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                theme = "catppuccin",
                always_devide_middle = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "lsp_status" },
                lualine_y = { "encoding", "fileformat", "filestyle", "filesize" },
                lualine_z = { "location" },
            },
            extensions = {
                "mason", "neo-tree", "lazy"
            },
        },
    },

    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        lazy = false,
        opts = {
            sidebar_filetypes = {
                ['neo-tree'] = {
                    text = "File Explorer",
                    align = "center",
                },
            },
        },
        version = '^1.0.0',
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
            throttle = 1000 / 30,
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }
}
