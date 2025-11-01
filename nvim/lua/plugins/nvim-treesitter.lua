-- 完整配置
return {
    {
        -- 主插件：nvim-treesitter
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",

        -- 将 textobjects 明确设置为依赖项
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

        -- 所有的配置 (包括 textobjects 的配置) 都放在 opts 中
        opts = {
            -- 你需要安装的语言解析器
            ensure_installed = { "rust", "lua", "json", "javascript", "typescript", "html", "css" },
            highlight = { enable = true },
            incremental_selection = {
                enable = false, -- 禁用默认 incremental_selection
            },

            -- nvim-treesitter-textobjects 的配置 (保持不变)
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

        -- 唯一的 config 函数，包含我们自定义的增量选择逻辑
        config = function(_, opts)
            -- 1. 运行 nvim-treesitter 的标准 setup
            require("nvim-treesitter.configs").setup(opts)

            -- 2. 定义 API 和状态机
            local api = vim.api
            local ts = vim.treesitter

            --- 状态机 ---
            local state = {
                span_stack = {}, -- (table) 存储 {srow, scol, erow, ecol_inclusive} (0-based)
                enter_mode = nil, -- (string) "n" (Normal) 或 "v" (Visual)
            }

            -- 内部选择锁
            local is_internal_selection = false

            --- 辅助函数：状态管理 ---

            local function clear_state()
                state.span_stack = {}
                state.enter_mode = nil
                vim.notify("增量选择已退出", vim.log.levels.DEBUG, { title = "TS-Select" })
            end

            --- 辅助函数：Span 和 节点 ---

            -- [新] 获取光标位置 (0-based) 并格式化为 span
            local function get_cursor_span()
                local cursor = api.nvim_win_get_cursor(0) -- {row_1based, col_0based}
                local row, col = cursor[1] - 1, cursor[2]
                return { row, col, row, col }
            end

            -- [新] 将 TS 节点 转换为 我们的 0-based inclusive span
            local function node_to_span(node)
                if not node then return nil end
                local srow, scol, erow, ecol_exclusive = node:range()
                -- 转换为 inclusive
                local ecol_inclusive = math.max(0, ecol_exclusive - 1)
                return { srow, scol, erow, ecol_inclusive }
            end

            -- [已修复] get_visual_span (处理 'V' 模式)
            local function get_visual_span()
                local vstart = vim.fn.getpos("v")
                local vend = vim.fn.getpos(".")
                local start_row, start_col = vstart[2] - 1, vstart[3] - 1
                local end_row, end_col = vend[2] - 1, vend[3] - 1

                if start_row > end_row or (start_row == end_row and start_col > end_col) then
                    start_row, end_row = end_row, start_row
                    start_col, end_col = end_col, start_col
                end

                if vim.fn.mode() == "V" then
                    start_col = 0
                    local line_content = api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1] or ""
                    end_col = math.max(0, vim.fn.strbytes(line_content) - 1)
                    if #line_content == 0 then end_col = 0 end
                end

                return { start_row, start_col, end_row, end_col }
            end

            -- [来自你的代码] 安全比较 spans
            local function spans_equal_safe(s1, s2)
                if not s1 or not s2 then return false end
                return s1[1] == s2[1] and s1[2] == s2[2] and s1[3] == s2[3] and s1[4] == s2[4]
            end

            -- [修改] select_node_safe 现在接受 span
            local function select_node_safe(span)
                if not span then return end
                is_internal_selection = true -- [1] 设置锁

                local mode = api.nvim_get_mode().mode
                if mode:match("[vV\22]") then
                    vim.cmd("normal! \27") -- 退出当前 visual
                end

                local srow, scol, erow, ecol_inclusive = span[1], span[2], span[3], span[4]

                api.nvim_win_set_cursor(0, { srow + 1, scol })
                vim.cmd("normal! v")
                api.nvim_win_set_cursor(0, { erow + 1, ecol_inclusive })

                vim.schedule(function() -- [3] 释放锁
                    is_internal_selection = false
                end)
            end

            -- [来自你的代码] 获取光标处的最小节点
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

            -- [已修复] get_covering_node (移除错误 'else' 分支)
            local function get_covering_node(span)
                local bufnr = api.nvim_get_current_buf()
                local parser = ts.get_parser(bufnr)
                if not parser then return nil end
                local tree = parser:parse()[1]
                if not tree then return nil end
                local root = tree:root()

                -- span[4] 已经是 inclusive, descendant_for_range 期望 exclusive
                local ecol_exclusive_query = span[4] + 1

                local node = root:descendant_for_range(span[1], span[2], span[3], ecol_exclusive_query)

                if not node then
                    -- 回退：检查根节点是否包含此 span
                    local rsrow, rscol, rerow, recol_ex = root:range()
                    if rsrow <= span[1] and rscol <= span[2] and rerow >= span[3] and recol_ex > span[4] then
                        return root
                    end
                    return nil
                end

                -- 向上爬，*只*跳过具有完全相同 span 的包装器节点
                while node:parent() do
                    local parent = node:parent()
                    local srow, scol, erow, ecol = node:range()
                    local psrow, pscol, perow, pecol = parent:range()

                    if psrow == srow and pscol == scol and perow == erow and pecol == ecol then
                        node = parent -- 爬上包装器
                    else
                        break -- 找到了第一个非包装器
                    end
                end

                return node
            end


            --- 3. 键位映射 (Keymaps) ---

            -- [x] in Normal (启动会话)
            vim.keymap.set("n", "[x", function()
                vim.notify("[x] Normal: 启动增量选择", vim.log.levels.DEBUG, { title = "TS-Select" })
                clear_state()
                state.enter_mode = "n"

                local cursor_span = get_cursor_span()
                local node = get_smallest_node_at_cursor()

                if not node then
                    vim.notify("[x] Normal: 未找到节点", vim.log.levels.WARN, { title = "TS-Select" })
                    return
                end

                local node_span = node_to_span(node)
                if not node_span then return end    -- 安全检查

                table.insert(state.span_stack, cursor_span) -- [1] 栈底: 光标
                table.insert(state.span_stack, node_span) -- [2] 栈顶: 节点

                select_node_safe(node_span)
            end, { desc = "Enter incremental selection (semantic)" })

            -- [x] in Visual (启动或扩大)
            vim.keymap.set("x", "[x", function()
                local current_span = get_visual_span()
                local node = get_covering_node(current_span)

                if not node then
                    vim.notify("[x] Visual: 未找到覆盖节点", vim.log.levels.WARN, { title = "TS-Select" })
                    return
                end

                if #state.span_stack == 0 then
                    -- 1. 新会话 (New Session)
                    vim.notify("[x] Visual: 启动增量选择", vim.log.levels.DEBUG, { title = "TS-Select" })
                    state.enter_mode = "v"
                    table.insert(state.span_stack, current_span) -- [1] 栈底: 原始 Visual 选区

                    local parent = node:parent()
                    if parent and parent:parent() then      -- 确保不是根节点
                        local parent_span = node_to_span(parent)
                        table.insert(state.span_stack, parent_span) -- [2] 栈顶: 父节点
                        select_node_safe(parent_span)
                    else
                        vim.notify("[x] Visual: 已在顶层", vim.log.levels.INFO, { title = "TS-Select" })
                        -- 栈中只有原始选区，保持选中
                    end
                else
                    -- 2. 继续会话 (Expand)
                    local top_span = state.span_stack[#state.span_stack]

                    -- 检查手动移动
                    if not spans_equal_safe(current_span, top_span) then
                        vim.notify("[x] Visual: 检测到手动选区, 重启会话", vim.log.levels.WARN, { title = "TS-Select" })
                        clear_state()
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("[x", true, false, true), "x", false)
                        return
                    end

                    -- 正常扩大
                    local top_node = get_covering_node(top_span)
                    if not top_node then return end -- 安全

                    local parent = top_node:parent()
                    if parent and parent:parent() then
                        local parent_span = node_to_span(parent)
                        vim.notify(string.format("[x] Visual: 扩大到 %s", parent:type()), vim.log.levels.DEBUG,
                            { title = "TS-Select" })
                        table.insert(state.span_stack, parent_span)
                        select_node_safe(parent_span)
                    else
                        vim.notify("[x] Visual: 扩大到文档根节点 (ggVG)", vim.log.levels.INFO, { title = "TS-Select" })
                        vim.cmd("normal! \27")
                        vim.cmd("normal! ggVG")
                        -- 这是一个受迫退出，清理状态
                        clear_state()
                    end
                end
            end, { desc = "Expand selection (semantic)" })

            -- ]x in Visual (缩小或退出)
            vim.keymap.set("x", "]x", function()
                -- 1. 检查是否在会话中
                if #state.span_stack == 0 then
                    vim.notify("]x Visual: 不在增量选择模式", vim.log.levels.WARN, { title = "TS-Select" })
                    clear_state()
                    vim.cmd("normal! \27")
                    return
                end

                local current_span = get_visual_span()
                local top_span = state.span_stack[#state.span_stack]

                -- 2. 检查手动移动 (受迫退出)
                if not spans_equal_safe(current_span, top_span) then
                    vim.notify("]x Visual: 检测到手动选区, 退出会话", vim.log.levels.WARN, { title = "TS-Select" })
                    clear_state()
                    vim.cmd("normal! \27")
                    return
                end

                -- 3. 正常缩小 / 退出
                if #state.span_stack == 1 then
                    -- 3a. 自然退出 (栈底)
                    local original_mode = state.enter_mode
                    local base_span = state.span_stack[1]

                    vim.notify("]x Visual: 自然退出", vim.log.levels.DEBUG, { title = "TS-Select" })
                    clear_state() -- 必须在操作前清理

                    if original_mode == "n" then
                        vim.cmd("normal! \27") -- 退出 visual
                        -- 恢复光标 (base_span is {r, c, r, c})
                        api.nvim_win_set_cursor(0, { base_span[1] + 1, base_span[2] })
                    else -- original_mode == "v"
                        -- 恢复原始 visual 选区
                        select_node_safe(base_span)
                    end
                else
                    -- 3b. 正常缩小
                    table.remove(state.span_stack) -- 弹出当前
                    -- [TYPO FIX]: 修复了 state.stack_span -> state.span_stack
                    local new_top_span = state.span_stack[#state.span_stack]
                    vim.notify("]x Visual: 缩小", vim.log.levels.DEBUG, { title = "TS-Select" })
                    select_node_safe(new_top_span)
                end
            end, { desc = "Shrink selection / exit incremental (semantic)" })


            --- 4. Autocmd (受迫退出) ---
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "[vV\22]:[^vV\22]*", -- Visual to Non-Visual
                callback = function()
                    -- [1] 检查锁
                    if is_internal_selection then
                        vim.notify("ModeChanged: 内部选择, 跳过清理", vim.log.levels.DEBUG, { title = "TS-Select" })
                        return -- 如果是内部选择，不要清理
                    end

                    -- [2] 检查是否在会话中 (用户手动按 <Esc>)
                    if state.enter_mode ~= nil then
                        vim.notify("ModeChanged: 用户退出, 清理增量状态", vim.log.levels.DEBUG, { title = "TS-Select" })
                        clear_state()
                    end
                end,
            })

            vim.notify("Treesitter 自定义增量选择已加载 (v3 - 已修复)", vim.log.levels.DEBUG, { title = "TS-Config" })
        end
    },
}
