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

-- NOTE: color column set on git message files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    -- we usually open COMMIT_MESSAGE by the "git commit", so set `once` should be ok
    once = true,
    callback = function()
        vim.wo.colorcolumn = "80"
    end
})

-- NOTE:  try auto-enable treesitter on every file type
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup("auto setup treesitter functionality after filetype detected", { clear = true }),
    callback = function()
        local success = pcall(vim.treesitter.start)
    end,
})
