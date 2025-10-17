-- 加载 wezterm API 和获取 config 对象
local wezterm = require("wezterm")
local domains = require("domains")
local config = wezterm.config_builder()


------------ 设置默认的启动shell ----------------
config.default_prog = { "nu" }
config.wsl_domains = domains.wsl_domains

------------------- tab 标题 --------------------
-- wezterm.on("format-tab-title", function (tab, tabs, _, _, hover, max_width)
--   local tab_styles
--   if tab.is_active then
--     tab_styles = {
--       { Background = { Color = "#cba6f7" } },
--       { Attribute = { Intensity = "Bold" } }
--     }
--   else
--     tab_styles = {
--       { Background = { Color = "#1e1e2e" } }
--     }
--   end

--   return table.concat(tab_styles, tab.active_pane.title)
-- end)

require("events.init").apply_all()
require("general_setting").apply_to(config)
require("style").apply_to(config)
require("bindings.init").apply_all_to(config)

return config
