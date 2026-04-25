local config_name = "/.lsp.lua"
---@type string[]
local default_enabled = {
    "rust_analyzer",
    "lua_ls",
    "jsonls",
    "tombi",
    "nushell",
    "markdown_oxide",
    "clangd",
    "bashls",
    "powershell_es",
    "gopls",
    "pyrefly",
}

local _actions = function()
    local ok, snacks = pcall(require, "snacks")
    local pick = ok and snacks.picker

    return {
        toggle_inlay_hint = function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        hover = function()
            vim.lsp.buf.hover({ max_width = 80, max_height = 32 })
        end,
        code_action = function()
            vim.lsp.buf.code_action()
        end,
        format = function()
            vim.lsp.buf.format()
        end,
        rename = function()
            vim.lsp.buf.rename()
        end,
        jump_back_diagnostic = function()
            vim.diagnostic.jump({ count = -1, float = true })
        end,
        jump_next_diagnostic = function()
            vim.diagnostic.jump({ count = 1, float = true })
        end,
        open_float_diagnostic = function()
            vim.diagnostic.open_float({ max_width = 80, max_height = 32 })
        end,
        definitions = function()
            if pick then
                pick.lsp_definitions()
            else
                vim.lsp.buf.definition()
            end
        end,
        declarations = function()
            if pick then
                pick.lsp_declarations()
            else
                vim.lsp.buf.declaration()
            end
        end,
        type_definitions = function()
            if pick then
                pick.lsp_type_definitions()
            else
                vim.lsp.buf.type_definition()
            end
        end,
        implementations = function()
            if pick then
                pick.lsp_implementations()
            else
                vim.lsp.buf.implementation()
            end
        end,
        references = function()
            if pick then
                pick.lsp_references()
            else
                vim.lsp.buf.references()
            end
        end,
        incoming_calls = function()
            if pick then
                pick.lsp_incoming_calls()
            else
                vim.lsp.buf.incoming_calls()
            end
        end,
        outgoing_calls = function()
            if pick then
                pick.lsp_outgoing_calls()
            else
                vim.lsp.buf.outgoing_calls()
            end
        end,
        symbols = function()
            if pick then
                pick.lsp_symbols()
            else
                vim.lsp.buf.document_symbol()
            end
        end,
        workspace_symbols = function()
            if pick then
                pick.lsp_workspace_symbols()
            else
                vim.lsp.buf.workspace_symbol()
            end
        end,
    }
end

---@param client vim.lsp.Client
---@param bufnr integer
local general_on_attach = function(client, bufnr)
    local actions = _actions()
    require("utils").keyset({
        { "<c-w>d",     actions.open_float_diagnostic, buffer = bufnr, silent = true, noremap = true, desc = "code [d]iagnostic" },
        { "gra",        actions.code_action,           buffer = bufnr, silent = true, noremap = true, desc = "[g]oto code [a]ctions" },
        { "grf",        actions.format,                buffer = bufnr, silent = true, noremap = true, desc = "[g]oto code [f]ormat" },
        { "grn",        actions.rename,                buffer = bufnr, silent = true, noremap = true, desc = "[g]oto code [r]e[n]me" },
        { "K",          actions.hover,                 buffer = bufnr, silent = true, noremap = true, desc = "show documentation" },
        { "[d",         actions.jump_back_diagnostic,  buffer = bufnr, silent = true, noremap = true, desc = "previous diagnose" },
        { "]d",         actions.jump_next_diagnostic,  buffer = bufnr, silent = true, noremap = true, desc = "next diagnose" },
        { "<leader>ti", actions.toggle_inlay_hint,     buffer = bufnr, silent = true, noremap = true, desc = "[t]oggle [i]nlay hints" },
        { "gd",         actions.definitions,           buffer = bufnr, silent = true, noremap = true, desc = "[g]oto definitions" },
        { "gD",         actions.declarations,          buffer = bufnr, silent = true, noremap = true, desc = "[g]oto declarations" },
        { "gt",         actions.type_definitions,      buffer = bufnr, silent = true, noremap = true, desc = "[g]oto [t]ype definitions" },
        { "gri",        actions.implementations,       buffer = bufnr, silent = true, noremap = true, desc = "[g]oto [i]mplementations" },
        { "grr",        actions.references,            buffer = bufnr, silent = true, noremap = true, desc = "[g]oto [r]eferences" },
        { "gai",        actions.incoming_calls,        buffer = bufnr, silent = true, noremap = true, desc = "[g]oto c[a]ll [i]ncoming" },
        { "gao",        actions.outgoing_calls,        buffer = bufnr, silent = true, noremap = true, desc = "[g]oto c[a]ll [o]utgoing" },
        { "gO",         actions.symbols,               buffer = bufnr, silent = true, noremap = true, desc = "[g]oto d[O]cument symbols" },
        { "gS",         actions.workspace_symbols,     buffer = bufnr, silent = true, noremap = true, desc = "[g]oto work[S]pace symbols" },
    })

    if client:supports_method("textDocument/foldingRange") then
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
end

