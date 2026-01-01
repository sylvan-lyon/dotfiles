return {
    "rebelot/heirline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "catppuccin/nvim",
    },
    config = function()
        local components = require("plugins.config.heirline")
        require("heirline").setup({
            ---@diagnostic disable-next-line: missing-fields
            statusline = {
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
                components.left_padding(components.file_type, 1),
                components.left_padding(components.file_encoding, 1),
                components.left_padding(components.file_format, 1),
                components.left_padding(components.scroll_bar, 2),
                components.left_padding(components.ruler, 0),
            },
            opts = components.opts,
        })
    end
}
