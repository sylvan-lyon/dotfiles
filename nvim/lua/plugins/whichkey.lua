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

        local which_key = require("which-key")

        which_key.add({
            { "<leader>d", group = "debug" },
            { "<leader>f", group = "find" },
            { "<leader>t", group = "toggle" },
            { "gr",        group = "lsp" },
        })
    end
}
