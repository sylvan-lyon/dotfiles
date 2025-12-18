return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = false },
        image = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000, -- default timeout in ms
            refresh = 50,
        },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
            notification = {
                -- wo = { wrap = true } -- Wrap notifications
            },
            float = {
                widht = 0.8,
                height = 0.8,
            }
        },
        terminal = {
            enabled = true,
            shell = "nu",
            win = {
                position = "float",
                width = 0.8,
                height = 0.8,
            }
        }
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "[Snacks] Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "[Snacks] Buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "[Snacks] Grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "[Snacks] Command History" },
        { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "[Snacks] Notification History" },
        -- { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
        -- find
        { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "[Snacks find] Buffers" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[Snacks find] Find Config File" },
        { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "[Snacks find] Find Files" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "[Snacks find] Find Git Files" },
        { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "[Snacks find] Projects" },
        { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "[Snacks find] Recent" },
        -- git
        { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "[Snacks git   ] Git Branches" },
        { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "[Snacks git   ] Git Log" },
        { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "[Snacks git   ] Git Log Line" },
        { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "[Snacks git   ] Git Status" },
        { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "[Snacks git   ] Git Stash" },
        { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "[Snacks git   ] Git Diff (Hunks)" },
        { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "[Snacks git   ] Git Log File" },
        -- gh
        { "<leader>gi",      function() Snacks.picker.gh_issue() end,                                desc = "[Snacks github] GitHub Issues (open)" },
        { "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "[Snacks github] GitHub Issues (all)" },
        { "<leader>gp",      function() Snacks.picker.gh_pr() end,                                   desc = "[Snacks github] GitHub Pull Requests (open)" },
        { "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "[Snacks github] GitHub Pull Requests (all)" },
        -- Grep
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "[Snacks grep  ] Buffer Lines" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "[Snacks grep  ] Grep Open Buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "[Snacks grep  ] Grep" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "[Snacks grep  ] Visual selection or word",   mode = { "n", "x" } },
        -- search
        { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "[Snacks search] Registers" },
        { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "[Snacks search] Search History" },
        { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "[Snacks search] Autocmds" },
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "[Snacks search] Buffer Lines" },
        { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "[Snacks search] Command History" },
        { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "[Snacks search] Commands" },
        { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "[Snacks search] Diagnostics" },
        { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "[Snacks search] Buffer Diagnostics" },
        { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "[Snacks search] Help Pages" },
        { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "[Snacks search] Highlights" },
        { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "[Snacks search] Icons" },
        { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "[Snacks search] Jumps" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "[Snacks search] Keymaps" },
        { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "[Snacks search] Location List" },
        { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "[Snacks search] Marks" },
        { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "[Snacks search] Man Pages" },
        { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "[Snacks search] Search for Plugin Spec" },
        { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "[Snacks search] Quickfix List" },
        { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "[Snacks search] Resume" },
        { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "[Snacks search] Undo History" },
        { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "[Snacks search] Colorschemes" },
        -- LSP
        -- { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
        -- { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
        -- { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                       desc = "References" },
        -- { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
        -- { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
        -- { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
        -- { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
        -- { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
        -- { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
        -- Other
        { "<leader>z",       function() Snacks.zen() end,                                            desc = "[Snacks] Toggle Zen Mode" },
        { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "[Snacks] Toggle Zoom" },
        { "<leader>.",       function() Snacks.scratch() end,                                        desc = "[Snacks] Toggle Scratch Buffer" },
        { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "[Snacks] Select Scratch Buffer" },
        { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "[Snacks] Notification History" },
        { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "[Snacks] Delete Buffer" },
        { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "[Snacks] Rename File" },
        { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "[Snacks] Git Browse",                 mode = { "n", "v" } },
        { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "[Snacks] Lazygit" },
        { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "[Snacks] Dismiss All Notifications" },
        { "<c-/>",           function() Snacks.terminal() end,                                       desc = "[Snacks] Toggle Terminal" },
        { "<c-_>",           function() Snacks.terminal() end,                                       desc = "[Snacks] which_key_ignore" },
        { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "[Snacks] Next Reference",             mode = { "n", "t" } },
        { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "[Snacks] Prev Reference",             mode = { "n", "t" } },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end

                -- Override print to use snacks for `:=` command
                if vim.fn.has("nvim-0.11") == 1 then
                    vim._print = function(_, ...)
                        dd(...)
                    end
                else
                    vim.print = _G.dd
                end

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end,
}
