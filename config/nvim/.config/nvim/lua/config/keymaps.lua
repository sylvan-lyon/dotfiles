vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("utils").keyset({
    { "j",          "gj",                      desc = "[custom] down(wrap awared)" },
    { "k",          "gk",                      desc = "[custom] up  (wrap awared)" },

    -- move text
    { "K",          ":silent m '<-2<CR>gv=gv", desc = "[custom] move up selected text",   mode = "v" },
    { "J",          ":silent m '>+1<CR>gv=gv", desc = "[custom] move down selected text", mode = "v" },

    -- indentation
    { "<",          "<gv",                     desc = "[custom] indent and keep visual",  mode = "v" },
    { ">",          ">gv",                     desc = "[custom] dedent and keep visual",  mode = "v", },

    -- lazy plugin manager
    { "<leader>l",  "<CMD>Lazy<CR>",           desc = "[custom] open up [l]azy" },

    -- disable highlight search
    { "<leader>th", "<CMD>nohl<CR>",           desc = "[t]oggle [h]ighlight search" }
})
