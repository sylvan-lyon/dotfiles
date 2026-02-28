return {
    "rebelot/heirline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "catppuccin/nvim",
    },
    config = function()
        local lib = require("plugins.config.heirline")
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
                        lib.right_pad(lib.mode, 1),
                        lib.right_pad(lib.file_name_block, 1),
                        lib.right_pad(lib.diagnostics, 1),
                        lib.right_pad(lib.lsp_status, 0),
                        lib.right_pad(lib.lsp_progress, 0),
                        lib.fill,
                        lib.macro_recording,
                        lib.fill,
                        lib.left_pad(lib.show_cmd, 0),
                        lib.left_pad(lib.search_occurrence, 1),
                        lib.left_pad(lib.lazy_update, 1),
                        lib.left_pad(lib.git, 1),
                        lib.left_pad(lib.file_type, 1),
                        lib.left_pad(lib.file_encoding, 1),
                        lib.left_pad(lib.scroll_bar, 1),
                        lib.left_pad(lib.ruler, 1),
                        lib.left_pad(lib.file_format, 1),
                    }
                },
                {
                    condition = function()
                        return not conditions.is_active() and not is_dap_related_buffer()
                    end,
                    {
                        lib.right_pad(lib.mode, 1),
                        lib.right_pad(lib.file_name_block, 1),
                        lib.right_pad(lib.diagnostics, 1),
                        lib.right_pad(lib.lsp_status, 0),
                        lib.right_pad(lib.lsp_progress, 0),
                        lib.fill,
                        lib.macro_recording,
                        lib.fill,
                        lib.left_pad(lib.show_cmd, 0),
                        lib.left_pad(lib.search_occurrence, 1),
                        lib.left_pad(lib.lazy_update, 1),
                        lib.left_pad(lib.git, 1),
                        lib.left_pad(lib.file_type, 1),
                        lib.left_pad(lib.file_encoding, 1),
                        lib.left_pad(lib.scroll_bar, 1),
                        lib.left_pad(lib.ruler, 1),
                        lib.left_pad(lib.file_format, 1),
                    }
                },
                {
                    condition = is_dap_related_buffer,
                    lib.fill,
                    { provider = function() return "──── " end },
                    lib.dap_buffers,
                    { provider = function() return " ────" end },
                },
            },
            ---@diagnostic disable-next-line: missing-fields
            winbar = {
                {
                    lib.fill,
                    lib.buffer_type,
                    lib.file_path_block,
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
