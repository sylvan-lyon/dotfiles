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
    scope = {
        enabled = true,
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

        local keymap = require("utils").keyset

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

        keymap({
            -- preview
            { "<leader>pi", function() Snacks.image.hover() end,                                 desc = "[p]review [i]mage under cursor" },

            -- toggles
            { "<leader>td", function() toggle_dim() end,                                         desc = "[t]oggle [d]im" },
            { "<leader>tn", function() Snacks.notifier.hide() end,                               desc = "[t]oggle [n]otices" },
            { "<leader>tt", function() Snacks.terminal.toggle() end,                             desc = "[t]oggle [t]terminal" },
            { "<leader>tz", function() Snacks.zen.zoom() end,                                    desc = "[t]oggle [z]oom" },

            -- finds
            { "<leader>fa", function() Snacks.picker.autocmds() end,                             desc = "[f]ind [a]utocmds" },
            { "<leader>fb", function() Snacks.picker.buffers() end,                              desc = "[f]ind [b]uffers" },
            { "<leader>fB", function() Snacks.picker.lines() end,                                desc = "[f]ind [B]uffer lines" },
            { "<leader>fc", function() Snacks.picker.command_history({ layout = "select" }) end, desc = "[f]ind [c]ommand history" },
            { "<leader>fC", function() pick_config_files() end,                                  desc = "[f]ind [C]onfig files" },
            { "<leader>fd", function() Snacks.picker.diagnostics() end,                          desc = "[f]ind [d]iagnostics" },
            { "<leader>fD", function() Snacks.picker.diagnostics_buffer() end,                   desc = "[f]ind [D]iagnostics(buffer)" },
            { "<leader>ff", function() Snacks.picker.files() end,                                desc = "[f]ind [f]iles" },
            { "<leader>fg", function() Snacks.picker.grep() end,                                 desc = "[f]ind [g]reps" },
            { "<leader>fh", function() Snacks.picker.help() end,                                 desc = "[f]ind [h]elp" },
            { "<leader>fH", function() Snacks.picker.highlights() end,                           desc = "[f]ind [H]ighlights" },
            { "<leader>fi", function() Snacks.picker.icons({ layout = "select" }) end,           desc = "[f]ind [i]cons" },
            { "<leader>fj", function() Snacks.picker.jumps() end,                                desc = "[f]ind [j]umps" },
            { "<leader>fk", function() Snacks.picker.keymaps({ layout = "select" }) end,         desc = "[f]ind [k]eymaps" },
            { "<leader>fl", function() Snacks.picker.loclist() end,                              desc = "[f]ind [l]ocation list" },
            { "<leader>fn", function() Snacks.picker.notifications() end,                        desc = "[f]ind [n]otifications" },
            { "<leader>fp", function() Snacks.picker.lazy() end,                                 desc = "[f]ind [p]lugin spec" },
            { "<leader>fq", function() Snacks.picker.qflist() end,                               desc = "[f]ind [q]uickfix" },
            { "<leader>fr", function() Snacks.picker.registers() end,                            desc = "[f]ind [r]egisters" },
            { "<leader>fR", function() Snacks.picker.resume() end,                               desc = "[f]ind [R]esume" },
            { "<leader>fs", function() Snacks.picker.search_history({ layout = "select" }) end,  desc = "[f]ind [s]earch history" },
            { "<leader>fu", function() Snacks.picker.undo() end,                                 desc = "[f]ind [u]ndo history" },

            -- NOTE: LSP stuff
            { "gd",         function() Snacks.picker.lsp_definitions() end,                      desc = "[g]oto definitions" },
            { "gD",         function() Snacks.picker.lsp_declarations() end,                     desc = "[g]oto declarations" },
            { "gt",         function() Snacks.picker.lsp_type_definitions() end,                 desc = "[g]oto [t]ype definitions" },
            { "gri",        function() Snacks.picker.lsp_implementations() end,                  desc = "[g]oto [i]mplementations" },
            { "grr",        function() Snacks.picker.lsp_references() end,                       desc = "[g]oto [r]eferences" },
            { "gai",        function() Snacks.picker.lsp_incoming_calls() end,                   desc = "[g]oto c[a]ll [i]ncoming" },
            { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,                   desc = "[g]oto c[a]ll [o]utgoing" },
            { "gO",         function() Snacks.picker.lsp_symbols() end,                          desc = "[g]oto d[O]cument symbols" },
            { "gS",         function() Snacks.picker.lsp_workspace_symbols() end,                desc = "[g]oto work[S]pace symbols" },

        })
    end
}
