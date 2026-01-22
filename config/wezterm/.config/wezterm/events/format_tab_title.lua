local colors = {
    "#cba6f7",
    "#f38ba8",
    "#eba0ac",
    "#fab387",
    "#f9e2af",
    "#a6e3a1",
    "#89dceb",
    "#89b4fa",
}

require("wezterm").on(
    "format-tab-title",
    function(tab, tabs, panes, config, hover, max_width)
        local theme = require("palettes").catppuccin_mocha
        local palettes = require("palettes").palette.catppuccin_mocha
        return {
            { Background = { Color = theme.background } },
            { Foreground = { Color = tab.is_active and colors[tab.tab_index % #colors + 1] or palettes.overlay0 } },
            { Text = " ●" },
            'ResetAttributes',
        }
    end
)
