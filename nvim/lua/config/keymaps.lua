vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local all_modes_applied = { "n", "i", "x", "v" }

vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "[custom] 将选中的文本上移一行" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "[custom] 将选中的文本下移一行" })

vim.keymap.set("i", "<C-h>", "<Left>", { desc = "[custom] 向左移动光标" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "[custom] 向下移动光标" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "[custom] 向上移动光标" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "[custom] 向上移动光标" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "[custom] 向左移动窗口焦点" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "[custom] 向下移动窗口焦点" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "[custom] 向上移动窗口焦点" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "[custom] 向右移动窗口焦点" })

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[custom] 垂直分屏" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[custom] 水平分屏" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "[custom] 使分屏相等" })
vim.keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "[custom] 关闭这个分屏" })

vim.keymap.set(all_modes_applied, "<A-[>", "<CMD>bprevious<CR>", { desc = "[custom] 上一个 buffer" })
vim.keymap.set(all_modes_applied, "<A-]>", "<CMD>bnext<CR>", { desc = "[custom] 下一个 buffer" })
vim.keymap.set(all_modes_applied, "<A-x>", "<CMD>bdelete<CR>", { desc = "[custom] 关闭当前 buffer" })

vim.keymap.set("n", "<leader>l", "<CMD>Lazy<CR>", { desc = "[custom] 打开 lazyvim 的窗口" })

vim.keymap.set("n", "Q", "<nop>")
