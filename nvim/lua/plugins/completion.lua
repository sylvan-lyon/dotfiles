return {
    {
        'saghen/blink.cmp',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "onsails/lspkind.nvim",
        },

        version = '1.*',

        opts = {
            appearance = {
                nerd_font_variant = 'normal'
            },

            keymap = {
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

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },

            sources = {
                default = function()
                    local success, node = pcall(vim.treesitter.get_node)
                    if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
                        return { "buffer" }
                    else
                        return { "lsp", "path", "snippets", "buffer" }
                    end
                end,
                providers = {
                    path = {
                        score_offset = 95,
                        opts = {
                            get_cwd = function(_)
                                return vim.fn.getcwd()
                            end,
                        },
                    },
                    buffer = {
                        score_offset = 20,
                    },
                    lsp = {
                        -- Default
                        -- Filter text items from the LSP provider, since we have the buffer provider for that
                        transform_items = function(_, items)
                            return vim.tbl_filter(function(item)
                                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
                            end, items)
                        end,
                        score_offset = 60,
                        fallbacks = { "buffer" },
                    },
                    -- Hide snippets after trigger character
                    -- Trigger characters are defined by the sources. For example, for Lua, the trigger characters are ., ", '.
                    snippets = {
                        score_offset = 70,
                        should_show_items = function(ctx)
                            return ctx.trigger.initial_kind ~= "trigger_character"
                        end,
                        fallbacks = { "buffer" },
                    },
                    cmdline = {
                        min_keyword_length = 2,
                        -- Ignores cmdline completions when executing shell commands
                        enabled = function()
                            return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                        end,
                    },
                },
            },

            fuzzy = {
                implementation = "prefer_rust_with_warning",
                sorts = {
                    "exact",
                    -- defaults
                    "score",
                    "sort_text",
                },
            },

            completion = {
                accept = { auto_brackets = { enabled = true } },
                list = { selection = { preselect = true, auto_insert = false } },
                menu = {
                    max_height = 20,
                    draw = {
                        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    -- nvim-web-devicons 集成
                                    local icon = ctx.kind_icon
                                    if icon then
                                        -- Do nothing
                                    elseif vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                                    end
                                    return icon .. ctx.icon_gap
                                end,
                                highlight = function(ctx)
                                    -- nvim-web-devicons 集成
                                    local hl = ctx.kind_hl
                                    if hl then
                                        -- Do nothing
                                    elseif vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    draw = function(opts) opts.default_implementation() end,
                    window = {
                        min_width = 10,
                        max_width = 120,
                        max_height = 20,
                        winblend = 0,
                        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
                        scrollbar = true,
                        direction_priority = {
                            menu_north = { "e", "w", "n", "s" },
                            menu_south = { "e", "w", "s", "n" },
                        },
                    },
                },
                ghost_text = {
                    enabled = true,
                    show_with_selection = true,
                    show_without_selection = false,
                    show_with_menu = true,
                    show_without_menu = true,
                },
            },

            signature = {
                enabled = true,
                window = {
                    min_width = 1,
                    max_width = 100,
                    max_height = 10,
                    border = "single",
                    winblend = 0,
                    winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
                    scrollbar = false,
                    direction_priority = { "n" },
                    treesitter_highlighting = true,
                    show_documentation = true,
                },
            },

            cmdline = {
                completion = {
                    menu = {
                        auto_show = true,
                    },
                },
            },
        },

        opts_extend = { "sources.default" }
    }
}
