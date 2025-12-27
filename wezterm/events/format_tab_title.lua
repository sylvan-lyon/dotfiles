local wezterm = require 'wezterm'

local M = {}

local tab_title = function(tab_info, max_width, extra_glyphs)
    local title = tab_info.tab_title
    if title and #title > 0 then
        -- do nothing
    else
        title = tab_info.active_pane.title
    end

    if wezterm.column_width(title) > max_width - extra_glyphs then
        title = '…' .. wezterm.truncate_left(title, max_width - (extra_glyphs + 1))
    end

    return string.gsub(title, '\\', '/')
end

M.apply = function()
    wezterm.on('format-tab-title',
        function(tab, _, _, _, hover, max_width)
            local extra_glyphs = 0

            -- dark
            local base = '#1e1e2e'
            local surface2 = '#585b70'
            local surface1 = '#45475a'
            local surface0 = '#313244'

            -- semi dark
            local overlay2 = '#9399b2'
            local overlay1 = '#7f849c'
            local overlay0 = '#6c7086'

            -- bright
            local text = '#cdd6f4'
            local mauve = '#cba6f7'
            local lavender = '#b4befe'

            -- color preperation
            local index_fg, index_bg
            if tab.is_active then
                index_fg, index_bg = { Color = base }, { Color = mauve }
            else
                index_fg, index_bg = { Color = base }, { Color = overlay2 }
            end

            local main_fg, main_bg
            if tab.is_active then
                main_fg, main_bg = { Color = lavender }, { Color = surface0 }
            else
                if hover then
                    main_fg, main_bg = { Color = lavender }, { Color = surface0 }
                else
                    main_fg, main_bg = { Color = text }, { Color = surface0 }
                end
            end

            -- index part
            local index_str = wezterm.to_string(tab.tab_index + 1) .. ' '
            extra_glyphs = extra_glyphs + (#index_str + 1)
            local index = {
                { Foreground = index_bg },
                { Background = { Color = base } },
                { Text = '' },
                'ResetAttributes',
                -- extra_glyphs += 1

                { Foreground = index_fg },
                { Background = index_bg },
                { Attribute = { Intensity = "Bold" } },
                { Text = index_str },
                'ResetAttributes'
                -- extra_glyphs += #index_str
            }

            -- suffix part
            extra_glyphs = extra_glyphs + 2
            local suffix = {
                { Foreground = main_bg },
                { Background = { Color = base } },
                { Text = ' ' },
                'ResetAttributes'
                -- extra_glyphs += 2
            }

            -- main part
            extra_glyphs = extra_glyphs + 1
            local main = {
                { Background = main_bg },
                { Foreground = main_fg },
                { Attribute = { Intensity = "Bold" } },
                { Text = ' ' .. tab_title(tab, max_width, extra_glyphs) },
                'ResetAttributes',
            }

            local concat_tables = require("utils").concat_tables
            return concat_tables(index, concat_tables(main, suffix))
        end)
end

return M
