return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- lazy = false,
        cmd = {
            "TSInstall",
            "TSInstallFromGrammar",
            "TSUpdate",
            "TSUpdate",
            "TSUninstall",
            "TSLog",
            "TSListInstalled"
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()
            vim.api.nvim_create_user_command("TSListInstalled",
                ---@param data vim.api.keyset.create_user_command.command_args
                function(data)
                    local res = ""
                    for _, lang in ipairs( require("nvim-treesitter").get_installed() ) do
                        res = res .. lang .. "\n"
                    end
                    vim.print(res)
                end,
                { desc = "[nvim-treesitter] List all installed treesitter parsers", force = false }
            )
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "User LazyFilePost",
        config = function()
            require("treesitter-context").setup({
                multiline_threshold = 1,
                enable = true,
            })

            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
        end
    }
}
