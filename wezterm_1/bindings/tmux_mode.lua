local wezterm = require("wezterm")
local act = wezterm.action

return {
    -- 更符合直觉的窗格分割
    { key = "\\",     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-",      action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "x",      action = act.CloseCurrentPane({ confirm = true }) },
    { key = "z",      action = act.TogglePaneZoomState },

    -- 窗格导航
    { key = "h",      action = act.ActivatePaneDirection("Left") },
    { key = "j",      action = act.ActivatePaneDirection("Down") },
    { key = "k",      action = act.ActivatePaneDirection("Up") },
    { key = "l",      action = act.ActivatePaneDirection("Right") },

    -- 调整窗格大小 (vim 风格)
    { key = "H",      mods = "SHIFT",                                    action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "J",      mods = "SHIFT",                                    action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "H",      mods = "SHIFT",                                    action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "L",      mods = "SHIFT",                                    action = act.AdjustPaneSize({ "Right", 1 }) },

    -- 快速调整窗格大小
    { key = "k",      mods = "ALT",                                      action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "j",      mods = "ALT",                                      action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "h",      mods = "ALT",                                      action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "l",      mods = "ALT",                                      action = act.AdjustPaneSize({ "Right", 5 }) },

    -- 标签页管理
    { key = "c",      action = act.SpawnTab("CurrentPaneDomain") },
    { key = "p",      action = act.ActivateTabRelative(-1) },
    { key = "n",      action = act.ActivateTabRelative(1) },
    { key = "&",      mods = "SHIFT",                                    action = act.CloseCurrentTab({ confirm = true }) },

    -- 复制模式
    { key = "[",      action = act.ActivateCopyMode },
    { key = "]",      action = act.PasteFrom("Clipboard") },
    { key = " ",      action = act.QuickSelect },

    -- 退出键表（再按一次前缀键或ESC）
    { key = "`",      mods = "CTRL",                                     action = "PopKeyTable" },
    { key = "Escape", mods = "CTRL",                                     action = "PopKeyTable" },
}
