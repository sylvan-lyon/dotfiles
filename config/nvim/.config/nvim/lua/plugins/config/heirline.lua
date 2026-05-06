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

M.spacer = { provider = " " }

M.fill = { provider = "%=" }

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

M.file_icon = {
    init = function(self)
        local file_name = self.file_name
        local extension = vim.fn.fnamemodify(file_name, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(file_name, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end,
}

M.file_name = {
    provider = function(self)
        local file_name = vim.fn.fnamemodify(self.file_name, ":p:t")
        if file_name == "" then return "[NO NAME]" end
        if not conditions.width_percent_below(#file_name, 0.25) then
            file_name = vim.fn.pathshorten(file_name)
        end
        return file_name:gsub("\\", "/")
    end,
    hl = function()
        return { fg = utils.get_highlight("Directory").fg }
    end,
}

M.file_path = {
    provider = function(self)
        local file_name = vim.fn.fnamemodify(self.file_name, ":~:.")
        if file_name == "" then
            return vim.bo.filetype ~= "" and vim.bo.filetype or vim.bo.buftype
        end
        if not conditions.width_percent_below(#file_name, 0.25) then
            file_name = vim.fn.pathshorten(file_name, 4)
        end
        return file_name:gsub("\\", "/")
    end,
    hl = function(self)
        return {
            fg = self.is_active and colors.white or palette.subtext0,
            bold = self.is_active or self.is_visible,
            italic = self.is_active,
        }
    end,
}

M.file_flags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "● ",
        hl = { fg = colors.green },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = " ",
        hl = { fg = colors.orange },
    },
}

M.file_name_block = {
    init = function(self)
        local bufnr = self.bufnr and self.bufnr or 0
        self.file_name = vim.api.nvim_buf_get_name(bufnr)
    end,
    hl = { fg = colors.white },
    M.file_icon,
    M.file_name,
    M.spacer,
    M.file_flags,
}

M.file_path_block = {
    init = function(self)
        local bufnr = self.bufnr and self.bufnr or 0
        self.file_name = vim.api.nvim_buf_get_name(bufnr)
    end,
    hl = { fg = colors.white },
    M.file_icon,
    M.file_path,
    M.spacer,
    M.file_flags,
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

--#region
local lsp = {
    ---@type table<integer, { name: string, status: string }>
    status = {},
    progress_string = "",
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
    -- spinner = { " ", " ", " ", " ", " ", " " },
    -- This timer keeps redrawing every 40 ms
    timer = vim.uv.new_timer(),
    timer_started = false
}

function lsp:get_spinner()
    local second = vim.uv.hrtime() / 1e9
    local fps = 10

    return lsp.spinner[math.floor(fps * second) % #lsp.spinner + 1]
end

-- If possible ( the timer is not poisoned ),
--     start timer and keeps emit redraw event
-- else, triggers redraw once.
function lsp:keep_drawing_if_possible()
    if self.timer and not self.timer_started then
        self.timer:start(0, 40, schedule_redraw)
        self.timer_started = true
    else
        schedule_redraw()
    end
end

function lsp:stop_keeping_drawing()
    if self.timer and self.timer:is_active() then
        self.timer:stop()
        self.timer_started = false
    end
end

---The lsp progress function
---@param progress_value { kind: string?, message: string?, percentage: integer?, title: string? }
function lsp:format_lsp_progress(progress_value)
    local percent = progress_value.percentage and
        -- %%%% >-- stirng.format --> %% >-- status of neovim --> %
        ("(%2d%%%%)"):format(progress_value.percentage) or ""
    self.progress_string = ("%s %s"):format(percent, progress_value.title or "")
end

vim.api.nvim_create_autocmd(
    "User",
    {
        desc = [[update lsp status]],
        group = vim.api.nvim_create_augroup("update lsp status of heirline", { clear = true }),
        pattern = { "LspUpdate" },

        ---@param event { data: { client_id: integer, params: lsp.ProgressParams|nil } }
        callback = function(event)
            local client_id, params = event.data.client_id, event.data.params
            local client = vim.lsp.get_client_by_id(event.data.client_id)

            if client then
                lsp.status[client_id] = { status = params and params.value.kind or "end", name = client.name }
                if params then
                    if params.value.kind == "begin" then
                        lsp.progress_string = ""
                        lsp:keep_drawing_if_possible()
                    elseif params.value.kind == "report" then
                        -- get most recent progress and cleanup the progress ring
                        -- so that each call to client.progress:pop() will get most recent progress
                        -- client.progress is not a stack but a queue
                        ---@type nil|{ token: integer, value: nil|{ kind: string?, message: string?, percentage: integer?, title: string? } }
                        local progress = client.progress:pop()
                        client.progress:clear()
                        if progress and progress.value then
                            lsp:format_lsp_progress(progress.value)
                        end
                        lsp:keep_drawing_if_possible()
                    elseif params.value.kind == "end" then
                        lsp:stop_keeping_drawing()
                        lsp.progress_string = "done"
                        schedule_redraw()
                    end
                end
            else
                lsp.status[client_id] = nil
            end
        end
    }
)
--#endregion

M.lsp_status = {
    condition = conditions.lsp_attached,
    hl = { fg = colors.dimmed_white, bold = true },
    provider = function()
        local status = ""

        for _, data in ipairs(lsp.status) do
            local icon =
                data.status == "end" and "  " or
                " " .. lsp:get_spinner()

            status = data.name .. icon
        end

        return status
    end,
    update = {
        "User",
        pattern = "LspUpdate",
        callback = schedule_redraw,
    }
}

M.lsp_progress = {
    condition = conditions.lsp_attached,
    provider = function()
        return lsp.progress_string
    end,
    update = {
        "User",
        pattern = "LspUpdate",
        callback = schedule_redraw,
    },
    hl = { fg = colors.dimmed_white, bold = false },
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
