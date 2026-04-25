local ensure_installed = {
    -- data transfer language
    "yaml", "toml", "json", "kdl",

    -- system language
    "rust", "go", "c", "cpp", "java",

    -- script language
    "lua", "python", "sql", "make", "bash", "zsh",

    -- front end
    "html", "css", "javascript",

    -- misc
    "regex", "latex", "markdown", "markdown_inline",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- lazy = false,
        cmd = {
            "TSInstall",
            "TSInstallFromGrammar",
            "TSUpdate",
            "TSUpdate",
            "TSUninstall",
            "TSLog",
            "TSListInstalled"
        },
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter")
            treesitter.setup()

            -- 安装所有未安装的语言解析器
            local parsers_to_install = {}
            local already_installed = treesitter.get_installed()
            for _, parser in ipairs(ensure_installed) do
                if not vim.tbl_contains(already_installed, parser) then
                    table.insert(parsers_to_install, parser)
                end
            end
            if #parsers_to_install > 0 then
                treesitter.install(parsers_to_install)
            end

            vim.api.nvim_create_user_command("TSListInstalled",
                ---@param _ vim.api.keyset.create_user_command.command_args
                function(_)
                    local res = ""
                    for _, lang in ipairs(require("nvim-treesitter").get_installed()) do
                        res = res .. lang .. "\n"
                    end
                    vim.print(res)
                end,
                { desc = "[nvim-treesitter] List all installed treesitter parsers", force = false }
            )
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "User LazyFilePost",
        config = function()
            require("treesitter-context").setup({
                multiline_threshold = 1,
                enable = true,
            })

            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
        end
    }
}
