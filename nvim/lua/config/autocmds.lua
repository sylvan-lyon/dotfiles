-- UserLazyFileGroup
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
        callback = function ()
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
        callback = function ()
            vim.api.nvim_exec_autocmds(
                "User",
                { pattern = "LazyFilePost" }
            )
        end
    }
)

vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        desc = "Highlight after yank text",
        group = vim.api.nvim_create_augroup("UserHighlightYank", { clear = true }),
        callback = function ()
            vim.highlight.on_yank()
        end
    }
)
