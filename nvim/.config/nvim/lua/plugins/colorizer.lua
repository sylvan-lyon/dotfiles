return {
    'norcalli/nvim-colorizer.lua',
    keys = {
        { "<leader>tc", desc = "[t]oggle [c]olorizer" }
    },
    cmd = {
        -- "ColorizerAttachToBuffer",
        -- "ColorizerDetachFromBuffer",
        -- "ColorizerReloadAllBuffers",
        -- "ColorizerToggle"
    },
    config = function ()
        require("colorizer").setup({})
        vim.keymap.set("n", "<leader>tc", "<CMD>ColorizerToggle<CR>", { desc = "[t]oggle [c]olorizer" })
    end
}
