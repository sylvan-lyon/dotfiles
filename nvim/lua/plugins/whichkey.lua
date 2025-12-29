return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup({
            preset = "helix",
            win = {
                title = false,
                width = 0.5,
            },
        })

        vim.keymap.set(
            "n",
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            { desc = "[which-key] show keymaps" }
        )
    end
}
