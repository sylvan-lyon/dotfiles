return {
    ---comment 连接两个表
    ---@param t1 table
    ---@param t2 table
    ---@return table
    concat_tables = function(t1, t2)
        local result = {}
        table.move(t1, 1, #t1, 1, result)
        table.move(t2, 1, #t2, #t1 + 1, result)
        return result
    end
}
