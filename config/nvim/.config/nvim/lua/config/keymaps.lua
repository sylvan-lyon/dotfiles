vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("utils").keyset({
    { "j",          "gj",               desc = "[custom] down(wrap awared)" },
    { "k",          "gk",               desc = "[custom] up  (wrap awared)" },
    { "p",          [["_dP"]],          desc = "[custom] keep yanked text",                  mode = "x" },
    { "C-c",        "<Esc>",            desc = "[custom] exit insert mode with InsertLeave", mode = "i" },

    -- indentation
    { "<",          "<gv",              desc = "[custom] indent and keep in visual mode",    mode = "v" },
    { ">",          ">gv",              desc = "[custom] dedent and keep in visual mode",    mode = "v" },

    { "<C-d>",      "<C-d>zz",          desc = "[custom] scroll [d]own and keep cursor" },
    { "<C-u>",      "<C-u>zz",          desc = "[custom] scroll [u]p and keep cursor" },

    -- lazy plugin manager
    { "<leader>l",  "<CMD>Lazy<CR>",    desc = "[custom] open up [l]azy" },

    -- disable highlight search
    { "<leader>th", "<CMD>nohl<CR>",    desc = "[t]oggle [h]ighlight search" },
    { "<leader>re", "<CMD>restart<CR>", desc = "[r][e]load" }
})
