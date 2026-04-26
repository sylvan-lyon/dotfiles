vim.opt.winborder = "rounded"

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- linenumber
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

-- indentation options
-- the width options are configured by filetype autocmds
vim.opt.autoindent = true
vim.opt.smartindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false

vim.opt.mouse = "a"

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.undofile = true

vim.opt.selection = "inclusive"
vim.opt.termguicolors = true

-- cursor
vim.opt.guicursor = "n-v-c-sm:block,r-cr-o:hor25-blinkoff500-blinkon500,i-c-ci-ve-t:ver25-blinkoff500-blinkon500"
vim.opt.cursorline = false

-- remove default mode bar, because we have a nice heirline config
vim.opt.showmode = false

vim.opt.fixendofline = true

_G.custom_fold_text = function()
    local start_line = vim.fn.getline(vim.v.foldstart)
    local line_count = (vim.v.foldend - vim.v.foldstart + 1)
    local end_text = "      " .. line_count .. " lines total"

    return start_line .. end_text
end

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldtext = "v:lua.custom_fold_text()"
vim.opt.fillchars = {
    fold = " ", -- 填充折叠文本的字符
    eob = " ",  -- 填充 end of buffer 的字符
}
