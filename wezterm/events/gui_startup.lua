local wezterm = require("wezterm")

-------------------- 窗口居中 --------------------
local spwan_centered_window = function(cmd)
    local screen = wezterm.gui.screens().active
    local width, height = screen.width * 0.618, screen.height * 0.618
    local _, _, window = wezterm.mux.spawn_window(cmd or {
        position = {
            x = (screen.width - width) / 2,
            y = (screen.height - height) / 2,
            origin = { Named = screen.name },
        },
    })
    window:gui_window():set_inner_size(width, height)
end

------------------ 执行窗口生成 ------------------
local execute_startup = function(cmd)
    spwan_centered_window(cmd)
end

local M = {}
M.apply = function()
    wezterm.on("gui-startup", execute_startup)
end

return M
