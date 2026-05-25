local palette = require("catppuccin.palettes").get_palette()
local utils = require("heirline.utils")
local conditions = require("heirline.conditions")

local schedule_redraw = function()
    vim.schedule(function()
        vim.cmd("redrawstatus")
    end)
end

local colors = {
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("diffDeleted").fg,
    git_add = utils.get_highlight("diffAdded").fg,
    git_change = utils.get_highlight("diffChanged").fg,

    background = palette.base,

    white = palette.text,
    dimmed_white = palette.overlay2,

    blue = palette.blue,
    dimmed_blue = palette.sky,

    purple = palette.mauve,
    pink = palette.pink,

    red = palette.red,
    dimmed_red = palette.maroon,

    yellow = palette.yellow,
    dimmed_yellow = palette.yellow,

    green = palette.green,
    dimmed_green = palette.teal,

    orange = palette.peach,
}

local function overseer_task_for_status(st)
    return {
        condition = function(self)
            return self.tasks[st]
        end,
        provider = function(self)
            return string.format("%s%d", self.symbols[st], #self.tasks[st])
        end,
        hl = function(_)
            return { fg = utils.get_highlight(string.format("Overseer%s", st)).fg }
        end,
    }
end

local M = {}

M.spacer = { update = false, provider = " " }

M.fill = { upadte = false, provider = "%=" }

-- padding spaces on left, main part will be on right
---@param child StatusLine
---@param num integer|fun(): integer
---@param char string|nil
---@return table
M.left_pad = function(child, num, char)
    local result = { condition = child.condition }

    char = char or " "

    if type(num) == "number" then
        num = num
    elseif type(num) == "function" then
        num = num()
    else
        num = 0
    end

    local pad = string.rep(char, num / vim.fn.strdisplaywidth(char))
    pad = pad .. string.rep(" ", num % vim.fn.strdisplaywidth(char))

    table.insert(result, { provider = pad })
    table.insert(result, child)

    return result
end

--- padding spaces on right, main part will be on left
---@param child StatusLine
---@param num integer|fun(): integer
---@param char string|nil
---@return table
M.right_pad = function(child, num, char)
    local result = { condition = child.condition }

    char = char or " "

    if type(num) == "number" then
        num = num
    elseif type(num) == "function" then
        num = num()
    else
        num = 0
    end

    local pad = string.rep(char, num / vim.fn.strdisplaywidth(char))
    pad = pad .. string.rep(" ", num % vim.fn.strdisplaywidth(char))

    table.insert(result, child)
    table.insert(result, { provider = pad })

    return result
end

M.lazy_update = {
    condition = function()
        return require("lazy.status").has_updates()
    end,
    provider = function()
        return require("lazy.status").updates()
    end,
    hl = function()
        return { fg = colors.pink }
    end
}

M.ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    -- provider = "%4l,%-3c %P",
    provider = "%4l, %-3c",
}

