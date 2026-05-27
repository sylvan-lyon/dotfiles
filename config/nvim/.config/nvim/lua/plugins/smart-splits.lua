return {
    "mrjones2014/smart-splits.nvim",
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("smart-splits").setup({})

        require("utils").keyset({
            -- resizing
            { '<A-h>',             require('smart-splits').resize_left,       desc = "resize splits" },
            { '<A-j>',             require('smart-splits').resize_down,       desc = "resize splits" },
            { '<A-k>',             require('smart-splits').resize_up,         desc = "resize splits" },
            { '<A-l>',             require('smart-splits').resize_right,      desc = "resize splits" },

            -- navigation
            { '<C-h>',             require('smart-splits').move_cursor_left,  desc = "move to splits" },
            { '<C-j>',             require('smart-splits').move_cursor_down,  desc = "move to splits" },
            { '<C-k>',             require('smart-splits').move_cursor_up,    desc = "move to splits" },
            { '<C-l>',             require('smart-splits').move_cursor_right, desc = "move to splits" },

            -- swap buffers
            { '<leader><leader>h', require('smart-splits').swap_buf_left,     desc = "swap splits" },
            { '<leader><leader>j', require('smart-splits').swap_buf_down,     desc = "swap splits" },
            { '<leader><leader>k', require('smart-splits').swap_buf_up,       desc = "swap splits" },
            { '<leader><leader>l', require('smart-splits').swap_buf_right,    desc = "swap splits" },
        })
    end
}
