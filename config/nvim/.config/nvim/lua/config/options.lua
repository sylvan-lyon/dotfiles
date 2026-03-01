vim.opt.winborder = "rounded"

vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "utf-8"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

-- indentation options
-- the width options are configured by filetype autocmds
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false

vim.opt.mouse = "a"

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.undofile = true

vim.opt.termguicolors = true

-- remove default mode bar, because we have a nice heirline config
vim.opt.showmode = false

_G.custom_fold_text = function()
    local start_line = vim.fn.getline(vim.v.foldstart)
    local line_count = (vim.v.foldend - vim.v.foldstart + 1)
    local end_text = "      " .. line_count .. " lines total"

    return start_line .. end_text
end

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldtext = "v:lua.custom_fold_text()"
vim.opt.fillchars = { fold = " " }

if require("utils").is_windows then
    if vim.fn.executable("nu.exe") == 1 then
        vim.opt.shell = "nu.exe"
    elseif vim.fn.executable("pwsh.exe") == 1 then
        vim.opt.shell = "pwsh.exe"
    elseif vim.fn.executable("powershell.exe") == 1 then
        vim.opt.shell = "powershell.exe"
    elseif vim.fn.executable("cmd.exe") == 1 then
        vim.opt.shell = "cmd.exe"
    end
end
