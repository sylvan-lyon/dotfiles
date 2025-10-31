return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            ------------------------------------------------------------
            -- 🧩 在这里定义你自己的 LSP 配置表（这是“声明区”）
            ------------------------------------------------------------
            local servers = {
                lua_ls = {
                    root_markers = { ".nvim-lsp.json", ".git" },
                },
                rust_analyzer = {
                    root_markers = { ".nvim-lsp.json", ".git" },
                },
                clangd = {
                    root_markers = { ".nvim-lsp.json", ".git" },
                },
                pyright = {
                    root_markers = { ".nvim-lsp.json", ".git" },
                },
                ts_ls = {
                    root_markers = { ".nvim-lsp.json", ".git" },
                },
            }

            ------------------------------------------------------------
            -- 📄 读取 .nvim-lsp.json 项目配置
            ------------------------------------------------------------
            local function load_project_config()
                local config_file = vim.fs.find(".nvim-lsp.json", { upward = true, stop = vim.loop.os_homedir() })[1]
                if not config_file then
                    return {}
                end
                local ok, data = pcall(function()
                    return vim.fn.json_decode(vim.fn.readfile(config_file))
                end)
                if ok and type(data) == "table" then
                    return data
                end
                return {}
            end

            ------------------------------------------------------------
            -- ⚙️ 通用 LSP 回调绑定
            ------------------------------------------------------------
            local function on_attach(_, bufnr)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true, noremap = true })
                end

                -- 跳转
                map("n", "gd", vim.lsp.buf.definition, "[LSP] 转到定义")
                map("n", "gD", vim.lsp.buf.declaration, "[LSP] 转到声明")
                map("n", "gy", vim.lsp.buf.type_definition, "[LSP] 转到类型定义")
                map("n", "gI", vim.lsp.buf.implementation, "[LSP] 转到实现")
                map("n", "gA", vim.lsp.buf.references, "[LSP] 转到当前选中单词的引用")
                map("n", "gs", vim.lsp.buf.document_symbol, "[LSP] 此 buffer 的所有符号")
                map("n", "gS", vim.lsp.buf.workspace_symbol, "[LSP] 此项目的所有符号")

                map("n", "cd", vim.lsp.buf.rename, "[LSP] 重命名")

                -- 诊断
                map("n", "gl", vim.diagnostic.open_float, "[LSP] 查看代码诊断")
                map("n", "g[", function() vim.diagnostic.jump({ count = -1, float = true }) end, "[LSP] 上一个代码诊断")
                map("n", "g]", function() vim.diagnostic.jump({ count = 1, float = true }) end, "[LSP] 下一个代码诊断")
                map("n", "gh", vim.lsp.buf.hover, "[LSP] 查看 inline hints")
                map("n", "g.", vim.lsp.buf.code_action, "[LSP] 打开 code actions")
                -- 格式化
                map("n", "<leader>cf", function()
                    vim.lsp.buf.format { async = true }
                end, "[LSP] 代码格式化")
            end

            ------------------------------------------------------------
            -- 🧠 blink.cmp 补全能力注入
            ------------------------------------------------------------
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local ok_cmp, cmp = pcall(require, "blink.cmp")
            if ok_cmp then
                capabilities = cmp.get_lsp_capabilities(capabilities)
            end

            ------------------------------------------------------------
            -- 🚀 启动逻辑
            ------------------------------------------------------------
            local project_conf = load_project_config()

            for name, conf in pairs(servers) do
                -- 合并默认配置和项目配置
                local merged = vim.tbl_deep_extend("force", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }, conf, project_conf[name] or {})

                -- 自动推断 root_dir
                local markers = merged.root_markers or { ".nvim-lsp.json", ".git" }
                local root = merged.root_dir or vim.fs.root(0, markers) or vim.fn.getcwd()
                merged.root_dir = root

                -- 现代 Neovim LSP 启动逻辑
                if vim.lsp.config then
                    vim.lsp.config(name, merged)
                    vim.lsp.enable(name)
                else
                    merged.name = name
                    vim.lsp.start(merged)
                end
            end

            ------------------------------------------------------------
            -- 最后返回定义表，方便在别处 require() 时访问
            ------------------------------------------------------------
            return servers
        end,
    },

    -- Mason 可选
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
}
