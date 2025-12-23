local config_file_name = ".nvim-lsp.json"

local presets = {
    ["lua_ls"] = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".nvim-lsp.json", ".git" },
    },
    ["rust-analyzer"] = {
        cmd = { "rust-analyzer" },
        root_markers = { "Cargo.toml", "Cargo.lock", ".nvim-lsp.json", ".git" },
        filetypes = { "rust" },
    },
}

---主要是配置按键绑定，没什么其他的
local on_attach = function(client, bufnr)
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true, noremap = true })
    end

    -- 跳转 & 诊断 & 格式化（保留你已有的按键映射）
    map("n", "grd", function() vim.lsp.buf.definition({ loclist = false, reuse_win = true }) end, "[LSP] 转到定义")
    map("n", "grD", vim.lsp.buf.declaration, "[LSP] 转到声明")
    map("n", "grt", vim.lsp.buf.type_definition, "[LSP] 转到类型定义")
    map("n", "gri", vim.lsp.buf.implementation, "[LSP] 转到实现")
    map("n", "grr", vim.lsp.buf.references, "[LSP] 转到引用")
    map("n", "gO", vim.lsp.buf.document_symbol, "[LSP] 此 buffer 的所有符号")
    map("n", "gS", vim.lsp.buf.workspace_symbol, "[LSP] 此项目的所有符号")

    map("n", "grl", vim.diagnostic.open_float, "[LSP] 查看代码诊断")
    map("n", "gr[", function() vim.diagnostic.jump({ count = -1, float = true }) end, "[LSP] 上一个代码诊断")
    map("n", "gr]", function() vim.diagnostic.jump({ count = 1, float = true }) end, "[LSP] 下一个代码诊断")
    map("n", "grn", vim.lsp.buf.rename, "[LSP] 重命名")
    map("n", "gra", vim.lsp.buf.code_action, "[LSP] 打开 code actions")
    map("n", "grf", function() vim.lsp.buf.format { async = true } end, "[LSP] 代码格式化")
    map("n", "K", function() vim.lsp.buf.hover({ max_width = 120, max_height = 32 }) end)
    map("n", "<leader>th", function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "[LSP] 启用/禁用 inlay hints")

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
    end
end

---读取 `file_name` 指定的文件名，将那个文件中的内容当成 **`JSON` 字符串解析**
---然后返回一个表，键为**服务器名称**，对应的值为**额外的配置项**
---
---## 实例
---```jsonc
---{
---    # 上面的 presets 表中的键
--     "rust-analyzer": {
--         # lsp 的 setting namespace，rust-analyzer 自己接受的所有配置项都在 "rust-analyzer" 下
--         "rust-analyzer": {
--             "cargo": {
--                 "features": [
--                     "release"
--                 ]
--             }
--         }
--     },
--     "lua_ls": {
--         "Lua": null
--     }
-- }
---```
---
---当然啊，vim 的函数实现并**不支持 `jsonc`**，上面的代码只是演示
---@param file_name string
---@return table<string, table<string, any>>
local load_project_config = function(file_name)
    if not vim.uv.fs_stat(file_name) then
        vim.notify(string.format("%s not found in cwd(%s)", file_name, vim.uv.cwd()), vim.log.levels.INFO)
        return {}
    end

    local file_success, lines = pcall(vim.fn.readfile, file_name)
    if not file_success then
        vim.notify(string.format("error while reading %s", file_name), vim.log.levels.ERROR)
        return {}
    end

    local content = table.concat(lines, "\n")

    local json_success, data = pcall(vim.fn.json_decode, content)
    if not json_success or type(data) ~= "table" then
        vim.notify(string.format("failed to decode %s (json_decode returned nil or non-table)", file_name),
            vim.log.levels.WARN)
        vim.notify("raw content (truncated): " .. vim.inspect(content:sub(1, 1024)), vim.log.levels.DEBUG)
        return {}
    else
        vim.notify("Loaded project config: " .. vim.json.encode(data), vim.log.levels.INFO)
        return data
    end
end

local setup_ls = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_available, cmp = pcall(require, "blink.cmp")
    if cmp_available and type(cmp.get_lsp_capabilities) == "function" then
        capabilities = cmp.get_lsp_capabilities(capabilities)
    end

    local project_level = load_project_config(config_file_name)


    for name, preset in pairs(presets) do
        ---@type vim.lsp.Config
        local final_config = vim.tbl_deep_extend("force", {
            capabilities = capabilities,
            on_attach = on_attach,
        }, preset or {})

        local proj_conf = project_level[name]
        if proj_conf and type(proj_conf) == "table" then
            final_config.settings = vim.tbl_deep_extend("force", final_config.settings or {}, proj_conf)
        end


        -- 使用现代 API 启动/注册 LSP
        if vim.lsp.config then
            vim.lsp.config(name, final_config)
            vim.lsp.enable(name)
        else
            final_config.name = name
            vim.lsp.start(final_config)
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

    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
    -- 魔法数字
    vim.opt.foldlevel = 99

end

return {
    {
        "mason-org/mason.nvim",
        config = function(_, opts)
            require("mason").setup(opts)
            setup_ls()
        end,
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
}
