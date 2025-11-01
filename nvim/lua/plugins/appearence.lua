local all = { "n", "i", "x", "v" }

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
            background = {
                light = "latte",
                dark = "mocha",
            },
            float = {
                transparent = true,
            },
            flavours = "mocha",
            -- 使得弹出的窗口背景也是 catppuccin 的颜色
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
            { mode = "n", "<leader>e", "<CMD>Neotree position=left toggle=true<CR>", desc = "[NEO TREE] 打开文件树" }
        },
        opts = {
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1743
            -- 维护者说使用 popup_border_style = "" 来使用 winborder 的设置
            popup_border_style = ""
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
        keys = {
            { mode = all, "<A-[>", "<CMD>BufferPrev<CR>", desc = "[Barbar] 切换至上一个打开的文件" },
            { mode = all, "<A-]>", "<CMD>BufferNext<CR>", desc = "[Barbar] 切换至下一个打开的文件" },
            { mode = all, "<A-1>", "<CMD>BufferGoto 1<CR>", desc = "[Barbar] 切换至打开的第 1 个文件" },
            { mode = all, "<A-2>", "<CMD>BufferGoto 2<CR>", desc = "[Barbar] 切换至打开的第 2 个文件" },
            { mode = all, "<A-3>", "<CMD>BufferGoto 3<CR>", desc = "[Barbar] 切换至打开的第 3 个文件" },
            { mode = all, "<A-4>", "<CMD>BufferGoto 4<CR>", desc = "[Barbar] 切换至打开的第 4 个文件" },
            { mode = all, "<A-5>", "<CMD>BufferGoto 5<CR>", desc = "[Barbar] 切换至打开的第 5 个文件" },
            { mode = all, "<A-6>", "<CMD>BufferGoto 6<CR>", desc = "[Barbar] 切换至打开的第 6 个文件" },
            { mode = all, "<A-7>", "<CMD>BufferGoto 7<CR>", desc = "[Barbar] 切换至打开的第 7 个文件" },
            { mode = all, "<A-8>", "<CMD>BufferGoto 8<CR>", desc = "[Barbar] 切换至打开的第 8 个文件" },
            { mode = all, "<A-9>", "<CMD>BufferGoto 9<CR>", desc = "[Barbar] 切换至打开的第 9 个文件" },
            { mode = all, "<A-0>", "<CMD>BufferGoto 10<CR>", desc = "[Barbar] 切换至打开的第 10 个文件" },
            { mode = all, "<A-x>", "<CMD>BufferClose<CR>", desc = "[Barbar] 关闭此缓冲区" }
        }
    },

    {
        -- 通知和命令行之类的框框 UI
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
