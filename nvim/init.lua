vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 设置编码
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- 窗口样式
vim.o.winborder = "rounded"

-- 显示行号和相对行号
vim.wo.number = true
vim.wo.relativenumber = true

-- 高亮当前行
vim.wo.cursorline = true

-- 光标移动时保留上下 8 行
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4

-- 设置缩进
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
vim.o.expandtab = true

-- 搜索设置
vim.o.ignorecase = true -- 忽略大小写
vim.o.smartcase = true  -- 智能大小写

-- 鼠标支持
vim.o.mouse = "a"

-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- 启用终端颜色支持
vim.o.termguicolors = true

-- 启动lazy vim，应用键位配置
require("config.lazy")
require("config.keymap")
