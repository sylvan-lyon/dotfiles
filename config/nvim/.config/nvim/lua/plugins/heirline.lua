return {
    "rebelot/heirline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "catppuccin/nvim",
    },
    config = function()
        local lib = require("plugins.config.heirline")

        require("heirline").setup({
            ---@diagnostic disable-next-line: missing-fields
            statusline = {
                lib.right_pad(lib.mode, 1),
                lib.right_pad(lib.file_path_block, 1),
                lib.right_pad(lib.diagnostics, 1),
                lib.right_pad(lib.lsp_status, 0),
                lib.right_pad(lib.lsp_progress, 0),
                lib.fill,
                lib.macro_recording,
                lib.fill,
                lib.left_pad(lib.show_cmd, 0),
                lib.left_pad(lib.treesitter, 1),
                lib.left_pad(lib.search_occurrence, 1),
                lib.left_pad(lib.lazy_update, 1),
                lib.left_pad(lib.git, 1),
                lib.left_pad(lib.file_type, 1),
                lib.left_pad(lib.file_encoding, 1),
                lib.left_pad(lib.scroll_bar, 1),
                lib.left_pad(lib.ruler, 1),
                lib.left_pad(lib.file_format, 1),
            },
        })
    end
}
