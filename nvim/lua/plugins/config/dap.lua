local dap = require("dap")
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "D:\\dev\\nvim-data\\mason\\bin\\OpenDebugAD7.cmd",
    options = {
        detached = false
    }
}

dap.configurations.rust = {
    {
        name = "Launch rust",
        type = "cppdbg",
        request = "launch",
        program = function ()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    }
}
