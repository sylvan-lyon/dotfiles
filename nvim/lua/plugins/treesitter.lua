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
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()
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
