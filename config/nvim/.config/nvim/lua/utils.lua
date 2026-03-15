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


---@param str string
---@return table
local function shell_split(str)
    local args = {}
    local current = ""
    local quote = nil

    for i = 1, #str do
        local c = str:sub(i, i)

        if quote then
            if c == quote then
                quote = nil
            else
                current = current .. c
            end
        else
            if c == '"' or c == "'" then
                quote = c
            elseif c == " " then
                if current ~= "" then
                    table.insert(args, current)
                    current = ""
                end
            else
                current = current .. c
            end
        end
    end

    if current ~= "" then
        table.insert(args, current)
    end

    return args
end

---Set a key map, uses `vim.keymap.set` function under the hood.
---@param keymaps Keymap[]
local keyset_inner = function(keymaps)
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

---Set a key map, uses `vim.keymap.set` function under the hood.
---@param keymaps Keymap[]|wk.Mapping[]
local keyset = function(keymaps)
    local ok, which_key = pcall(require, "which-key")
    if ok and which_key and which_key.add then
        which_key.add(keymaps)
    else
        keyset_inner(keymaps)
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
    keyset = keyset,
    shell_split = shell_split,
}
