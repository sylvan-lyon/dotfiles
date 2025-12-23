return {
    {
        'linrongbin16/lsp-progress.nvim',
        config = function()
            require("lsp-progress").setup({
                format = function(client_messages)
                    local message_count = #client_messages
                    if message_count > 1 then
                        return client_messages[1] .. " …"
                    elseif message_count == 1 then
                        return client_messages[1]
                    else
                        return ""
                    end
                end,

                client_format = function(client_name, spinner, series_messages)
                    return #series_messages > 0
                        and ("[" .. client_name .. "] " .. spinner .. " " .. series_messages[1])
                        or nil
                end,

                series_format = function(title, message, percentage, done)
                    local builder = {}
                    local has_title = false
                    local has_message = false

                    -- 添加 title
                    if type(title) == "string" and string.len(title) > 0 then
                        table.insert(builder, title)
                        has_title = true
                    else
                        table.insert(builder, "")
                    end

                    -- 检查 message 因为通常这个东西最长然后给他一个合理的默认值
                    if type(message) == "string" and string.len(message) > 0 then
                        has_message = true
                    else
                        message = ""
                    end

                    -- 检查 percentage 并添加
                    if percentage and (has_title or has_message) then
                        table.insert(builder, string.format("(%.0f%%)", percentage))
                    else
                        table.insert(builder, "")
                    end

                    -- 检查 done
                    if done and (has_title or has_message) then
                        table.insert(builder, "- done")
                    else
                        table.insert(builder, "")
                    end

                    -- 检查 message 是否过长，如果过程，那么就需要裁剪
                    local max_length = 40 - string.len(builder[1]) + string.len(builder[2]) + string.len(builder[3])
                    local should_truncate = string.len(message) > max_length
                    if should_truncate then
                        message = string.sub(message, 1, max_length - 1)
                        message = message .. "…"
                    end

                    table.insert(builder, 3, message)

                    return table.concat(builder, " ")
                end,

                spinner = {
                    " ", -- new
                    " ", " ", " ", " ", " ", " ", -- waxing crescent
                    " ", -- first quarter
                    " ", " ", " ", " ", " ", " ", -- waxing gibbous
                    " ", -- full
                    " ", " ", " ", " ", " ", " ", -- waning gibbous
                    " ", -- last quarter
                    " ", " ", " ", " ", " ", " ", -- waning crescent
                }
            })
        end
    },

    {
        -- 底部栏美化
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            'linrongbin16/lsp-progress.nvim',
            "catppuccin/nvim",
        },
        lazy = false,
        config = function(_, _)
            require("lualine").setup {
                options = {
                    theme = "catppuccin",
                    always_devide_middle = false,
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '│', right = '│' },
                    globalstatus = false,
                },
                sections = {
                    lualine_a = {
                        "mode"
                    },
                    lualine_b = {
                        { "branch" },
                        { "diff" },
                        { "diagnostics", update_in_insert = true },
                        {
                            "filename",
                            path = 1,
                            fmt = function(content, _)
                                local normalized = content:gsub("\\", "/")
                                return normalized
                            end
                        }
                    },
                    lualine_c = {
                        { function() return require('lsp-progress').progress() end },
                    },
                    lualine_x = {
                        { 'lsp_status',                   symbols = { spinner = {} } },
                        { require("lazy.status").updates, cond = require("lazy.status").has_updates },
                    },
                    lualine_y = { "encoding", "fileformat", "filestyle", "filesize" },
                    lualine_z = { "location" },
                },
                winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { 'filename' }
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = { 'filename' },
                    lualine_z = {}
                },
                extensions = {
                    "mason", "neo-tree", "lazy"
                },

            }

            -- listen lsp-progress event and refresh lualine
            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                ---@diagnostic disable-next-line: assign-type-mismatch
                callback = require("lualine").refresh,
            })
        end
    }
}
