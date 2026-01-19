local wezterm = require("wezterm")
local palatte = require("palettes").palette.catppuccin_mocha

local reset = "ResetAttributes"
local section_spliter = wezterm.format {
    { Foreground = { Color = "#cba6f7" } },
    { Attribute = { Intensity = "Bold" } },
    { Text = "  " },
    reset,
}
local hour_frames = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " " }
local month_frames = { "Jan.", "Feb.", "Mar.", "Apr.", "May", "Jun.", "Jul.", "Aug.", "Sept.", "Otc.", "Nov.", "Dec." }
local days = {}

function days:to_string(number)
    local ret = tostring(number)
    if number == 11 or number == 12 then
        return ret .. "th"
    end
    local tail = number % 10
    if (tail == 1) then
        ret = ret .. "st"
    elseif (tail == 2) then
        ret = ret .. "nd"
    elseif (tail == 3) then
        ret = ret .. "rd"
    else
        ret = ret .. "th"
    end
    return ret
end

local make_right_status = function(window)
    local now = os.date("*t")
    local right_prompt = ""

    local current_key_table = window:active_key_table()
    if current_key_table then
        right_prompt = right_prompt .. wezterm.format {
            { Foreground = { Color = palatte.mauve } },
            { Attribute = { Intensity = "Bold" } },
            { Text = " " .. current_key_table },
            reset,
            { Text = section_spliter }
        }
    end

    local month_txt = month_frames[now.month]
    local day_txt = days:to_string(now.day)
    right_prompt = right_prompt .. wezterm.format {
        { Foreground = { Color = palatte.teal } },
        { Attribute = { Intensity = "Bold" } },
        { Text = "󰸘 " .. month_txt .. " " .. day_txt },
        reset,
        { Text = section_spliter },
    }

    local hour_icon = hour_frames[now.hour % 12 + 1]
    right_prompt = right_prompt .. wezterm.format {
        { Foreground = { Color = palatte.lavender } },
        { Attribute = { Intensity = "Bold" } },
        { Text = hour_icon .. string.format("%02d:%02d", now.hour, now.min) },
        reset
    }
    window:set_right_status(right_prompt)
end

wezterm.on("update-right-status", make_right_status)
