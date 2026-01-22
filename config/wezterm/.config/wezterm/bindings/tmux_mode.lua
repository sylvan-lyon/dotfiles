local wezterm = require("wezterm")
local act = wezterm.action

return {
    { key = "%",      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }), mods = "SHIFT" },
    { key = "\"",     action = act.SplitVertical({ domain = "CurrentPaneDomain" }),   mods = "SHIFT" },
    { key = "x",      action = act.CloseCurrentPane({ confirm = true }) },
    { key = "z",      action = act.TogglePaneZoomState },

    -- 窗格导航
    { key = "h",      action = act.ActivatePaneDirection("Left") },
    { key = "j",      action = act.ActivatePaneDirection("Down") },
    { key = "k",      action = act.ActivatePaneDirection("Up") },
    { key = "l",      action = act.ActivatePaneDirection("Right") },

    -- -- resize panes
    -- { key = "k",      action = act.AdjustPaneSize({ "Up", 5 }),                      mods = "ALT" },
    -- { key = "j",      action = act.AdjustPaneSize({ "Down", 5 }),                    mods = "ALT" },
    -- { key = "h",      action = act.AdjustPaneSize({ "Left", 5 }),                    mods = "ALT" },
    -- { key = "l",      action = act.AdjustPaneSize({ "Right", 5 }),                   mods = "ALT" },

    -- windows
    { key = "c",      action = act.SpawnTab("CurrentPaneDomain") },
    { key = "p",      action = act.ActivateTabRelative(-1) },
    { key = "n",      action = act.ActivateTabRelative(1) },
    { key = "&",      action = act.CloseCurrentTab({ confirm = true }),               mods = "SHIFT" },

    { key = "[",      action = act.ActivateCopyMode },
    { key = " ",      action = act.QuickSelect },

    -- 退出键表（再按一次前缀键或ESC）
    { key = "b",      action = "PopKeyTable",                                         mods = "CTRL" },
    { key = "Escape", action = "PopKeyTable" },
}
