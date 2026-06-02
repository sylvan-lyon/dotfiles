return {
    {
        "nvim-mini/mini.move",
        event = { "ModeChanged *:[vV\x16]" },
        config = function()
            require("plugins.config.mini")
        end
    },
}
