return {
    "mrjones2014/smart-splits.nvim",
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("smart-splits").setup({})

        require("utils").keyset({
            -- resizing
            { '<A-h>',             require('smart-splits').resize_left },
            { '<A-j>',             require('smart-splits').resize_down },
            { '<A-k>',             require('smart-splits').resize_up },
            { '<A-l>',             require('smart-splits').resize_right },

            -- navigation
            { '<C-h>',             require('smart-splits').move_cursor_left },
            { '<C-j>',             require('smart-splits').move_cursor_down },
            { '<C-k>',             require('smart-splits').move_cursor_up },
            { '<C-l>',             require('smart-splits').move_cursor_right },
            { '<C-\\>',            require('smart-splits').move_cursor_previous },

            -- swap buffers
            { '<leader><leader>h', require('smart-splits').swap_buf_left },
            { '<leader><leader>j', require('smart-splits').swap_buf_down },
            { '<leader><leader>k', require('smart-splits').swap_buf_up },
            { '<leader><leader>l', require('smart-splits').swap_buf_right },
        })
    end
}
