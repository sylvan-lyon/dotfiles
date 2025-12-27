vim.opt.winborder = "rounded"

vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "utf-8"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 显示行号和相对行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 高亮当前行
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- 光标移动时保留上下 8 行
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

-- 设置缩进
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 搜索设置 大小写不敏感，除非有大写
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- 禁用折行
vim.opt.wrap = false

-- 鼠标支持
vim.opt.mouse = "a"

-- 禁止创建备份文件
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- 启用终端颜色支持
vim.opt.termguicolors = true

-- 关闭自带的 mode 显示
vim.opt.showmode = false

_G.custom_fold_text = function()
    local start_line = vim.fn.getline(vim.v.foldstart)
    local line_count = (vim.v.foldend - vim.v.foldstart + 1)
    local end_text = "    󰁂 " .. line_count .. " lines total"

    return start_line .. end_text
end

vim.opt.foldtext = "v:lua.custom_fold_text()"
vim.opt.fillchars = { fold = " " }
