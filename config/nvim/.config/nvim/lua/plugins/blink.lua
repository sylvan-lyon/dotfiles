-- local keymap = {
--     ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
--     ['<C-e>'] = { 'hide', 'fallback' },
--     ['<C-y>'] = { 'select_and_accept', 'fallback' },
--
--     ['<Up>'] = { 'select_prev', 'fallback' },
--     ['<Down>'] = { 'select_next', 'fallback' },
--     ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
--     ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
--
--     ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
--     ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
--
--     ['<Tab>'] = { 'snippet_forward', 'fallback' },
--     ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
--
--     ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
-- }

return {
    {
        'saghen/blink.cmp',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = { "InsertEnter", "CmdlineEnter" },
        version = '1.*',
        config = function(_, _)
            require("blink-cmp").setup({
                appearance = {
                    nerd_font_variant = 'normal'
                },

                keymap = {
                    preset = "default",
                },

                sources = {
                    default = { 'lsp', 'buffer', 'snippets', 'path' },
                },

                fuzzy = {
                    implementation = "prefer_rust_with_warning",
                    sorts = {
                        "exact",
                        "score",
                        "sort_text",
                        "kind",
                    },
                },

                completion = {
                    menu = {
                        min_width = 25,
                        max_height = 16,
                        auto_show = true,
                    },
                    accept = { auto_brackets = { enabled = true } },
                    list = { selection = { preselect = true, auto_insert = false } },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 500,
                        window = {
                            max_height = 32,
                            max_width = 120,
                        }
                    },
                    ghost_text = {
                        enabled = false,
                        show_with_selection = true,
                        show_without_selection = false,
                        show_with_menu = true,
                        show_without_menu = true,
                    },
                },

                signature = { enabled = true },

                cmdline = {
                    completion = {
                        menu = { auto_show = true },
                        ghost_text = { enabled = false },
                    },

                    keymap = {
                        preset = "default",
                    },
                },
            })
        end,

        opts_extend = { "sources.default" }
    }
}
