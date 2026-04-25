---@type snacks.animate.Config
local animate = nil

---@type snacks.bigfile.Config
local bigfile = { enabled = true }

---@type snacks.dashboard.Config
local dashboard = {
    enabled = true,
    preset = {
        --                 header = [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⡿⢿⣿⣿⡿⣟⣯⣽⡷⣫⣿⣿⣿⣿⣿⣿⣿⢿⣿⣶⣯⣽⣻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣟⣲⣤⣬⡝⠝⠿⠿⠿⠿⣫⣾⣿⣿⣿⣿⣿⣿⢟⣵⡿⢿⣻⣭⣿⣿⣿⣾⣟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⡿⠋⠁⢂⣮⣟⣻⡿⣽⣿⣿⣿⣿⣿⣿⡿⣳⢟⣽⣾⣿⣿⡿⣫⣿⣿⡿⣿⣷⣽⣿⣿⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⠟⠀⠀⢶⡸⣎⢿⡿⣽⣿⣿⣿⣿⣿⣿⣿⢛⣿⣿⣿⠿⢿⣯⣾⣿⠟⣋⣸⣿⣿⣿⣮⣿⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⠏⠀⠀⢠⢼⣇⢻⣦⢱⣿⣿⣿⣿⣿⣿⣿⠓⠋⠉⣡⣴⡞⢿⣻⣽⣾⣿⣿⣷⢿⡿⣿⣷⢳⢿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⣾⣿⡟⠀⠀⠀⠈⣼⣿⣆⠻⣿⣿⣿⣿⣿⣿⣿⣟⣬⣭⣽⣶⣤⣭⣥⣿⣿⣿⣿⣿⣿⣯⣷⣻⣿⡾⡿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣷⠿⠿⠃⢀⣀⣀⣀⣋⣻⣿⠧⣿⢓⣿⣿⣿⣿⣿⢿⣿⣿⢿⡿⣯⣽⣿⣿⣿⣿⣿⡿⣟⢩⣌⣏⣿⡇⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣽⣷⣒⡚⠛⠛⠛⠛⠋⠉⠉⠉⠉⠙⠻⣇⡿⢸⣿⣿⣿⣟⡙⠈⡉⠁⠉⠈⣐⠺⣿⣿⣿⣿⣿⣿⣟⣿⣞⡝⢻⢳⣿⣾⣿⣿⣿⣿
        -- ⣿⣿⣿⣾⣽⣛⡶⣤⣰⡄⠀⠀⠀⠀⠀⢠⣶⣯⠃⢸⣿⣿⣿⣿⠛⢢⣯⡠⢄⣠⣿⣷⣿⣿⣿⣿⣿⣏⠉⠀⡐⢰⠌⣾⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⣷⣯⣟⢦⡀⠀⠀⠀⣀⣙⡿⡦⠈⣿⣿⣿⠋⠸⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡧⠢⣀⡿⡨⣬⣿⡿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⡿⣿⣿⣿⣿⣞⣿⡌⠑⠲⢾⠋⠉⠻⣿⡃⡘⣿⣿⠐⣾⡛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢯⣿⣿⣿⣇⣿⣿⣷⣽⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣞⣿⡄⢰⣄⡀⠀⠀⠀⢷⣿⣮⣫⣰⣿⣷⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠝⣾⡟⢮⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣮⢿⡄⠉⠉⠁⠀⡀⡀⠙⠛⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣭⣽⣿⣿⣿⢟⡅⡼⢋⣨⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⢦⣿⣿⣿⣿⣿⣿⣿⣷⡿⣦⠀⠀⠀⢀⢀⠐⠁⠁⠐⡀⠀⠈⡀⠀⢀⠈⠉⠻⠿⠿⢿⣿⣿⣿⢯⣦⣿⣶⣿⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣮⡳⣄⠀⠐⡀⢀⠐⠐⢀⢀⡀⡀⠐⢀⢀⢀⠐⡀⡀⠀⠀⠈⠙⠁⠈⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⡳⣄⠁⠐⢀⠁⢀⠁⠀⡀⡀⡀⢀⡀⢀⢀⠐⡀⡀⠀⡀⢀⠀⡀⠀⠙⠛⢿⣿⣿⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⢹⡘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣷⢦⡐⠐⠐⢀⠁⠐⢀⡀⢀⢀⡀⢀⠁⠀⠀⠐⡀⠁⠁⡀⠀⠐⢀⢀⠈⠻⣿⣿⣿
        -- ⣿⣿⣿⣿⣿⡀⣱⡘⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⡦⣀⠀⡀⡀⡀⡀⡀⢀⡀⠐⠐⠀⠀⢀⠁⠁⠐⡀⡀⠐⠐⡀⡀⠀⠈⠻⣿
        -- ⣿⣿⣿⣿⣿⡧⣝⣓⡦⡶⢶⣶⣒⣒⣛⣻⠿⢽⣻⢿⣿⣿⣿⣮⣲⣄⠐⢀⠁⠐⠐⠐⢀⠁⡀⢀⢀⡀⡀⢀⡀⠀⠀⠐⡀⠀⠀⠀⠀⢻
        -- ⣿⣿⣿⣿⣿⣿⣷⢏⣴⢾⣻⣭⣭⣭⣽⣟⡿⣦⣌⠙⢮⣿⢿⣿⣿⣿⡲⣄⠀⠐⠐⠐⠀⠐⠁⡀⠁⢀⢀⠀⠀⡀⢀⡀⠀⠀⠀⠀⢀⣿
        -- ⣿⣿⣿⣿⣿⣿⣿⠫⣗⣯⣷⣶⣶⣶⣯⣽⡻⣷⣿⣷⣦⡉⢷⣝⣿⣿⣿⣮⣦⡀⠀⢀⠀⠀⠀⠀⠁⠀⠁⡀⡀⠐⡀⠁⠐⠀⠀⢀⣿⣿]]
        header = [[┌──────────────────────────────┐
│                              │
│                              │
│                              │
│     ███████      ███████     │
│     ███████      ███████     │
│     ███████      ███████     │
│            ██████            │
│         ▄▄▄██████▄▄▄         │
│         ████████████         │
│         ████████████         │
│         ███▀▀▀▀▀▀███         │
│         ███      ███         │
│                              │
│                              │
│                              │
└──────────────────────────────┘]]
    },
    sections = {
        { section = "header" },
        {
            pane = 2,
            -- { title = "ヾ(≧▽≦*)o  Now coding!", padding = 1 },
            { title = "ᓚᘏᗢ Now coding!", padding = 1 },
            -- { section = "keys", gap = 1, padding = 1 },
            {
                gap = 1,
                padding = 1,
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
            { section = "startup" },
        },
    },
    formats = {},
}

