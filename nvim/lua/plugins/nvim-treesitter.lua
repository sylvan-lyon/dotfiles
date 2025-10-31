return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            -- 你需要安装的语言解析器
            ensure_installed = { "rust", "lua", "json" },
            highlight = { enable = true },
            incremental_selection = {
                enable = false, -- 禁用默认 incremental_selection，避免冲突
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    include_surrounding_whitespace = true,
                    keymaps = {
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["gc"] = "@comment.outer",
                        ["at"] = "@tag.outer",
                        ["it"] = "@tag.inner",
                        ["ai"] = "@block.outer",
                        ["ii"] = "@block.inner",
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "V",
                        ["@comment.outer"] = "V",
                        ["@tag.outer"] = "v",
                        ["@block.outer"] = "V",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                        ["]/"] = "@comment.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                        ["[/"] = "@comment.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            },
        },

        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)

            local api = vim.api
            local ts = vim.treesitter

            -- 全局状态：记住 Normal → Visual 时的初始 span
            -- { srow, scol, erow, ecol_inclusive } (0-based)
            local initial_span = nil

            -- 获取当前 visual 选区的 span (0-based, inclusive end col)
            local function get_visual_span()
                local vstart = vim.fn.getpos("v")
                local vend = vim.fn.getpos(".")

                local start_row, start_col = vstart[2] - 1, vstart[3] - 1
                local end_row, end_col = vend[2] - 1, vend[3] - 1

                -- 确保 start < end
                if start_row > end_row or (start_row == end_row and start_col > end_col) then
                    start_row, end_row = end_row, start_row
                    start_col, end_col = end_col, start_col
                end

                -- 返回 { srow, scol, erow, ecol_inclusive }
                return { start_row, start_col, end_row, end_col }
            end

            -- 比较两个 span 是否相同 (都使用 inclusive end col)
            local function spans_equal_safe(s1, s2)
                if not s1 or not s2 then return false end
                return s1[1] == s2[1] and s1[2] == s2[2] and s1[3] == s2[3] and s1[4] == s2[4]
            end

            -- 选中节点 (node:range() 返回 exclusive end col)
            local function select_node_safe(node)
                if not node then return end
                -- node:range() -> { srow, scol, erow, ecol_exclusive }
                local srow, scol, erow, ecol_exclusive = node:range()

                local mode = api.nvim_get_mode().mode
                if mode:match("[vV\22]") then
                    vim.cmd("normal! \27") -- 退出当前 visual
                end

                api.nvim_win_set_cursor(0, { srow + 1, scol })
                vim.cmd("normal! v")
                -- 使用 exclusive ecol, -1 得到 inclusive ecol
                local target_ecol_inclusive = math.max(0, ecol_exclusive - 1)
                api.nvim_win_set_cursor(0, { erow + 1, target_ecol_inclusive })
            end

            -- 获取完全覆盖当前 visual span 的最小节点（从 descendant_for_range 向上找）
            -- 注意: span 参数是 { srow, scol, erow, ecol_inclusive }
            local function get_covering_node(span)
                local bufnr = api.nvim_get_current_buf()
                local parser = ts.get_parser(bufnr)
                if not parser then return nil end

                local tree = parser:parse()[1]
                if not tree then return nil end
                local root = tree:root()

                -- descendant_for_range 期望 exclusive end col，但我们传入 inclusive 的
                -- Treesitter 内部会自动处理这个边界情况，但为了严谨性，这里可以传入 exclusive 范围
                -- 简单起见，我们继续使用 span 作为范围。
                local node = root:descendant_for_range(span[1], span[2], span[3], span[4])
                if not node then return nil end

                -- 向上找完全覆盖 span 的最小节点
                while node do
                    local srow, scol, erow, ecol_exclusive = node:range()
                    -- node covers span if node start <= span.start and node end >= span.end
                    -- 注意 ecol_exclusive 是 exclusive，span[4] 是 inclusive
                    if srow <= span[1] and scol <= span[2] and erow >= span[3] and ecol_exclusive > span[4] then
                        local parent = node:parent()
                        if not parent then return node end
                        local psrow, pscol, perow, pecol = parent:range()
                        -- 如果 parent 的范围等于 node 的范围，继续向上（保护性检查）
                        if psrow == srow and pscol == scol and perow == erow and pecol == ecol_exclusive then
                            node = parent
                        else
                            return node
                        end
                    else
                        node = node:parent()
                    end
                end
                return nil
            end

            -- 获取光标下最小语义节点
            local function get_smallest_node_at_cursor()
                local cursor = api.nvim_win_get_cursor(0)
                local row, col = cursor[1] - 1, cursor[2]

                local bufnr = api.nvim_get_current_buf()
                local parser = ts.get_parser(bufnr)
                if not parser then return nil end

                local tree = parser:parse()[1]
                if not tree then return nil end
                local root = tree:root()

                local node = root:descendant_for_range(row, col, row, col)
                if not node then return nil end

                -- 向下找最小节点（逻辑不变）
                while true do
                    local found = false
                    for i = 0, node:child_count() - 1 do
                        local child = node:child(i)
                        if child then
                            local srow, scol, erow, ecol_exclusive = child:range()
                            if srow <= row and erow >= row and scol <= col and ecol_exclusive > col then
                                node = child
                                found = true
                                break
                            end
                        end
                    end
                    if not found then break end
                end

                return node
            end

            -- 【核心修复】新增：在 parent 下找到包含 initial_span 的那个“顶层子节点”
            -- 用于 ]x 缩小操作。它从 initial_span 向上找祖先，直到其 parent 等于目标 parent。
            -- initial 参数是 { srow, scol, erow, ecol_inclusive }
            local function get_child_ancestor_of_initial(parent, initial)
                if not parent or not initial then return nil end

                local bufnr = api.nvim_get_current_buf()
                local parser = ts.get_parser(bufnr)
                if not parser then return nil end

                local tree = parser:parse()[1]
                if not tree then return nil end
                local root = tree:root()

                -- 确保 initial 在 parent 范围内
                local psrow, pscol, perow, pecol_exclusive = parent:range()
                if not (psrow <= initial[1] and pscol <= initial[2] and perow >= initial[3] and pecol_exclusive > initial[4]) then
                    return nil
                end

                -- 找出 initial_span 对应的最小节点
                local inner = root:descendant_for_range(initial[1], initial[2], initial[3], initial[4])
                if not inner then return nil end

                -- 向上找到 parent 的直接子（也就是 inner 的祖先，且其 parent == parent）
                local cur = inner
                while cur and cur:parent() do
                    if cur:parent() == parent then
                        return cur
                    end
                    cur = cur:parent()
                end

                return nil
            end


            --- 键位映射 ---

            -- [x in Normal: 进入 visual + 记住最小语义节点
            vim.keymap.set("n", "[x", function()
                local node = get_smallest_node_at_cursor()
                if not node then return end

                local srow, scol, erow, ecol_exclusive = node:range()
                -- 存储 { srow, scol, erow, ecol_inclusive }
                initial_span = { srow, scol, erow, math.max(0, ecol_exclusive - 1) }
                select_node_safe(node)
            end, { desc = "Enter visual: select minimal semantic block" })

            -- 【修复后的 [x in Visual】: 扩大到父节点（支持到根节点，并安全停止）
            vim.keymap.set("x", "[x", function()
                local span = get_visual_span() -- inclusive end col
                local node = get_covering_node(span)
                if not node then return end

                local parent = node:parent()

                if not parent then
                    return -- 已经是根节点，不做任何事
                end

                -- 检查 parent 是否是 Treesitter 的根节点 (根节点没有父节点)
                -- 根节点是 Treesitter 树的最顶层节点，它的 parent() 返回 nil
                if not parent:parent() then
                    -- 已经是根节点。使用 ggVG 安全地全选，避免 select_node 因范围错误而崩溃。
                    vim.cmd("normal! \27")  -- 退出 visual
                    vim.cmd("normal! ggVG") -- 安全地全选
                else
                    -- 不是根节点，正常选中
                    select_node_safe(parent)
                end
            end, { desc = "Expand to parent node (safe root)" })

            -- 【修复后的 ]x in Visual】: 缩小到子节点，或回到 initial_span 则退出
            vim.keymap.set("x", "]x", function()
                local current_span = get_visual_span() -- inclusive end col

                -- 1. 检查是否应该退出
                if initial_span and spans_equal_safe(current_span, initial_span) then
                    vim.cmd("normal! \27") -- 退出 visual
                    -- autocmd 会清理 initial_span
                    return
                end

                local current_node = get_covering_node(current_span)
                if not current_node then return end

                -- 2. 尝试找到正确的缩小目标 (即 current_node 的、包含了 initial_span 的那个直接子节点)
                local shrink_target = get_child_ancestor_of_initial(current_node, initial_span)

                if shrink_target then
                    -- 3. 找到了一个有效的 AST 子节点，选中它
                    select_node_safe(shrink_target)
                else
                    -- 4. 无法通过 AST 找到更小的子节点，或当前选区已是 initial_span 的父节点
                    --    回退到 initial_span
                    if initial_span then
                        -- 避免反复退出 visual mode
                        local mode = api.nvim_get_mode().mode
                        if mode:match("[vV\22]") then
                            vim.cmd("normal! \27")
                        end

                        local srow, scol, erow, ecol_inclusive = unpack(initial_span)

                        -- 重新选中 initial_span
                        api.nvim_win_set_cursor(0, { srow + 1, scol })
                        vim.cmd("normal! v")
                        api.nvim_win_set_cursor(0, { erow + 1, ecol_inclusive })
                        return
                    end

                    -- 如果没有 initial_span (不应该发生)，则退出 visual
                    vim.cmd("normal! \27")
                end
            end, { desc = "Shrink to child or revert to initial" })


            -- 退出 visual mode 时清理状态
            vim.api.nvim_create_autocmd("ModeChanged", {
                -- 从 V/v/\22 模式切换到非 visual 模式
                pattern = "[vV\22]:[^vV\22]*",
                callback = function()
                    initial_span = nil
                end,
            })
        end,
    },
}
