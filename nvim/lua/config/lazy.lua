local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://gh-proxy.org/https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            },
            true,
            {}
        )
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.autocmds")
require("config.keymaps")

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = { missing = true, colorscheme = { "catppuccin" } },
    checker = { enabled = true },
    ui = {
        border = "rounded",
        backdrop = 100,
        pills = true,
    },
    throttle = 60,
    git = {
        timeout = 600, -- 把超时限制改大一点，避免什么都直接爆炸了
        log = { "-4" },
        url_format = "https://gh-proxy.org/https://github.com/%s.git",
    },
    change_detection = {
        enabled = false,
    }
})

