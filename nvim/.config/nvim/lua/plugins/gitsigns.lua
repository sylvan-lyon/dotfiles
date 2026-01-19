return {
    "lewis6991/gitsigns.nvim",
    -- cond = false,
    event = "User LazyFilePost",
    config = function ()
        require("gitsigns").setup({})
    end
}
