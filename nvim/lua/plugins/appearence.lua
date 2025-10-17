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
                "mason", "nvim-tree", "lazy"
            }
        },
        -- 不知道为什么用不了
        config = function(_, opts)
            local function show_macro_recording()
                local recording_register = vim.fn.reg_recording()
                if recording_register ~= '' then
                    return 'RECORDING @' .. recording_register
                else
                    return ''
                end
            end

            local macro_recording = {
                show_macro_recording,
                padding = 0,
            }

            table.insert(opts.sections.lualine_x, macro_recording)
            require("lualine").setup(opts)
        end
    },

    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            options = {
                mode = "buffers",
                themable = true,
                numbers = "ordinal",
                diagnostics = "nvim_lsp",
                offsets = { {
                    filetype = "snacks_layout_box",
                    text = "",
                    highlight = "Directory",
                    text_align = "left"
                } }
            }
        },
        keys = {
            { mode = all, "<A-[>", "<CMD>BufferLineCyclePrev<CR>", desc = "[BufferLine]切换至上一个打开的文件" },
            { mode = all, "<A-]>", "<CMD>BufferLineCycleNext<CR>", desc = "[BufferLine]切换至下一个打开的文件" },
            { mode = all, "<A-1>", "<CMD>BufferLineGoToBuffer 1<CR>", desc = "[BufferLine]切换至打开的第 1 个文件" },
            { mode = all, "<A-2>", "<CMD>BufferLineGoToBuffer 2<CR>", desc = "[BufferLine]切换至打开的第 2 个文件" },
            { mode = all, "<A-3>", "<CMD>BufferLineGoToBuffer 3<CR>", desc = "[BufferLine]切换至打开的第 3 个文件" },
            { mode = all, "<A-4>", "<CMD>BufferLineGoToBuffer 4<CR>", desc = "[BufferLine]切换至打开的第 4 个文件" },
            { mode = all, "<A-5>", "<CMD>BufferLineGoToBuffer 5<CR>", desc = "[BufferLine]切换至打开的第 5 个文件" },
            { mode = all, "<A-6>", "<CMD>BufferLineGoToBuffer 6<CR>", desc = "[BufferLine]切换至打开的第 6 个文件" },
            { mode = all, "<A-7>", "<CMD>BufferLineGoToBuffer 7<CR>", desc = "[BufferLine]切换至打开的第 7 个文件" },
            { mode = all, "<A-8>", "<CMD>BufferLineGoToBuffer 8<CR>", desc = "[BufferLine]切换至打开的第 8 个文件" },
            { mode = all, "<A-9>", "<CMD>BufferLineGoToBuffer 9<CR>", desc = "[BufferLine]切换至打开的第 9 个文件" },
            { mode = all, "<A-0>", "<CMD>BufferLineGoToBuffer 10<CR>", desc = "[BufferLine]切换至打开的第 10 个文件" },
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
