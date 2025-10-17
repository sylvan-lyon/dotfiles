local wezterm = require("wezterm")
local catppuccin = require("palattes").catppuccin_mocha
local M = {}

local custom_catppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

custom_catppuccin.ansi = catppuccin:get_ansi_table()
custom_catppuccin.brights = catppuccin:get_bright_table()

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
    config.font_size = 10
    config.font_rules = {
        {
            intensity = "Bold",
            font = wezterm.font_with_fallback(bold_sized_font)
        }
    }

    -------------------- 颜色配置 --------------------
    config.color_schemes = {
        ["custom_catppuccin"] = custom_catppuccin,
    }
    -- config.color_scheme = 'Catppuccin Mocha'
    config.color_scheme = 'custom_catppuccin'

    -------------------- 窗口样式 --------------------
    config.window_decorations = "RESIZE"

    --------------------- tab 栏 ---------------------
    config.use_fancy_tab_bar = false
    config.enable_tab_bar = true
    config.show_tab_index_in_tab_bar = true
    config.hide_tab_bar_if_only_one_tab = false
    config.tab_max_width = 32
    config.show_new_tab_button_in_tab_bar = false
    config.colors = {
        tab_bar = {
            background = catppuccin.base,

            active_tab = {
                bg_color = catppuccin.mauve,
                fg_color = catppuccin.base,
                intensity = "Bold"
            },

            inactive_tab = {
                bg_color = catppuccin.base,
                fg_color = catppuccin.mauve,
                intensity = "Normal"
            }
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
