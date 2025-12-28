local right_status_bar = require("events.update_right_status")
local left_status_bar = require("events.update_left_status")
local gui_startup = require("events.gui_startup")
local tab_title = require("events.format_tab_title")

return {
    apply_right_status_bar = right_status_bar.apply,
    apply_left_status_bar = left_status_bar.apply,
    apply_startup = gui_startup.apply,
    apply_tab_title = tab_title.apply,

    apply_all = function()
        right_status_bar.apply()
        left_status_bar.apply()
        gui_startup.apply()
        tab_title.apply()
    end
}