local sbar = { " ", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
M.scroll_bar = {
    provider = function()
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((lines - curr_line) / lines * #sbar) + 1
        return string.rep(sbar[i], 2)
    end,
    hl = { fg = colors.dimmed_white, bg = colors.yellow },
}

M.mode = {
    static = {
        mode_names = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "V-LINE",
            ["\22"] = "V-BLOCK",
            c = "COMMAND",
            s = "SELECT",
            S = "S-LINE",
            ["\19"] = "S-BLOCK",
            R = "REPLACE",
            r = "PROMPT",
            ["!"] = "SHELL",
            t = "TERMINAL",
        },
        mode_colors = {
            n = colors.green,
            i = colors.blue,
            v = colors.purple,
            V = colors.purple,
            ["\22"] = colors.purple,
            c = colors.red,
            s = colors.pink,
            S = colors.pink,
            ["\19"] = colors.pink,
            R = colors.dimmed_yellow,
            r = colors.dimmed_yellow,
            ["!"] = colors.red,
            t = colors.blue,
        },
    },
    init = function(self)
        self.mode_cache = vim.fn.mode()
    end,
    provider = function(self)
        return "┃ " .. self.mode_names[self.mode_cache] .. " ┃"
    end,
    hl = function(self)
        local mode = self.mode_cache:sub(1, 1) -- get only the first mode character
        if conditions.is_active() then
            return { fg = colors.background, bg = self.mode_colors[mode], bold = true }
        else
            return { fg = self.mode_colors[mode], bold = true }
        end
    end,
    update = {
        "ModeChanged",
        callback = schedule_redraw,
    },
}

M.macro_recording = {
    condition = conditions.is_active,
    init = function(self)
        self.reg_recording = vim.fn.reg_recording()
        self.status_dict = vim.b.gitsigns_status_dict or { added = 0, removed = 0, changed = 0 }
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    {
        condition = function(self)
            return self.reg_recording ~= ""
        end,
        {
            provider = "󰻃 ",
            hl = { fg = colors.dimmed_red },
        },
        {
            provider = function(self)
                return self.reg_recording
            end,
            hl = { fg = colors.dimmed_red, italic = false, bold = true },
        },
        hl = { fg = colors.white },
    },
    update = { "RecordingEnter", "RecordingLeave" },
}

M.formatters = {
    condition = function(self)
        local ok, conform = pcall(require, "conform")
        self.conform = conform
        return ok
    end,
    update = { "BufEnter" },
    provider = function(self)
        local ft_entry = self.conform.formatters_by_ft[vim.bo.filetype]
        local ft_formatters
        if type(ft_entry) == "function" then
            ft_formatters = ft_entry()
        else
            ft_formatters = ft_entry
        end
        return ft_formatters and table.concat(ft_formatters, ",") or ""
    end,
    hl = { fg = colors.dimmed_white, bold = false },
}

M.git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = function()
        return { fg = colors.dimmed_red }
    end,

    {
        provider = function(self)
            if self.has_changes then
                return " " .. self.status_dict.head .. "*"
            else
                return " " .. self.status_dict.head
            end
        end,
    },
}

M.diagnostics = {
    condition = conditions.has_diagnostics,

    static = {
        error_icon = " ",
        warn_icon = " ",
        info_icon = " ",
        hint_icon = "󰌶 ",
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = {
        "DiagnosticChanged",
        callback = function(self)
            self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            schedule_redraw()
        end
    },

    {
        provider = function(self)
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = colors.diag_error },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = colors.diag_warn },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = colors.diag_info },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = colors.diag_hint },
    },
}

M.buffer_type = {
    provider = function()
        return vim.bo.buftype
    end
}


---@enum BufTypeKind
local BufTypeKind = {
    normal = 0,
    acwrite = 1,
    nofile = 2,
    nowrite = 3,
    help = 4,
    quickfix = 5,
    prompt = 6,
    terminal = 7
}

---@class FileBlock
---@field bufnr integer
---@field buftype string
---@field file_path string
---@field icon string
---@field icon_color string
---@field kind BufTypeKind
---@field modified boolean


M.file_type = {
    provider = function()
        return vim.bo.filetype
    end,
    hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

M.file_encoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        return enc ~= 'utf-8' and enc:upper()
    end
}

M.file_format = {
    provider = function()
        local fmt = vim.bo.fileformat
        if fmt == "unix" then
            return ""
        elseif fmt == "dos" then
            return " "
        elseif fmt == "mac" then
            return " "
        end
    end,
    hl = function()
        local fmt = vim.bo.fileformat
        if fmt ~= "unix" then
            return { fg = colors.blue }
        end
    end
}

local file_icon = {
    ---@param self FileBlock
    init = function(self)
        if self.kind == BufTypeKind.normal or self.kind == BufTypeKind.help then
            local file_name = self.file_path
            local extension = vim.fn.fnamemodify(file_name, ":e")
            self.icon, self.icon_color = require("nvim-web-devicons")
                .get_icon_color(file_name, extension, { default = true, strict = true })
        end
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end,
}

