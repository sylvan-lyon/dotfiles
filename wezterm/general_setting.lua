local M = {}

M.apply_to = function(config)
    -- 默认按键绑定取消
    config.disable_default_key_bindings = true
    config.disable_default_mouse_bindings = true

    -- 取消缩放字体时窗口大小的变化
    config.adjust_window_size_when_changing_font_size = false

    -- 性能设置
    config.front_end = "WebGpu"
    config.max_fps = 165
    config.animation_fps = 165
end

return M
