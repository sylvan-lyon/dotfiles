local servers = {
    lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".nvim-lsp.json", ".git" },
    },
    rust_analyzer = {
        root_markers = { ".nvim-lsp.json", ".git" },
    },
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            -- DEBUG 开关：设为 true 会用 vim.notify 显示 load 的 project config 与每个 server 的 merged settings
            local DEBUG = false

            ------------------------------------------------------------
            -- 📄 读取 .nvim-lsp.json 项目配置（更健壮：去 BOM，验证 JSON）
            ------------------------------------------------------------
            local function load_project_config()
                -- 向上查找第一个 .nvim-lsp.json 文件（直到用户主目录）
                local files = vim.fs.find(".nvim-lsp.json", { upward = true, stop = vim.loop.os_homedir() })
                local config_path = files and files[1]
                if not config_path then
                    if DEBUG then vim.notify(".nvim-lsp.json not found", vim.log.levels.DEBUG) end
                    return {}
                end

                local ok, lines = pcall(vim.fn.readfile, config_path)
                if not ok then
                    if DEBUG then vim.notify("failed to read .nvim-lsp.json: " .. tostring(lines), vim.log.levels.WARN) end
                    return {}
                end

                local content = table.concat(lines, "\n")
                -- 去除 UTF-8 BOM（如果有）
                if content:sub(1, 3) == '\239\187\191' then
                    content = content:sub(4)
                end

                local ok2, data = pcall(vim.fn.json_decode, content)
                if not ok2 or type(data) ~= "table" then
                    if DEBUG then
                        vim.notify("failed to decode .nvim-lsp.json (json_decode returned nil or non-table)",
                            vim.log.levels.WARN)
                        -- 显示前 1k 字节片段以便排查（不要太长）
                        vim.notify("raw content (truncated): " .. vim.inspect(content:sub(1, 1024)), vim.log.levels
                            .DEBUG)
                    end
                    return {}
                end

                return data
            end

            ------------------------------------------------------------
            -- ⚙️ 通用 LSP 回调绑定（on_attach）
            ------------------------------------------------------------
            local function on_attach(_, bufnr)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true, noremap = true })
                end

                -- 跳转 & 诊断 & 格式化（保留你已有的按键映射）
                map("n", "gd", vim.lsp.buf.definition, "[LSP] 转到定义")
                map("n", "gD", vim.lsp.buf.declaration, "[LSP] 转到声明")
                map("n", "gy", vim.lsp.buf.type_definition, "[LSP] 转到类型定义")
                map("n", "gI", vim.lsp.buf.implementation, "[LSP] 转到实现")
                map("n", "gA", vim.lsp.buf.references, "[LSP] 转到当前选中单词的引用")
                map("n", "gs", vim.lsp.buf.document_symbol, "[LSP] 此 buffer 的所有符号")
                map("n", "gS", vim.lsp.buf.workspace_symbol, "[LSP] 此项目的所有符号")

                map("n", "cd", vim.lsp.buf.rename, "[LSP] 重命名")

                map("n", "gl", vim.diagnostic.open_float, "[LSP] 查看代码诊断")
                map("n", "g[", function() vim.diagnostic.jump({ count = -1, float = true }) end, "[LSP] 上一个代码诊断")
                map("n", "g]", function() vim.diagnostic.jump({ count = 1, float = true }) end, "[LSP] 下一个代码诊断")
                map("n", "gh", vim.lsp.buf.hover, "[LSP] 查看 inline hints")
                map("n", "g.", vim.lsp.buf.code_action, "[LSP] 打开 code actions")

                map("n", "cf", function()
                    vim.lsp.buf.format { async = true }
                end, "[LSP] 代码格式化")
            end

            ------------------------------------------------------------
            -- 🧠 blink.cmp 补全能力注入（如果可用）
            ------------------------------------------------------------
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local ok_cmp, cmp = pcall(require, "blink.cmp")
            if ok_cmp and type(cmp.get_lsp_capabilities) == "function" then
                capabilities = cmp.get_lsp_capabilities(capabilities)
            end

            ------------------------------------------------------------
            -- 🚀 启动逻辑：读取项目配置并为每个 server 合并注入 settings
            ------------------------------------------------------------
            local project_conf = load_project_config()

            if DEBUG then
                vim.notify("Loaded project .nvim-lsp.json: " .. vim.inspect(project_conf), vim.log.levels.INFO)
            end

            local function hyphen(name) return name:gsub("_", "-") end

            for name, conf in pairs(servers) do
                -- 基础 merged（server-level 默认配置）
                local merged = vim.tbl_deep_extend("force", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }, conf or {})

                -- 尝试从 project_conf 中取对应项（支持 name 或 hyphen(name) 两种键）
                local hy = hyphen(name)
                local server_proj = project_conf[name] or project_conf[hy]

                if server_proj and type(server_proj) == "table" then
                    -- 如果用户在 .nvim-lsp.json 里直接写了类似完整 client config（例如包含 settings/root_dir）
                    -- 我们把它当作“完整片段”直接合并；否则把它包装到 settings["hyphen-name"] = server_proj
                    local looks_like_full_client_config =
                        server_proj.settings ~= nil or server_proj.root_dir ~= nil or server_proj.capabilities ~= nil or
                        server_proj.on_attach ~= nil

                    if looks_like_full_client_config then
                        merged = vim.tbl_deep_extend("force", merged, server_proj)
                    else
                        merged.settings = vim.tbl_deep_extend("force", merged.settings or {}, { [hy] = server_proj })
                    end
                end

                -- DEBUG: 显示注入给该 server 的 settings（如果有）
                if DEBUG then
                    local s = merged.settings or {}
                    -- 限制输出长度，避免通知过长阻塞
                    vim.notify(("LSP %s settings => %s"):format(name, vim.inspect(s)), vim.log.levels.INFO)
                end

                -- root_dir 推断：优先 merged.root_dir， 否则从当前 buffer 向上查找 markers
                local markers = merged.root_markers or { ".nvim-lsp.json", ".git" }
                local bufname = vim.api.nvim_buf_get_name(0)
                local found = nil
                if bufname and bufname ~= "" then
                    local list = vim.fs.find(markers, { upward = true, path = bufname })
                    found = list and list[1]
                end
                local root = merged.root_dir or (found and vim.fs.dirname(found)) or vim.loop.cwd()
                merged.root_dir = root

                -- 使用现代 API 启动/注册 LSP
                if vim.lsp.config then
                    vim.lsp.config(name, merged)
                    vim.lsp.enable(name)
                else
                    merged.name = name
                    vim.lsp.start(merged)
                end
            end

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    }
                }
            })
        end,
    },
}