local file_path = {
    ---@param self FileBlock
    ---@return string
    provider = function(self)
        return self.file_path
    end,
    hl = {
        fg = colors.white,
        bold = false,
        italic = false,
    }
}

local file_modified = {
    condition = function()
        return vim.bo.modified
    end,
    provider = "● ",
    hl = { fg = colors.green },
    upadte = false,
}

local file_read_only = {
    ---@param self FileBlock
    ---@return boolean
    condition = function(self)
        if self.kind == BufTypeKind.normal or self.kind == BufTypeKind.help then
            return not vim.bo.modifiable or vim.bo.readonly
        else
            return false
        end
    end,
    provider = " ",
    hl = { fg = colors.orange },
}

M.file_name_block = {
    {
        ---@param self FileBlock
        init = function(self)
            self.bufnr = vim.api.nvim_get_current_buf()
            self.buftype = vim.bo.buftype
            if self.buftype == "" then
                self.kind = BufTypeKind.normal
            elseif self.buftype == "acwrite" then
                self.kind = BufTypeKind.acwrite
            elseif self.buftype == "nofile" then
                self.kind = BufTypeKind.nofile
            elseif self.buftype == "nowrite" then
                self.kind = BufTypeKind.nowrite
            elseif self.buftype == "help" then
                self.kind = BufTypeKind.help
            elseif self.buftype == "quickfix" then
                self.kind = BufTypeKind.quickfix
            elseif self.buftype == "prompt" then
                self.kind = BufTypeKind.prompt
            elseif self.buftype == "terminal" then
                self.kind = BufTypeKind.terminal
            end

            if self.kind == BufTypeKind.normal or self.kind == BufTypeKind.help then
                local raw = vim.api.nvim_buf_get_name(0)
                local new_file_path = vim.fn.fnamemodify(raw, ":t")
                if new_file_path == "" then
                    new_file_path = "[NO NAME]"
                else
                    new_file_path = require("utils").is_windows and new_file_path:gsub("\\", "/") or new_file_path
                end
                self.file_path = new_file_path
            end
        end,
        file_icon,
        file_path,
        M.spacer,
        file_read_only,
        update = "BufEnter",
    },
    file_modified,
}

M.file_path_block = {
    {
        ---@param self FileBlock
        init = function(self)
            self.bufnr = vim.api.nvim_get_current_buf()
            self.buftype = vim.bo.buftype
            if self.buftype == "" then
                self.kind = BufTypeKind.normal
            elseif self.buftype == "acwrite" then
                self.kind = BufTypeKind.acwrite
            elseif self.buftype == "nofile" then
                self.kind = BufTypeKind.nofile
            elseif self.buftype == "nowrite" then
                self.kind = BufTypeKind.nowrite
            elseif self.buftype == "help" then
                self.kind = BufTypeKind.help
            elseif self.buftype == "quickfix" then
                self.kind = BufTypeKind.quickfix
            elseif self.buftype == "prompt" then
                self.kind = BufTypeKind.prompt
            elseif self.buftype == "terminal" then
                self.kind = BufTypeKind.terminal
            end

            if self.kind == BufTypeKind.normal or self.kind == BufTypeKind.help then
                local raw = vim.api.nvim_buf_get_name(self.bufnr)
                local new_file_name
                if self.kind == BufTypeKind.normal then
                    new_file_name = vim.fn.fnamemodify(raw, ":~:.")
                else
                    new_file_name = vim.fn.fnamemodify(raw, ":t")
                end
                if new_file_name == "" then
                    new_file_name = "[NO NAME]"
                else
                    new_file_name = require("utils").is_windows and new_file_name:gsub("\\", "/") or new_file_name
                end
                self.file_path = new_file_name
            end
        end,
        file_icon,
        file_path,
        M.spacer,
        file_read_only,
        update = "BufEnter",
    },
    file_modified,
}

