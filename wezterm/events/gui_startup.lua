local wezterm = require("wezterm")

-------------------- 窗口居中 --------------------
local spwan_centered_window = function(cmd)
    local screen = wezterm.gui.screens().active
    local _, _, window = wezterm.mux.spawn_window(cmd or {})
    local dimension = window:gui_window():get_dimensions()
    local width, height = dimension.pixel_width, dimension.pixel_height
    window:gui_window():set_position(
        (screen.width - width) / 2,
        (screen.height - height) / 2
    )
end

local M = {}
M.apply = function()
    wezterm.on("gui-startup", spwan_centered_window)
end

return M