---@type snacks.explorer.Config
local explorer = {
    enabled = false
}

---@type snacks.gh.Config
local gh = {
    enabled = false
}


---@type snacks.gitbrowse.Config
local git_browse = {}

---@type snacks.image.Config
local image = {
    enabled = true,
    doc = {
        enabled = true,
        inline = false,
        float = true,
        max_width = 60,
        max_height = 20,
    },
    math = {
        enabled = true,
    }
}

---@type snacks.indent.Config
local indent = {
    enabled = true,
    indent = {
        priority = 1,
        enabled = true,
        char = "┊",
        only_scope = false,
        only_current = false,
    },
    scope = {
        enabled = true,
        char = "┆",
        only_current = true,
        hl = {
            "SnacksIndent1",
            "SnacksIndent2",
            "SnacksIndent3",
            "SnacksIndent4",
            "SnacksIndent5",
            "SnacksIndent6",
            "SnacksIndent7",
            "SnacksIndent8",
        },
    },
}

---@type snacks.input.Config
local input = {
    enabled = true
}

---@type snacks.lazygit.Config
local lazigit = {
    enabled = false
}

---@type snacks.notifier.Config
local notifier = {
    enabled = true,
    timeout = 3000,
    level = vim.log.levels.TRACE,
    style = "fancy",
    refresh = 50,
}

---@type snacks.picker.Config
local picker = {
    enabled = true,
    matcher = {
        frecency = true
    },
    ui_select = true,
}

---@type snacks.profiler.Config
local profiler = {
    enabled = false,
}

---@type snacks.quickfile.Config
local quickfile = {
    enabled = true,
}

---@type snacks.scope.Config
local scope = {
    enabled = true,
}

---@type snacks.scratch.Config
local scratch = {
    enabled = false,
}

---@type snacks.scroll.Config
local scroll = {
    enabled = true,
    animate = {},
    animate_repeat = {},
}

