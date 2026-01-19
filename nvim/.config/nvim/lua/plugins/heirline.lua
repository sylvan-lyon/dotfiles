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
        require("heirline").setup({
            ---@diagnostic disable-next-line: missing-fields
            statusline = {
                {
                    condition = conditions.is_not_active,
                    {
                        components.right_padding(components.mode, 1),
                        components.right_padding(components.file_name_block, 1),
                        components.right_padding(components.git, 1),
                        components.right_padding(components.diagnostics, 1),
                        components.right_padding(components.lsp_status, 0),
                        components.right_padding(components.lsp_progress, 0),
                        components.fill,
                        components.left_padding(components.search_occurrence, 1),
                        components.left_padding(components.file_type, 1),
                        components.left_padding(components.file_encoding, 1),
                        components.left_padding(components.file_format, 1),
                        components.left_padding(components.scroll_bar, 2),
                        components.left_padding(components.ruler, 0),
                    }
                },
                {
                    condition = conditions.is_active,
                    {
                        components.right_padding(components.mode, 1),
                        components.right_padding(components.file_name_block, 1),
                        components.right_padding(components.git, 1),
                        components.right_padding(components.diagnostics, 1),
                        components.right_padding(components.lsp_status, 0),
                        components.right_padding(components.lsp_progress, 0),
                        components.fill,
                        components.macro_recording,
                        components.fill,
                        components.left_padding(components.show_cmd, 0),
                        components.left_padding(components.search_occurrence, 1),
                        components.left_padding(components.lazy_update, 1),
                        components.left_padding(components.file_type, 1),
                        components.left_padding(components.file_encoding, 1),
                        components.left_padding(components.file_format, 1),
                        components.left_padding(components.scroll_bar, 2),
                        components.left_padding(components.ruler, 0),
                    }
                }
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
                        buftype = { "nofile", "prompt", "help", "quickfix" },
                    }, args.buf)
                end
            },
        })
    end
}
