vim.opt.winborder = "rounded"

-- 禁用 netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 设置编码
vim.o.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
vim.o.splitright = true

-- 显   示行号和相对行号
vim.wo.number = true
vim.wo.relativenumber = true

-- 高亮当前行
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"

-- 光标移动时保留上下 8 行
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4

-- 设置缩进
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
vim.o.expandtab = true
-- 自动缩进
vim.opt.autoindent = true

-- 搜索设置 大小写不敏感，除非有大写
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.hlsearch = true

-- 禁用折行
vim.opt.wrap = false

-- 鼠标支持
vim.o.mouse = "a"

-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- 启用终端颜色支持
vim.o.termguicolors = true

