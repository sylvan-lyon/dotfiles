-- 加载 wezterm API 和获取 config 对象
local wezterm = require("wezterm")
local domains = require("domains")
local config = wezterm.config_builder()


------------ 设置默认的启动shell ----------------
config.default_prog = { "nu" }
config.wsl_domains = domains.wsl_domains
config.disable_default_key_bindings = true
config.disable_default_mouse_bindings = true

-- 取消缩放字体时窗口大小的变化
config.adjust_window_size_when_changing_font_size = false

-- 性能设置
config.front_end = "WebGpu"
config.max_fps = 255
config.animation_fps = 255

config.status_update_interval = 16

config.initial_cols = 140
config.initial_rows = 40

require("events.gui_startup")
require("style").apply_to(config)
require("bindings").apply_all_to(config)
require("events.format_tab_title")
require("events.update_left_status")
require("events.update_right_status")

return config
