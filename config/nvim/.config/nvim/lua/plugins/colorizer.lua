require("utils").keyset({
    { "<leader>tc", "<CMD>ColorizerToggle<CR>", desc = "[t]oggle [c]olorizer" }
})

return {
    "catgoose/nvim-colorizer.lua",
    name = "colorizer",
    cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers",
        "ColorizerToggle"
    },
    config = function()
        require("colorizer").setup({})
    end
}
