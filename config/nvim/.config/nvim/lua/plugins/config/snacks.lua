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
}
