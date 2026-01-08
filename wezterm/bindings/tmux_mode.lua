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
    { key = "H",      action = act.AdjustPaneSize({ "Up", 1 }),                      mods = "SHIFT" },
    { key = "J",      action = act.AdjustPaneSize({ "Down", 1 }),                    mods = "SHIFT" },
    { key = "H",      action = act.AdjustPaneSize({ "Left", 1 }),                    mods = "SHIFT" },
    { key = "L",      action = act.AdjustPaneSize({ "Right", 1 }),                   mods = "SHIFT" },

    -- 快速调整窗格大小
    { key = "k",      action = act.AdjustPaneSize({ "Up", 5 }),                      mods = "ALT" },
    { key = "j",      action = act.AdjustPaneSize({ "Down", 5 }),                    mods = "ALT" },
    { key = "h",      action = act.AdjustPaneSize({ "Left", 5 }),                    mods = "ALT" },
    { key = "l",      action = act.AdjustPaneSize({ "Right", 5 }),                   mods = "ALT" },

    -- 标签页管理
    { key = "c",      action = act.SpawnTab("CurrentPaneDomain") },
    { key = "p",      action = act.ActivateTabRelative(-1) },
    { key = "n",      action = act.ActivateTabRelative(1) },
    { key = "&",      action = act.CloseCurrentTab({ confirm = true }),              mods = "SHIFT" },

    -- 标签页快捷键
    { key = "[",      action = act.ActivateTabRelative(-1), },
    { key = "]",      action = act.ActivateTabRelative(1), },

    -- 复制
    { key = " ",      action = act.ActivateCopyMode,                                 mods = "SHIFT" },
    { key = " ",      action = act.QuickSelect },

    -- 退出键表（再按一次前缀键或ESC）
    { key = "`",      action = "PopKeyTable",                                        mods = "CTRL" },
    { key = "Escape", action = "PopKeyTable" },
}
