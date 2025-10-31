local wezterm = require("wezterm")
local act = wezterm.action

local keymaps = {}

-- tmux 的键位
keymaps.tmux_mode = {
    name = "tmux mode",
    timeout_milliseconds = 1000,
    one_shot = false,

    keys = {
        -- 更符合直觉的窗格分割
        { key = "\\",     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { key = "-",      action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
        { key = "x",      action = act.CloseCurrentPane({ confirm = false }) },
        { key = "z",      action = act.TogglePaneZoomState },

        -- 窗格导航 (vim 风格)
        { key = "h",      action = act.ActivatePaneDirection("Left") },
        { key = "j",      action = act.ActivatePaneDirection("Down") },
        { key = "k",      action = act.ActivatePaneDirection("Up") },
        { key = "l",      action = act.ActivatePaneDirection("Right") },

        -- 调整窗格大小 (vim 风格)
        { key = "H",      mods = "SHIFT",                                                action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "J",      mods = "SHIFT",                                                action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "H",      mods = "SHIFT",                                                action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "L",      mods = "SHIFT",                                                action = act.AdjustPaneSize({ "Right", 1 }) },
        -- 快速调整窗格大小
        { key = "k",      mods = "ALT",                                                  action = act.AdjustPaneSize({ "Up", 5 }) },
        { key = "j",      mods = "ALT",                                                  action = act.AdjustPaneSize({ "Down", 5 }) },
        { key = "h",      mods = "ALT",                                                  action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "l",      mods = "ALT",                                                  action = act.AdjustPaneSize({ "Right", 5 }) },

        -- 标签页管理
        { key = "c",      action = act.SpawnTab("CurrentPaneDomain") },
        { key = "p",      action = act.ActivateTabRelative(-1) },
        { key = "n",      action = act.ActivateTabRelative(1) },
        { key = "&",      mods = "SHIFT",                                                action = act.CloseCurrentTab({ confirm = false }) },

        -- 复制模式
        { key = "[",      action = act.ActivateCopyMode },
        { key = "]",      action = act.PasteFrom("Clipboard") },

        -- 退出键表（再按一次前缀键或ESC）
        { key = "F1",     action = "PopKeyTable" },
        { key = "Escape", action = "PopKeyTable" },
    },
}

-- 普通的不依赖 tmux 模式的键位
keymaps.keys = {
    -- 标签页快捷键
    { key = "[",         mods = "CTRL",       action = act.ActivateTabRelative(-1) },
    { key = "]",         mods = "CTRL",       action = act.ActivateTabRelative(1) },

    -- 复制/粘贴
    { key = "C",         mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "V",         mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

    -- 向上 / 向下滚动
    { key = "UpArrow",   mods = "CTRL",       action = act.ScrollByLine(-1) },
    { key = "DownArrow", mods = "CTRL",       action = act.ScrollByLine(1) },
    { key = "UpArrow",   mods = "CTRL|ALT",   action = act.ScrollByPage(-0.618) },
    { key = "DownArrow", mods = "CTRL|ALT",   action = act.ScrollByPage(0.618) },

    -- Ctrl "=" Ctrl "-" 增减字体大小, Ctrl 0 回复字体大小
    { key = "0",         mods = "CTRL",       action = act.ResetFontSize },
    { key = "-",         mods = "CTRL",       action = act.DecreaseFontSize },
    { key = "=",         mods = "CTRL",       action = act.IncreaseFontSize },

    -- 激活前缀键并进入 tmux 模式
    {
        key = "F1",
        action = act.ActivateKeyTable({
            name = keymaps.tmux_mode.name,
            one_shot = keymaps.tmux_mode.one_shot,
            timeout_milliseconds = keymaps.tmux_mode.timeout_milliseconds,
        }),
    },

    -- 最大化窗口 / 恢复窗口
    {
        key = "UpArrow",
        mods = "SUPER",
        action = wezterm.action_callback(function(window, _)
            window:maximize() -- 最大化窗口
        end),
    },
    {
        key = "DownArrow",
        mods = "SUPER",
        action = wezterm.action_callback(function(window, _)
            window:restore() -- 恢复原始大小
        end),
    },

    -- Ctrl Shift ` 作为头一个, 为什么不用 0 呢? 太远了够不到
    {
        key = "~",
        mods = "CTRL|SHIFT",
        action = act.SpawnTab "DefaultDomain",
    },
    {
        key = '!',
        mods = 'CTRL|SHIFT',
        action = act.SpawnTab {
            DomainName = "wsl:fedora",
        },
    },
    {
        key = '@',
        mods = 'CTRL|SHIFT',
        action = act.SpawnCommandInNewTab {
            args = { 'psql', '-U', 'postgres' },
            domain = "DefaultDomain"
        }
    },
    {
        key = '#',
        mods = 'CTRL|SHIFT',
        action = act.SpawnCommandInNewTab {
            args = { 'pwsh' },
            domain = "DefaultDomain"
        }
    },
    {
        key = '$',
        mods = 'CTRL|SHIFT',
        action = act.SpawnCommandInNewTab {
            args = { 'cmd' },
            domain = "DefaultDomain"
        }
    },
}

keymaps.apply_to = function(config)
    config.key_map_preference = "Physical"
    -- 注册键表
    config.key_tables = {
        [keymaps.tmux_mode.name] = keymaps.tmux_mode.keys,
    }

    -- 注册普通的键位绑定
    config.keys = keymaps.keys

    -- CTRL + 数字键切换标签页
    for i = 1, 9 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = "CTRL",
            action = act.ActivateTab(i - 1),
        })
    end

    table.insert(config.keys, {
        key = tostring(0),
        mods = "CTRL",
        action = act.ActivateTab(9),
    })
end

return keymaps
