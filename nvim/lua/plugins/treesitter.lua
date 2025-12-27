return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = "User LazyFilePost",
        build = ':TSUpdate',
        branch = "master",
        config = function()
            -- 你需要安装的语言解析器
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "rust", "lua", "json" },

                indent = {
                    enable = true,
                },

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },

                incremental_selection = {
                    keymaps = {
                        init_selection = '[x',
                        node_incremental = '[x',
                        node_decremental = ']x',
                        scope_incremental = false,
                    },
                    enable = true,
                },

                auto_install = false,
                ignore_install = {},
                sync_install = true,
                modules = { "highlight", "incremental_selection", "indent" },
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependency = {

        },
        event = "User LazyFilePost",
        config = function ()
            require("treesitter-context").setup({
                enable = true,
            })

            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
        end
    }
}
