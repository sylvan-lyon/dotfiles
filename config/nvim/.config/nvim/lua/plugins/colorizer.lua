return {
    'norcalli/nvim-colorizer.lua',
    lazy = false,
    cmd = {
        -- "ColorizerAttachToBuffer",
        -- "ColorizerDetachFromBuffer",
        -- "ColorizerReloadAllBuffers",
        -- "ColorizerToggle"
    },
    config = function()
        require("colorizer").setup({})
        require("utils").keyset({
            { "<leader>tc", "<CMD>ColorizerToggle<CR>", desc = "[t]oggle [c]olorizer" }
        })
    end
}
