return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = false },
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
            }
        },
        terminal = {
            enabled = true,
            win = {
                style = "float",
                border = "rounded",
                width = 0.8,
                height = 0.8,
                resize = true,
            },
            shell = "nu",
        }
    },
    keys = {
        { "<A-w>", function() Snacks.bufdelete() end, desc = "[snacks buffer] 关闭当前打开的缓冲区" },

        { "<leader><space>", function() Snacks.picker.smart() end, desc = "[snacks file   ] 智能查找文件 其实并不" },
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "[snacks buffer ] 打开的缓冲区" },
        { "<leader>/", function() Snacks.picker.grep() end, desc = "[snacks code   ] 全局文本搜索" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "[snacks command] 命令历史记录" },
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "[snacks notice ] 通知历史记录" },

        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[snacks buffer ] 查找缓冲区" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = "[snacks file   ] 查找配置文件" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "[snacks file   ] 查找文件" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "[snacks file   ] 查找 Git 文件" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "[snacks project] 查找项目" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "[snacks file   ] 最近文件" },

        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "[snacks git] Git 分支" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "[snacks git] Git 提交记录" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "[snacks git] 当前行的 Git 提交记录" },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "[snacks git] 打开当前文件的远程仓库位置", mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "[snacks git] 打开 LazyGit" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "[snacks git] Git 状态" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "[snacks git] Git 暂存列表" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "[snacks git] 查看 Git 差异（Hunks）" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "[snacks git] 当前文件的 Git 提交记录" },

        { "<leader>sb", function() Snacks.picker.lines() end, desc = "[snacks code    ] 当前缓冲区内容搜索" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "[snacks code    ] 在所有打开的缓冲区中搜索" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "[snacks code    ] 全局文本搜索" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[snacks code    ] 搜索选中文本或光标处的词", mode = { "n", "x" } },
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "[snacks register] 寄存器内容" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "[snacks search  ] 搜索历史" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "[snacks autocmd ] 自动命令 (autocmd)" },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "[snacks buffer  ] 缓冲区行搜索" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "[snacks command ] 历史命令" },
        { "<leader>sC", function() Snacks.picker.commands() end, desc = "[snacks command ] Neovim 命令列表" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[snacks diagnose] 所有诊断信息" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "[snacks diagnose] 当前缓冲区诊断" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "[snacks help_doc] 帮助文档" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "[snacks highligh] 高亮组信息" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "[snacks icon    ] 图标搜索" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "[snacks jump    ] 跳转记录" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[snacks keymap  ] 查看快捷键" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "[snacks position] 位置列表 (Loclist)" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "[snacks mark    ] 标记 (Marks)" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "[snacks mannual ] 手册" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "[snacks lazy    ] 插件定义 (Lazy Spec)" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[snacks quickfix] Quickfix 列表" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "[snacks search  ] 恢复上一次搜索" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "[snacks undo    ] 撤销历史 (Undo Tree)" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "[snacks lsp     ] 当前文件符号" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[snacks lsp     ] 工作区符号" },

        { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "[snacks colorscheme] 颜色方案选择" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "[snacks notice ] 关闭所有通知" },

        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "[snacks lsp] 跳转到定义" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "[snacks lsp] 跳转到声明" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "[snacks lsp] 查找引用" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "[snacks lsp] 跳转到实现" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "[snacks lsp] 跳转到类型定义" },

        { "<leader>z", function() Snacks.zen() end, desc = "[snacks zen    ] 切换禅模式" },
        { "<leader>Z", function() Snacks.zen.zoom() end, desc = "[snacks zoom   ] 切换缩放模式" },
        { "<leader>.", function() Snacks.scratch() end, desc = "[snacks scratch] 切换临时缓冲区 (Scratch)" },
        { "<leader>S", function() Snacks.scratch.select() end, desc = "[snacks scratch] 选择临时缓冲区" },
        { "<leader>n", function() Snacks.notifier.show_history() end, desc = "[snacks notice ] 查看通知历史" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "[snacks file] 重命名文件" },
        { "<c-/>", function() Snacks.terminal() end, desc = "[snacks terminal] 切换终端" },
        { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
        { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "[snacks word] 跳转到下一个引用", mode = { "n", "t" } },
        { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "[snacks word] 跳转到上一个引用", mode = { "n", "t" } },
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
