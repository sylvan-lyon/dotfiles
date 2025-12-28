local wezterm = require("wezterm")

return {
    apply = function ()
        wezterm.on("update-status", function (window, pane)
            window:set_left_status(wezterm.format {
                { Foreground = { Color = '#b4befe' } },
                { Text = '   ' },
            })
        end)
    end
}
