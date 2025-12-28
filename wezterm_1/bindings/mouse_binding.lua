local wezterm = require("wezterm")

local act = wezterm.action
local M = {}

M.apply_to = function(config)
    -- 在按下 Alt 后再使用鼠标, 鼠标信息将不再会传递给 shell 中运行的程序
    config.bypass_mouse_reporting_modifiers = "ALT"
    config.mouse_bindings = {
        -- 打开超链接
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = act.OpenLinkAtMouseCursor,
        },
        {
            event = { Down = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = act.Nop
        },

        -- 单击选一个字, 其实没什么用, 主要是为了长按拖拽的
        {
            event = { Down = { streak = 1, button = "Left" } },
            action = act.SelectTextAtMouseCursor("Cell"),
        },
        {
            event = { Up = { streak = 1, button = "Left" } },
            action = act.Nop
        },

        -- 双击选一个词
        {
            event = { Down = { streak = 2, button = "Left" } },
            action = act.SelectTextAtMouseCursor("Word"),
        },
        {
            event = { Up = { streak = 2, button = "Left" } },
            action = act.Nop
        },

        -- 三击选一行
        {
            event = { Down = { streak = 3, button = "Left" } },
            action = act.SelectTextAtMouseCursor("Line"),
        },
        {
            event = { Up = { streak = 3, button = "Left" } },
            action = act.Nop
        },

        -- 单机后拖拽, 每拖一下多选一个字
        {
            event = { Drag = { streak = 1, button = "Left" } },
            action = act.ExtendSelectionToMouseCursor("Cell"),
        },
        -- 双击后拖拽, 每拖一下多选一个词
        {
            event = { Drag = { streak = 2, button = "Left" } },
            action = act.ExtendSelectionToMouseCursor("Word"),
        },
        -- 三击后拖拽, 每拖一下多选一行
        {
            event = { Drag = { streak = 3, button = "Left" } },
            action = act.ExtendSelectionToMouseCursor("Line"),
        },

        -- 鼠标滚动事件
        {
            event = { Down = { streak = 1, button = { WheelUp = 1 } } },
            action = act.ScrollByLine(-5),
        },
        {
            event = { Down = { streak = 1, button = { WheelDown = 1 } } },
            action = act.ScrollByLine(5),
        },

        -- 鼠标滚动调整字体大小
        {
            event = { Down = { streak = 1, button = { WheelUp = 1 } } },
            mods = "CTRL",
            action = act.IncreaseFontSize,
        },
        {
            event = { Down = { streak = 1, button = { WheelDown = 1 } } },
            mods = "CTRL",
            action = act.DecreaseFontSize,
        },
    }
end

return M
