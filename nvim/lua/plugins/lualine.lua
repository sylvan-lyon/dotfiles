local normalized_relative_filename = {
    "filename",
    path = 1,
    fmt = function(content, _)
        local normalized = content:gsub("\\", "/")
        return normalized
    end
}

local win_bar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { normalized_relative_filename },
}

local sections = function()
    return {
        lualine_a = { "mode" },
        lualine_b = {
            { "branch" },
            { "diff" },
            { "diagnostics", update_in_insert = true },
            { "filename" },
        },
        lualine_c = {
            { 'filetype', icon_only = true, icon = { align = "right" } },
        },
        lualine_x = {
            { 'lsp_status',                   symbols = { spinner = {} } },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates },
        },
        lualine_y = { "encoding", "fileformat", "filestyle" },
        lualine_z = { "location" },
    }
end

return {
    -- 底部栏美化
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "catppuccin/nvim",
    },
    event = "User LazyFilePre",
    config = function(_, _)
        require("lualine").setup({
            options = {
                theme = "catppuccin",
                always_devide_middle = false,
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                globalstatus = false,
                disabled_filetypes = {
                    statusline = { "snacks_dashboard", },
                    winbar = { "snacks_dashboard", },
                },
            },
            sections = sections(),
            inactive_sections = sections(),
            winbar = win_bar,
            inactive_winbar = win_bar,
            extensions = { "neo-tree", "lazy" },
        })
    end
}