M.tabline_file_name_block = vim.tbl_extend("force", M.file_name_block, {
    on_click = {
        callback = function(_, minwid, _, button)
            if button == "m" then -- close on mouse middle click
                vim.schedule(function()
                    vim.api.nvim_buf_delete(minwid, { force = false })
                end)
            else
                vim.api.nvim_win_set_buf(0, minwid)
            end
        end,
        minwid = function(self)
            return self.bufnr
        end,
        name = "heirline_tabline_buffer_callback",
    },
})

M.overseer = {
    condition = function()
        return package.loaded.overseer
    end,
    init = function(self)
        local tasks = require("overseer.task_list").list_tasks { unique = true }
        local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
        self.tasks = tasks_by_status
    end,
    static = {
        symbols = {
            ["CANCELED"] = " 󰩹 ",
            ["FAILURE"] = "  ",
            ["SUCCESS"] = "  ",
            ["RUNNING"] = "  ",
        },
    },
    M.right_pad(overseer_task_for_status "CANCELED", 1),
    M.right_pad(overseer_task_for_status "RUNNING", 2),
    M.right_pad(overseer_task_for_status "SUCCESS", 3),
    M.right_pad(overseer_task_for_status "FAILURE", 4),
}

vim.opt.showcmdloc = "statusline"
M.show_cmd = {
    condition = function()
        return vim.o.cmdheight == 0
    end,
    provider = "%3.5(%S%)",
}

M.search_occurrence = {
    condition = function()
        return vim.v.hlsearch == 1
    end,
    hl = { fg = colors.dimmed_blue },
    provider = function()
        local ok, sinfo = pcall(vim.fn.searchcount)
        if ok and sinfo.total then
            local search_stat = sinfo.incomplete > 0 and " [?/?]" or
                sinfo.total > 0 and (" [%s/%s]"):format(sinfo.current, sinfo.total) or ""
            return search_stat
        else
            return ""
        end
    end,
}

