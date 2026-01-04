return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter")

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup("auto setup treesitter functionality after filetype detected", { clear = true }),
                callback = function()
                    local success = pcall(vim.treesitter.start)
                end,
            })
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
