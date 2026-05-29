---@type vim.lsp.Config
return {
    settings = {
        ["rust-analyzer"] = {
            check = { command = "clippy" },
            cargo = {
                ---@type string[]?
                features = nil,
                ---@type string[]?
                cfgs = nil,
            }
        }
    }
}
