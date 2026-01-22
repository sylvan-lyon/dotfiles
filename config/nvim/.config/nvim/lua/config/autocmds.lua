--#region
local lazy_file_group = vim.api.nvim_create_augroup(
    "UserLazyFileGroup",
    { clear = true }
)

-- NOTE: this triggers before file is loaded from disk or new file
-- refer to event `User LazyFilePost`
vim.api.nvim_create_autocmd(
    { "BufReadPre", "BufWritePre", "BufNewFile" },
    {
        desc = [[alias for event { "BufReadPre", "BufWritePre", "BufNewFile" }]],
        group = lazy_file_group,
        once = true,
        callback = function()
            vim.api.nvim_exec_autocmds(
                "User",
                { pattern = "LazyFilePre" }
            )
        end
    }
)

-- NOTE: this triggers after file is loaded from disk or new file
-- refer to event `User LazyFilePre`
vim.api.nvim_create_autocmd(
    { "BufReadPost", "BufWritePost", "BufNewFile" },
    {
        desc = [[alias for event { "BufReadPost", "BufWritePost", "BufNewFile" }]],
        group = lazy_file_group,
        once = true,
        callback = function()
            vim.api.nvim_exec_autocmds(
                "User",
                { pattern = "LazyFilePost" }
            )
        end
    }
)
--#endregion

-- NOTE: highlight upon yank some text
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        desc = "Highlight after yank text",
        group = vim.api.nvim_create_augroup("UserHighlightYank", { clear = true }),
        callback = function()
            vim.highlight.on_yank()
        end
    }
)

--#region
local filetype_group = vim.api.nvim_create_augroup("UserFileType", { clear = true })
-- NOTE: color column set on git message files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    group = filetype_group,
    desc = "auto setup colorcolumn for `gitcommit`",
    -- we usually open COMMIT_MESSAGE by the "git commit", so set `once` should be ok
    once = true,
    callback = function()
        vim.wo.colorcolumn = "75"
    end
})

-- NOTE:  try auto-enable treesitter on every file type
vim.api.nvim_create_autocmd('FileType', {
    group = filetype_group,
    desc = "auto setup treesitter functionality after filetype detected",
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- NOTE: auto tab options
vim.api.nvim_create_autocmd("FileType", {
    group = filetype_group,
    desc = "auto change tab options",
    callback = function(event)
        ---@class TabOpt
        ---@field expandtab boolean
        ---@field tabstop integer
        ---@field shiftwidth integer
        ---@field softtabstop integer

        ---Get tab option of a certain file type
        ---@param filetype string
        ---@return TabOpt
        local tab_opt_of   = function(filetype)
            ---@type table<string, TabOpt>
            local preset = {
                ["2spaces"] = { expandtab = true, tabstop = 2, shiftwidth = 2, softtabstop = 2 },
                ["default"] = { expandtab = true, tabstop = 4, shiftwidth = 4, softtabstop = 4 },
            }

            ---@type table<string, TabOpt>
            local tab_opt = {
                ["javascript"] = preset["2spaces"],
                ["yaml"]       = preset["2spaces"],
            }

            return tab_opt[filetype] or preset["default"]
        end

        local option       = tab_opt_of(event.match)
        vim.bo.tabstop     = option.tabstop
        vim.bo.expandtab   = option.expandtab
        vim.bo.shiftwidth  = option.shiftwidth
        vim.bo.softtabstop = option.softtabstop
    end
})
--#endregion
