local _catppuccin_mocha = {
    ansi = {
        black  = "#45475a",
        red    = "#f38ba8",
        green  = "#a6e3a1",
        yellow = "#f9e2af",
        blue   = "#89b4fa",
        pink   = "#f5c2e7",
        cyan   = "#94e2d5",
        white  = "#a6adc8",
    },

    bright = {
        black  = "#585b70",
        red    = "#f37799",
        green  = "#89d88b",
        yellow = "#ebd391",
        blue   = "#74a8fc",
        pink   = "#f2aede",
        cyan   = "#6bd7ca",
        white  = "#bac2de",
    },

    base = "#1e1e2e",
    mauve = "#cba6f7",
    lavender = "#b4befe",
    text_color = "#cdd6f4",
}

function _catppuccin_mocha:get_ansi_table()
    return {
        "#45475a",
        "#f38ba8",
        "#a6e3a1",
        "#f9e2af",
        "#89b4fa",
        "#f5c2e7",
        "#94e2d5",
        "#a6adc8",
    }
end

function _catppuccin_mocha:get_bright_table()
    return {
        "#585b70",
        "#f37799",
        "#89d88b",
        "#ebd391",
        "#74a8fc",
        "#f2aede",
        "#6bd7ca",
        "#bac2de",
    }
end

return {
    catppuccin_mocha = _catppuccin_mocha
}
