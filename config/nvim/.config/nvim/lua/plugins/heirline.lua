return {
    "rebelot/heirline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "catppuccin/nvim",
    },
    event = "User LazyFilePost",
    config = function()
        local components = require("plugins.config.heirline")
        local conditions = require("heirline.conditions")

        local is_dap_related_buffer = function()
            return vim.bo.filetype:match("dap") ~= nil
        end

        require("heirline").setup({
            ---@diagnostic disable-next-line: missing-fields
            statusline = {
                {
                    condition = function()
                        return conditions.is_active() and not is_dap_related_buffer()
                    end,
                    {
                        components.right_padding(components.mode, 1),
                        components.right_padding(components.file_name_block, 1),
                        components.right_padding(components.diagnostics, 1),
                        components.right_padding(components.lsp_status, 0),
                        components.right_padding(components.lsp_progress, 0),
                        components.fill,
                        components.left_padding(components.search_occurrence, 1),
                        components.left_padding(components.file_type, 1),
                        components.left_padding(components.git, 1),
                        components.left_padding(components.file_encoding, 1),
                        components.left_padding(components.file_format, 1),
                        components.left_padding(components.scroll_bar, 0),
                        components.left_padding(components.ruler, 0),
                    }
                },
                {
                    condition = function()
                        return not conditions.is_active() and not is_dap_related_buffer()
                    end,
                    {
                        components.right_padding(components.mode, 1),
                        components.right_padding(components.file_name_block, 1),
                        components.right_padding(components.diagnostics, 1),
                        components.right_padding(components.lsp_status, 0),
                        components.right_padding(components.lsp_progress, 0),
                        components.fill,
                        components.macro_recording,
                        components.fill,
                        components.left_padding(components.show_cmd, 0),
                        components.left_padding(components.search_occurrence, 1),
                        components.left_padding(components.lazy_update, 1),
                        components.left_padding(components.git, 1),
                        components.left_padding(components.file_type, 2),
                        components.left_padding(components.file_encoding, 1),
                        components.left_padding(components.file_format, 1),
                        components.left_padding(components.scroll_bar, 0),
                        components.left_padding(components.ruler, 0),
                    }
                },
                {
                    condition = function()
                        return is_dap_related_buffer()
                    end,
                    {
                        components.right_padding(components.mode, 1),
                        components.fill,
                        components.file_type,
                        components.left_padding(components.scroll_bar, 1),
                    },
                },
            },
            ---@diagnostic disable-next-line: missing-fields
            winbar = {
                {
                    components.fill,
                    components.buffer_type,
                    components.file_path_block,
                }
            },
            opts = {
                disable_winbar_cb = function(args)
                    return conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "help", "quickfix", "term" },
                    }, args.buf)
                end
            },
        })
    end
}
