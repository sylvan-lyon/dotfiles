local mod_right_status_bar = require("events.update_right_status_bar")
local mod_gui_startup = require("events.gui_startup")
local mod_tab_title = require("events.format_tab_title")

return {
    apply_right_status_bar = mod_right_status_bar.apply,
    apply_startup = mod_gui_startup.apply,
    apply_tab_title = mod_tab_title.apply,

    apply_all = function()
        mod_right_status_bar.apply()
        mod_gui_startup.apply()
        -- mod_tab_title.apply()
    end
}
