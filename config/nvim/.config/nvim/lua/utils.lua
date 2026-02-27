local sysinfo = vim.uv.os_uname()
local is_windows = sysinfo.sysname == "Windows_NT"
local is_linux = sysinfo.sysname == "Linux"
local is_macos = sysinfo.sysname == "Darwin"
local is_unix_like = is_linux or is_macos

---@class Keymap
---@field [1] string
---@field [2] string|function
---@field mode? string|string[]
---@field desc? string
---@field noremap? boolean
---
--- Creates buffer-local mapping, `0` or `true` for current buffer.
---@field buffer? integer|boolean
---
--- Make the mapping recursive. Inverse of {noremap}.
--- (Default: `false`)
---@field remap? boolean
---@field nowait? boolean
---@field silent? boolean
---@field script? boolean
---@field expr? boolean
---@field unique? boolean
---@field callback? function
---@field replace_keycodes? boolean

---Set a key map, uses `vim.keymap.set` function under the hood.
---@param keymaps Keymap[]
local function set_keymaps(keymaps)
    for _, keymap in ipairs(keymaps) do
        vim.keymap.set(keymap.mode or "n", keymap[1], keymap[2], {
            desc = keymap.desc,
            noremap = keymap.noremap,
            buffer = keymap.buffer,
            remap = keymap.remap,
            nowait = keymap.nowait,
            silent = keymap.silent,
            script = keymap.script,
            expr = keymap.expr,
            unique = keymap.unique,
            callback = keymap.callback,
            replace_keycodes = keymap.replace_keycodes,
        })
    end
end
return {
    ---@type boolean
    is_windows = is_windows,
    ---@type boolean
    is_linux = is_linux,
    ---@type boolean
    is_macos = is_macos,
    ---@type boolean
    is_unix_like = is_unix_like,
    ---@type string
    sysname = sysinfo.sysname,
    set_keymaps = set_keymaps,
}
