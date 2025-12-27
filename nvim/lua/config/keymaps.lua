vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local all_modes_applied = { "n", "i", "x", "v" }

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "[custom] move up selected text" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "[custom] move down selected text" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "[custom] focus on the left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "[custom] focus on the down split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "[custom] focus on the upper split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "[custom] focus on the right split" })

vim.keymap.set("v", "<", "<v", { desc = "[custom] indent and keep visual" })
vim.keymap.set("v", ">", ">v", { desc = "[custom] dedent and keep visual" })

-- vim.keymap.set("n", "<C-Shift-H>", "<C-w><", { desc = "[custom] decrease width" })
-- vim.keymap.set("n", "<C-Shift-J>", "<C-w>-", { desc = "[custom] decrease height" })
-- vim.keymap.set("n", "<C-Shift-K>", "<C-w>+", { desc = "[custom] increase height" })
-- vim.keymap.set("n", "<C-Shift-L>", "<C-w>>", { desc = "[custom] increase width" })

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[custom] [s]plit [v]ertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[custom] [s]plit [h]orizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "[custom] [s]plit [e]qualize" })
vim.keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "[custom] [s]plit close" })

vim.keymap.set(all_modes_applied, "<A-x>", "<CMD>bdelete<CR>", { desc = "[custom] close current buffer" })

vim.keymap.set("n", "<leader>l", "<CMD>Lazy<CR>", { desc = "[custom] open up [l]azy" })