---@return table<string, table>|nil
local function load_lsp_config()
    -- get file path and see if we can read this file
    local config_file = vim.fn.getcwd() .. config_name
    if vim.fn.filereadable(config_file) == 0 then
        return nil
    end

    -- execute this file
    local success, result = pcall(dofile, config_file)
    if not success then
        vim.notify("Failed to execute file `" .. config_name .. "`", vim.log.levels.ERROR)
        return nil
    end

    -- check the result
    if not type(result) == "table" then
        vim.notify("Type returned from `" .. config_name .. "` should be table<string, vim.lsp.Config>")
        return nil
    end

    for k, v in pairs(result) do
        if not (type(k) == "string" and type(v) == "table") then
            vim.notify(
                ("The type of `%s` should be `vim.lsp.Config`, not `%s`, skipping..."):format(k, type(v)),
                vim.log.levels.WARN
            )
            return nil
        end
    end

    return result
end

return {
    "neovim/nvim-lspconfig",
    dependencies = "mason-org/mason.nvim",
    event = "User LazyFilePre",
    config = function(_, _)
        for _, name in ipairs(default_enabled) do
            local preset_on_attach = vim.lsp.config[name].on_attach

            vim.lsp.config(name, {
                on_attach = function(client, bufnr)
                    if preset_on_attach ~= nil then
                        preset_on_attach(client, bufnr)
                    end
                    general_on_attach(client, bufnr)
                end
            })

            vim.lsp.enable(name)
        end

        local result = load_lsp_config()
        if result then
            for name, config in pairs(result) do
                local preset_on_attach = vim.lsp.config[name] and vim.lsp.config[name].on_attach
                local proj_on_attach = config.on_attach

                local trues = 0
                if preset_on_attach then
                    trues = trues + 1
                end
                if proj_on_attach then
                    if type(proj_on_attach) == "function" then
                        trues = trues + 2
                    else
                        vim.notify(
                            ("The `on_attach` of client %s should be\n"):format(name) ..
                            "  either `nil` or `fun(client: vim.lsp.Client, bufnr: integer)`\n" ..
                            "  refer to https://neovim.io/doc/user/lsp.html#vim.lsp.Config.\n" ..
                            "It's suggested to notate return type `table<string, vim.lsp.Config>`.\n"
                        )
                    end
                end

                if trues == 0 then
                    config.on_attach = nil
                elseif trues == 1 then
                    config.on_attach = preset_on_attach
                elseif trues == 2 then
                    config.on_attach = proj_on_attach
                elseif trues == 3 then
                    config.on_attach = { preset_on_attach, proj_on_attach }
                end

                vim.lsp.config(name, config)
                vim.lsp.enable(name)
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
            },
            virtual_text = {
                prefix = " ●"
            },
            update_in_insert = true,
        })
    end
}
