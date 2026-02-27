local sysinfo = vim.uv.os_uname()
local is_windows = sysinfo.sysname == "Windows_NT"
local is_linux = sysinfo.sysname == "Linux"
local is_macos = sysinfo.sysname == "Darwin"
local is_unix_like = is_linux or is_macos

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
}
