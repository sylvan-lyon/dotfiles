-- 加载 wezterm API 和获取 config 对象
local wezterm = require("wezterm")
local domains = require("domains")
local config = wezterm.config_builder()


------------ 设置默认的启动shell ----------------
config.default_prog = { "nu" }
config.wsl_domains = domains.wsl_domains

require("events").apply_all()
require("general_setting").apply_to(config)
require("style").apply_to(config)
require("bindings").apply_all_to(config)

return config
