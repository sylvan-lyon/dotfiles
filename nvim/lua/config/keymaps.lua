local all_modes_applied = { "n", "i", "x", "v" }

-- ===================== 常用快捷键
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "[custom] 在 INSERT 模式下向左移动光标" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "[custom] 在 INSERT 模式下向下移动光标" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "[custom] 在 INSERT 模式下向上移动光标" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "[custom] 在 INSERT 模式下向上移动光标" })

-- ==================== 窗口焦点快捷键
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "[custom] 在 NORMAL 模式下向左移动窗口焦点" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "[custom] 在 NORMAL 模式下向下移动窗口焦点" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "[custom] 在 NORMAL 模式下向上移动窗口焦点" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "[custom] 在 NORMAL 模式下向右移动窗口焦点" })

vim.keymap.set(all_modes_applied, "<A-[>", "<CMD>bprevious<CR>", { desc = "[custom] 上一个 buffer" })
vim.keymap.set(all_modes_applied, "<A-]>", "<CMD>bnext<CR>", { desc = "[custom] 下一个 buffer" })
vim.keymap.set(all_modes_applied, "<A-x>", "<CMD>bdelete<CR>", { desc = "[custom] 关闭当前 buffer" })

-- ==================== lazyvim 的快捷键
vim.keymap.set("n", "<leader>l", "<CMD>Lazy<CR>", { desc = "[custom] 打开 lazyvim 的窗口" })
