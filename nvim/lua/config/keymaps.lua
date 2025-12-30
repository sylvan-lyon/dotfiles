vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

set_keymaps({
    { "K",          ":m '<-2<CR>gv=gv", mode = "v",               desc = "[custom] move up selected text" },
    { "J",          ":m '>+1<CR>gv=gv", mode = "v",               desc = "[custom] move down selected text" },
    { "<C-h>",      "<C-w>h",           mode = "n",               desc = "[custom] focus on the left split" },
    { "<C-j>",      "<C-w>j",           mode = "n",               desc = "[custom] focus on the down split" },
    { "<C-k>",      "<C-w>k",           mode = "n",               desc = "[custom] focus on the upper split" },
    { "<C-l>",      "<C-w>l",           mode = "n",               desc = "[custom] focus on the right split" },
    { "<",          "<gv",              mode = "v",               desc = "[custom] indent and keep visual" },
    { ">",          ">gv",              mode = "v",               desc = "[custom] dedent and keep visual" },
    { "<leader>l",  "<CMD>Lazy<CR>",    mode = "n",               desc = "[custom] open up [l]azy" }
})

return {
    set_keymaps = set_keymaps
}
