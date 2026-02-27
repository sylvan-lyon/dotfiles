local cppdbg = function()
    local utils = require("utils")
    if utils.is_windows then
        -- MasonInstall cpptools
        -- return "OpenDebugAD7.cmd"
        return "codelldb.cmd"
    elseif utils.is_unix_like then
        -- MasonInstall codelldb
        return "codelldb"
    else
        vim.notify(("Unkown OS to cppdbg: %s"):format(utils.sysname))
    end
end

local dap = require("dap")
dap.adapters.cppdbg = {
    type = "server",
    port = "${port}",
    executable = {
        command = cppdbg(),
        args = {"--port", "${port}"},
    }
}

dap.configurations.rust = {
    {
        name = "Choose a rust executable file to debug.",
        type = "cppdbg",
        request = "launch",
        program = function()
            local utils = require("utils")
            if utils.is_windows then
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\target\\debug\\", "file")
            elseif utils.is_unix_like then
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    }
}

dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
    }
}

dap.configurations.go = {
    -- current file
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    -- current workspace
    {
        type = "go",
        name = "Debug Package",
        request = "launch",
        program = "${workspaceFolder}",
    },
    -- current file test
    {
        type = "go",
        name = "Debug Test",
        request = "launch",
        mode = "test",
        program = "${file}",
    },
}
