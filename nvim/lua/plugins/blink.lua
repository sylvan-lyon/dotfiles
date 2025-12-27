local super_tab = {
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },

    ['<Tab>'] = {
        function(cmp)
            if cmp.snippet_active() then
                return cmp.accept()
            else
                return cmp.select_and_accept()
            end
        end,
        'snippet_forward',
        'fallback'
    },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
}

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

                keymap = super_tab,

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

                    keymap = super_tab,
                },
            })
        end,

        opts_extend = { "sources.default" }
    }
}