M.dap_buffers = {
    provider = function()
        local ft = vim.bo.filetype
        if ft == "dapui_scopes" then
            return "scopes"
        elseif ft == "dapui_breakpoints" then
            return "breakpoints"
        elseif ft == "dapui_stacks" then
            return "stacks"
        elseif ft == "dapui_watches" then
            return "watches"
        elseif ft == "dapui_console" then
            return "console"
        elseif ft == "dap-repl" then
            return "repl"
        else
            return ft
        end
    end,
    hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

local _updated_at = 0
local _augroup = vim.api.nvim_create_augroup("alias for lsp status events", { clear = true })

vim.api.nvim_create_autocmd(
    { "LspAttach", "LspDetach", "LspProgress" },
    {
        desc = [[alias for event { "LspAttach", "LspDetach", "LspProgress" }]],
        group = _augroup,

        ---@param event { data: { client_id: integer, params: lsp.ProgressParams|nil } }
        callback = function(event)
            -- update interval: 40ms
            if _updated_at < vim.uv.hrtime() - 1e6 * 40
                -- If it's LspProgress who triggered this autocmd,
                -- and progress kind is end,
                -- then we force update to announce the end of progress.
                or event.data.params and event.data.params.value.kind == "end" then
                vim.schedule(function()
                    vim.api.nvim_exec_autocmds("User", { pattern = "LspUpdate", data = event.data })
                end)
                _updated_at = vim.uv.hrtime()
            end
        end
    }
)

vim.api.nvim_create_autocmd(
    "BufEnter",
    {
        group = _augroup,
        callback = function(event)
            vim.schedule(function()
                vim.api.nvim_exec_autocmds("User", { pattern = "LspUpdate", data = event.data })
            end)
        end
    }
)

---@class LspHeirline
---@field status table<integer, {status: string, progress_string: string, name: string}[]>
---@field timer uv.uv_timer_t
---@field timer_started boolean
---@field bufnr integer
---@field keep_drawing fun()
---@field stop_drawing fun()
---@field spinner string[]

---@param mod LspHeirline
local function keep_lsp_mod_redrawing(mod)
    if mod.timer and not mod.timer_started then
        mod.timer:start(0, 40, schedule_redraw)
        mod.timer_started = true
    else
        schedule_redraw()
    end
end

---@param mod LspHeirline
local function stop_lsp_mod_redrawing(mod)
    if mod.timer and mod.timer:is_active() then
        mod.timer:stop()
        mod.timer_started = false
    end
end

---@param spinner string[]
---@return string
local function get_spinner(spinner)
    local second = vim.uv.hrtime() / 1e9
    local fps = 10

    return spinner[math.floor(fps * second) % #spinner + 1]
end

M.lsp = {
    ---@param self LspHeirline
    ---@return boolean
    condition = function(self)
        self.status = self.status or {}
        self.timer = self.timer or vim.uv.new_timer()
        self.keep_drawing = self.keep_drawing or function()
            keep_lsp_mod_redrawing(self)
        end
        self.stop_drawing = self.stop_drawing or function()
            stop_lsp_mod_redrawing(self)
        end

        return conditions.lsp_attached()
    end,
    hl = { fg = colors.dimmed_white, bold = true },
    ---@param self LspHeirline
    ---@return string
    provider = function(self)
        local status = ""
        for _, item in pairs(self.status[self.bufnr] or {}) do
            local icon = ""
            if item.status == "end" then
                icon = " "
            else
                icon = " " .. get_spinner(self.spinner)
            end

            status = status .. string.format("%s %s %s ", item.name, item.progress_string, icon)
        end

        return status
    end,
    static = {
        spinner = {
            " ", -- new
            " ", " ", " ", " ", " ", " ", -- waxing crescent
            " ", -- first quarter
            " ", " ", " ", " ", " ", " ", -- waxing gibbous
            " ", -- full
            " ", " ", " ", " ", " ", " ", -- waning gibbous
            " ", -- last quarter
            " ", " ", " ", " ", " ", " ", -- waning crescent
        },
    },
    update = {
        "User",
        pattern = "LspUpdate",
        ---@param self LspHeirline
        ---@param args { buf: integer, data: { client_id: integer, params: lsp.ProgressParams? }? }
        callback = function(self, args)
            self.bufnr = args.buf
            if not args.data then
                schedule_redraw()
                return
            end

            local client_id, params = args.data.client_id, args.data.params
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            self.status[self.bufnr] = self.status[self.bufnr] or {}
            if client then
                local progress_string = ""
                if params then
                    if params.value.kind == "begin" then
                        progress_string = ""
                        self.keep_drawing()
                    elseif params.value.kind == "report" then
                        ---@type nil|{ token: integer, value: nil|{ kind: string?, message: string?, percentage: integer?, title: string? } }
                        local prog = client.progress:pop()
                        client.progress:clear()
                        if prog and prog.value then
                            -- %%%% >-- stirng.format --> %% >-- status of neovim --> %
                            local percent = prog.value.percentage and ("(%2d%%%%)"):format(prog.value.percentage) or ""
                            progress_string = ("%s %s"):format(percent, prog.value.title or "")
                        else
                            progress_string = ""
                        end
                        self.keep_drawing()
                    elseif params.value.kind == "end" then
                        self.stop_drawing()
                        progress_string = "done"
                        schedule_redraw()
                    end
                end
                self.status[self.bufnr][client_id] = {
                    status = params and params.value.kind or "end",
                    name = client.name,
                    progress_string = progress_string
                }
            else
                self.status[self.bufnr][client_id] = nil
            end
        end,
    }
}

M.treesitter = {
    condition = function()
        local bufnr = vim.api.nvim_get_current_buf()
        return vim.treesitter.highlighter.active[bufnr] ~= nil
    end,
    provider = " ",
    hl = { fg = colors.green }
}

return M
