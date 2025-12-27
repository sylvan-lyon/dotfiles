return {
    "lewis6991/gitsigns.nvim",
    event = "User LazyFilePost",
    config = function ()
        require("gitsigns").setup({})
    end
}
