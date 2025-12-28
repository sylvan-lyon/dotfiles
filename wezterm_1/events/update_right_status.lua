local wezterm = require("wezterm")
local palatte = require("palattes").catppuccin_mocha

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

local proc_frames = {
    " ", -- new
    " ", " ", " ", " ", " ", " ", -- waxing crescent
    " ", -- first quarter
    " ", " ", " ", " ", " ", " ", -- waxing gibbous
    " ", -- full
    " ", " ", " ", " ", " ", " ", -- waning gibbous
    " ", -- last quarter
    " ", " ", " ", " ", " ", " ", -- waning crescent
}

function days:to_string(number)
    local ret = tostring(number)
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

local make_right_status = function(window, pane)
    local now = os.date("*t")
    local right_prompt = ""

    -- key table 显示
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

    local cwd, proc = string.match(pane:get_title(), "(.*)> (.*)")
    -- 如果 cwd 和 proc 都有效，那么设置当前进程模块
    if (cwd and proc) then
        local proc_icon = proc_frames[os.time() *2 % #proc_frames + 1]
        right_prompt = right_prompt .. wezterm.format {
            { Foreground = { Color = palatte.ansi.blue } },
            { Attribute = { Intensity = "Bold" } },
            { Text = proc_icon .. proc },
            reset,
            { Text = section_spliter }
        }
    end

    -- 最后添加日期和时间显示
    local month_txt = month_frames[now.month]
    local day_txt = days:to_string(now.day)
    right_prompt = right_prompt .. wezterm.format {
        { Foreground = { Color = palatte.ansi.cyan } },
        { Attribute = { Intensity = "Bold" } },
        { Text = "󰸘 " .. month_txt .. " " .. day_txt },
        reset,
        { Text = section_spliter },
    }

    -- lua 诡异的下标从 1 开始
    local hour_icon = hour_frames[now.hour % 12 + 1]
    right_prompt = right_prompt .. wezterm.format {
        { Foreground = { Color = palatte.lavender } },
        { Attribute = { Intensity = "Bold" } },
        { Text = hour_icon .. string.format("%02d:%02d", now.hour, now.min) },
        reset
    }
    window:set_right_status(right_prompt)
end

return {
    apply = function()
        wezterm.on("update-right-status", make_right_status)
    end
}
