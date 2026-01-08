local wezterm = require("wezterm")
local act = wezterm.action

local normal_key_bindings = {
    {
        -- tmux mod for multiplexing
        key = "`",
        mods = "CTRL",
        action = act.ActivateKeyTable({
            name = "tmux mode",
            one_shot = false,
            timeout_milliseconds = 800,
            until_unknown = false,
        })
    },

    { key = "D",         mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },

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

    -- {
    --     key = "UpArrow",
    --     mods = "SUPER",
    --     action = wezterm.action_callback(function(window, _)
    --         window:maximize()         -- 最大化窗口
    --     end),
    -- },
    -- {
    --     key = "DownArrow",
    --     mods = "SUPER",
    --     action = wezterm.action_callback(function(window, _)
    --         window:restore()         -- 恢复原始大小
    --     end),
    -- },
    --

    {
        key = "~",
        mods = "CTRL|SHIFT",
        action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
        key = "!",
        mods = "CTRL|SHIFT",
        action = act.SpawnTab("DefaultDomain"),
    },
    {
        key = '@',
        mods = 'CTRL|SHIFT',
        action = act.SpawnTab({ DomainName = "wsl:fedora" }),
    },
    {
        key = '#',
        mods = 'CTRL|SHIFT',
        action = act.SpawnCommandInNewTab {
            args = { 'psql', '-U', 'postgres' },
            domain = "DefaultDomain"
        }
    },
    {
        key = '$',
        mods = 'CTRL|SHIFT',
        action = act.SpawnCommandInNewTab {
            args = { 'pwsh' },
            domain = "DefaultDomain"
        }
    },
    {
        key = '%',
        mods = 'CTRL|SHIFT',
        action = act.SpawnCommandInNewTab {
            args = { 'cmd' },
            domain = "DefaultDomain"
        }
    },
}

return {
    apply_to = function(wezterm_config)
        wezterm_config.keys = normal_key_bindings
        wezterm_config.key_tables = {
            ["tmux mode"] = require("bindings.tmux_mode")
        }
    end
}
