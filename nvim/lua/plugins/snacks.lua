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
        { section = 'header' },
        {
            pane = 2,
            { title = 'ヾ(≧▽≦*)o  Now coding!', padding = 1 },
            { section = 'keys', gap = 1, padding = 1 },
            { section = 'startup' },
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
            notifier = notifier,
            picker = picker,
            profiler = profiler,
            quickfile = quickfile,
            scope = scope,
            scratch = scratch,
            scroll = scroll,
            statuscolumn = { enabled = true },
            words = { enabled = true },
        })

        local keymap = require("config.keymaps").set_keymaps

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
            { "<leader>td", function() toggle_dim() end,                                         desc = "[t]oggle [d]im" },
            { "<leader>ti", function() Snacks.image.hover() end,                                 desc = "[t]oggle [i]mage under cursor" },
            { "<leader>tn", function() Snacks.notifier.hide() end,                               desc = "[t]oggle [n]otices" },

            { "<leader>fa", function() Snacks.picker.autocmds() end,                             desc = "[f]ind [a]utocmds" },
            { "<leader>fb", function() Snacks.picker.buffers() end,                              desc = "[f]ind [b]uffers" },
            { "<leader>fB", function() Snacks.picker.lines() end,                                desc = "[f]ind [B]uffer lines" },
            { "<leader>fc", function() pick_config_files() end,                                  desc = "[f]ind [c]onfig files" },
            { "<leader>fC", function() Snacks.picker.command_history({ layout = "select" }) end, desc = "[f]ind [C]ommand history" },
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
