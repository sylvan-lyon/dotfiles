return {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    config = function()
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                "nvim-dap-ui"
            },
        })
    end
}
