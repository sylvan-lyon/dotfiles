local wezterm = require("wezterm")
local M = {}

M.apply_to = function(config)
    ------------------ 设置字体 ---------------------
    local regular_sized_font = {
        { family = "Maple Mono NF CN", weight = "Regular" },
        { family = "JetBrainsMono Nerd Font", weight = "Regular" },
        { family = "consolas", weight = "Regular" },
    }

    local bold_sized_font = {
        { family = "Maple Mono NF CN", weight = "Bold" },
        { family = "JetBrainsMono Nerd Font", weight = "Bold" },
        { family = "consolas", weight = "Bold" },
    }

    config.font = wezterm.font_with_fallback(regular_sized_font)
    config.font_size = 11
    config.font_rules = {
        {
            intensity = "Bold",
            font = wezterm.font_with_fallback(bold_sized_font)
        }
    }
    -- 修改线的粗细比如说字母下划线的粗细、还有分隔符的渲染
    config.underline_thickness = "150%"

    -------------------- 颜色配置 --------------------
    config.color_schemes = {
        ["custom_catppuccin"] = require("palettes").catppuccin_mocha,
    }
    config.color_scheme = "Catppuccin Mocha"
    -- config.color_scheme = 'custom_catppuccin'

    -------------------- 窗口样式 --------------------
    config.window_decorations = "RESIZE"

    --------------------- tab 栏 ---------------------
    config.use_fancy_tab_bar = false
    config.enable_tab_bar = true
    config.show_tab_index_in_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = false
    config.tab_max_width = 32
    config.show_new_tab_button_in_tab_bar = false
    config.bold_brightens_ansi_colors = false

    config.colors = {
        tab_bar = {
            background = require("palettes").palette.catppuccin_mocha.base,
        }
    }

    --------------------- pane美化 -------------------
    config.inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.618,
    }

    config.window_padding = {
        left = "2.3cell",
        right = "2.3cell",
        top = "0.8cell",
        bottom = "0.25cell",
    }

    ------------------ 光标样式 ---------------------
    config.default_cursor_style = "BlinkingBlock"
    config.cursor_blink_ease_in = "EaseOut"
    config.cursor_blink_ease_out = "EaseOut"
    config.cursor_blink_rate = 618
end

return M
