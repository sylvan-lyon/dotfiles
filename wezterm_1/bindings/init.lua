local key_binding = require("bindings.key_binding")
local mouse_binding = require("bindings.mouse_binding")

return {
    apply_key_bindings_to = key_binding.apply,
    apply_mouse_bindings_to = mouse_binding.apply,

    apply_all_to = function(config)
        key_binding.apply_to(config)
        mouse_binding.apply_to(config)
    end
}
