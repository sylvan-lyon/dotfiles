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

vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local spinner = {
            " ", -- new
            " ", " ", " ", " ", " ", " ", -- waxing crescent
            " ", -- first quarter
            " ", " ", " ", " ", " ", " ", -- waxing gibbous
            " ", -- full
            " ", " ", " ", " ", " ", " ", -- waning gibbous
            " ", -- last quarter
            " ", " ", " ", " ", " ", " ", -- waning crescent
        }
        vim.notify(
            vim.lsp.status():sub(0, 38),
            vim.log.levels.INFO,
            {
                id = "lsp_progress",
                title = "LSP Progress",
                opts = function(notif)
                    notif.icon = ev.data.params.value.kind == "end" and " "
                        or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                    -- 80 * 1e6 ns = 80 ms, so this is 12.5 (1000 / 80) frames per second
                end,
            })
    end,
})
