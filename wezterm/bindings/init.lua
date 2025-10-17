local mod_key_binding = require("bindings.key_binding")
local mod_mouse_binding = require("bindings.mouse_binding")

return {
    apply_key_bindings_to = mod_key_binding.apply,
    apply_mouse_bindings_to = mod_mouse_binding.apply,

    apply_all_to = function(config)
        mod_key_binding.apply_to(config)
        mod_mouse_binding.apply_to(config)
    end
}
