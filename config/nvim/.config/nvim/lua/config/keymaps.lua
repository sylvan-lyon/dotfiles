vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("utils").set_keymaps({
    -- move text
    { "K",         ":m '<-2<CR>gv=gv", mode = "v", desc = "[custom] move up selected text" },
    { "J",         ":m '>+1<CR>gv=gv", mode = "v", desc = "[custom] move down selected text" },
    -- split focus
    { "<C-h>",     "<C-w>h",           mode = "n", desc = "[custom] focus on the left split" },
    { "<C-j>",     "<C-w>j",           mode = "n", desc = "[custom] focus on the down split" },
    { "<C-k>",     "<C-w>k",           mode = "n", desc = "[custom] focus on the upper split" },
    { "<C-l>",     "<C-w>l",           mode = "n", desc = "[custom] focus on the right split" },
    -- indentation
    { "<",         "<gv",              mode = "v", desc = "[custom] indent and keep visual" },
    { ">",         ">gv",              mode = "v", desc = "[custom] dedent and keep visual" },
    -- lazy plugin manager
    { "<leader>l", "<CMD>Lazy<CR>",    mode = "n", desc = "[custom] open up [l]azy" }
})
