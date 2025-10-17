local wezterm = require 'wezterm'

local M = {}

local tab_title = function(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        -- 如果主动设定了标题名称，那么使用这个名称
        return title, true
    else
        -- 否则使用默认的名称，大多数情况下应该都是这个
        return tab_info.active_pane.title, false
    end
end

M.apply = function()
    wezterm.on('format-tab-title',
        function(tab, tabs, panes, config, hover, max_width)
            local edge_background = '#0b0022'
            local background = '#1b1032'
            local foreground = '#808080'

            if tab.is_active then
                background = '#2b2042'
                foreground = '#c0c0c0'
            elseif hover then
                background = '#3b3052'
                foreground = '#909090'
            end

            local edge_foreground = background

            local title = tab_title(tab)

            -- ensure that the titles fit in the available space,
            -- and that we have room for the edges.
            title = wezterm.truncate_right(title, max_width - 2)

            return {
                { Background = { Color = edge_background } },
                { Foreground = { Color = edge_foreground } },
                { Text = "<" },
                { Background = { Color = background } },
                { Foreground = { Color = foreground } },
                { Text = title .. tab.tab_id },
                { Background = { Color = edge_background } },
                { Foreground = { Color = edge_foreground } },
                { Text = ">" },
            }
        end
    )
end

return M
