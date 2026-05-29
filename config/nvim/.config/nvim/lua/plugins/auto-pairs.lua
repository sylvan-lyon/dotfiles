return {
    "windwp/nvim-autopairs",
    name = "autopairs",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        require("nvim-autopairs").setup({})
    end
}
