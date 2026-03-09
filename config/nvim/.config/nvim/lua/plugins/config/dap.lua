local dap = require("dap")

dap.providers.configs[".dap.lua"] = function()
    local cwd = vim.fn.getcwd()
    local utils = require("utils")
    local dap_file

    if utils.is_windows then
        dap_file = cwd .. "\\.dap.lua"
    elseif utils.is_unix_like then
        dap_file = cwd .. "/.dap.lua"
    else
        vim.notify("Unkown system for .dap.lua", vim.log.levels.ERROR, { title = "NVIM DAP" })
    end

    return dofile(dap_file)
end

local lldb = function()
    local utils = require("utils")
    if utils.is_windows then
        return "codelldb.cmd"
    elseif utils.is_unix_like then
        return "codelldb"
    else
        vim.notify(("Unkown OS to cppdbg: %s"):format(utils.sysname))
    end
end

dap.adapters.lldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = lldb(),
        args = { "--port", "${port}" },
    }
}

dap.configurations.rust = {
    {
        name = "Choose a rust executable file to debug.",
        type = "lldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        program = function()
            local utils = require("utils")
            local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~:.")
            if utils.is_windows then
                return vim.fn.input("Path to executable: ", cwd .. "\\target\\debug\\", "file")
            elseif utils.is_unix_like then
                return vim.fn.input("Path to executable: ", cwd .. "/target/debug/", "file")
            end
        end,
        args = function()
            local args = vim.fn.input("Args (enter to ommit): ")
            vim.print(args)
            vim.print(require("utils").shell_split(args))
            return require("utils").shell_split(args)
        end,
    },
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
