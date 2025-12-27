local palette = {
    catppuccin_mocha = {
        rosewater = "#f5e0dc",
        flamingo  = "#f2cdcd",
        pink      = "#f5c2e7",
        mauve     = "#cba6f7",
        red       = "#f38ba8",
        maroon    = "#eba0ac",
        peach     = "#fab387",
        yellow    = "#f9e2af",
        green     = "#a6e3a1",
        teal      = "#94e2d5",
        sky       = "#89dceb",
        sapphire  = "#74c7ec",
        blue      = "#89b4fa",
        lavender  = "#b4befe",

        text      = "#cdd6f4",
        subtext1  = "#bac2de",
        subtext2  = "#a6adc8",

        overlay2  = "#9399b2",
        overlay1  = "#7f849c",
        overlay0  = "#6c7086",

        surface2  = "#585b70",
        surface1  = "#45475a",
        surface0  = "#313244",

        base      = "#1e1e2e",
        mantle    = "#181825",
        crust     = "#11111b",
    }
}

return {
    palette = palette,
    catppuccin_mocha = {
        foreground = palette.catppuccin_mocha.text,
        background = palette.catppuccin_mocha.base,

        cursor_fg = "#11111b",
        cursor_bg = "#f5e0dc",
        cursor_border = "#6c7086",

        selection_fg = "#cdd6f4",
        selection_bg = "#9399b2",

        scrollbar_thumb = nil,
        split = nil,

        ansi = {
            "#45475a",
            "#f38ba8",
            "#a6e3a1",
            "#f9e2af",
            "#89b4fa",
            "#f5c2e7",
            "#94e2d5",
            "#a6adc8",
        },

        brights = {
            "#585b70",
            "#f37799",
            "#89d88b",
            "#ebd391",
            "#74a8fc",
            "#f2aede",
            "#6bd7ca",
            "#bac2de",
        },
    }
}