---@type snacks.terminal.Config
local terminal = {
    win = {
        position = "float",
        border = "rounded",
    },
    shell = require("utils").is_windows and "nu.exe" or nil,
}

local toggle = {
    enabled = true,
    notify = true,
}

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("snacks").setup({
            animate = animate,
            bigfile = bigfile,
            dashboard = dashboard,
            explorer = explorer,
            gh = gh,
            gitbrowse = git_browse,
            image = image,
            indent = indent,
            input = input,
            lazygit = lazigit,
            notifier = notifier,
            picker = picker,
            profiler = profiler,
            quickfile = quickfile,
            scope = scope,
            scratch = scratch,
            scroll = scroll,
            statuscolumn = { enabled = true },
            terminal = terminal,
            toggle = toggle,
            words = { enabled = true },
        })

        local pick = Snacks.picker

        local toggle_dim = function()
            if Snacks.dim.enabled then
                Snacks.dim.disable()
            else
                Snacks.dim.enable()
            end
        end

        local pick_config_files = function()
            Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end

        local select_layout = { layout = "select" }

        require("utils").keyset({
            -- view
            { "<leader>vi", icon = " ", function() Snacks.image.hover() end, desc = "[v]iew [i]mage", },
            -- toggles                ,
            { "<leader>td", icon = " ", function() toggle_dim() end, desc = "[t]oggle [d]im", },
            { "<leader>tn", icon = " ", function() Snacks.notifier.hide() end, desc = "[t]oggle [n]otices", },
            { "<leader>tt", icon = " ", function() Snacks.terminal.toggle() end, desc = "[t]oggle [t]terminal", },
            { "<leader>tz", icon = " ", function() Snacks.zen.zoom() end, desc = "[t]oggle [z]oom", },

            -- finds
            { "<leader>fa", icon = " ", function() pick.autocmds() end, desc = "[f]ind [a]utocmds", },
            { "<leader>fb", icon = "󱔗 ", function() pick.buffers() end, desc = "[f]ind [b]uffers", },
            { "<leader>fB", icon = "󰈙 ", function() pick.lines() end, desc = "[f]ind [B]uffer lines", },
            { "<leader>fc", icon = " ", function() pick.command_history(select_layout) end, desc = "[f]ind [c]ommand history", },
            { "<leader>fC", icon = " ", function() pick_config_files() end, desc = "[f]ind [C]onfig files", },
            { "<leader>fd", icon = " ", function() pick.diagnostics() end, desc = "[f]ind [d]iagnostics", },
            { "<leader>fD", icon = " ", function() pick.diagnostics_buffer() end, desc = "[f]ind [D]iagnostics(buf)", },
            { "<leader>ff", icon = " ", function() pick.files() end, desc = "[f]ind [f]iles", },
            { "<leader>fg", icon = "󰈞 ", function() pick.grep() end, desc = "[f]ind [g]reps", },
            { "<leader>fh", icon = "󰋖 ", function() pick.help() end, desc = "[f]ind [h]elp", },
            { "<leader>fH", icon = " ", function() pick.highlights() end, desc = "[f]ind [H]ighlights", },
            { "<leader>fi", icon = " ", function() pick.icons(select_layout) end, desc = "[f]ind [i]cons", },
            { "<leader>fj", icon = " ", function() pick.jumps() end, desc = "[f]ind [j]umps", },
            { "<leader>fk", icon = " ", function() pick.keymaps(select_layout) end, desc = "[f]ind [k]eymaps", },
            { "<leader>fl", icon = " ", function() pick.loclist() end, desc = "[f]ind [l]ocation list", },
            { "<leader>fn", icon = " ", function() pick.notifications() end, desc = "[f]ind [n]otifications", },
            { "<leader>fp", icon = " ", function() pick.projects() end, desc = "[f]ind [p]rojects", },
            { "<leader>fq", icon = "󰁨 ", function() pick.qflist() end, desc = "[f]ind [q]uickfix", },
            { "<leader>fr", icon = " ", function() pick.registers() end, desc = "[f]ind [r]egisters", },
            { "<leader>fR", icon = nil, function() pick.resume() end, desc = "[f]ind [R]esume", },
            { "<leader>fs", icon = " ", function() pick.search_history(select_layout) end, desc = "[f]ind [s]earch history", },
            { "<leader>fu", icon = " ", function() pick.undo() end, desc = "[f]ind [u]ndo history", },
        })
    end
}
