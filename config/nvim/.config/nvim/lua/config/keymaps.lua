vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("utils").keyset({
    { "j",          "gj",                      desc = "[custom] down(wrap awared)" },
    { "k",          "gk",                      desc = "[custom] up  (wrap awared)" },

    -- split focus
    { "<C-h>",      "<C-w>h",                  desc = "[custom] focus on the left split" },
    { "<C-j>",      "<C-w>j",                  desc = "[custom] focus on the down split" },
    { "<C-k>",      "<C-w>k",                  desc = "[custom] focus on the upper split" },
    { "<C-l>",      "<C-w>l",                  desc = "[custom] focus on the right split" },

    -- move text
    { "K",          ":silent m '<-2<CR>gv=gv", desc = "[custom] move up selected text",   mode = "v" },
    { "J",          ":silent m '>+1<CR>gv=gv", desc = "[custom] move down selected text", mode = "v" },

    -- indentation
    { "<",          "<gv",                     desc = "[custom] indent and keep visual",  mode = "v" },
    { ">",          ">gv",                     desc = "[custom] dedent and keep visual",  mode = "v", },

    -- lazy plugin manager
    { "<leader>l",  "<CMD>Lazy<CR>",           desc = "[custom] open up [l]azy" },

    -- disable highlight search
    { "<leader>th", "<CMD>nohl<CR>",           desc = "[custom] toggle highlight search" }
})
