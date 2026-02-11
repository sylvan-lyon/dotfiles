local set_keymaps = require("config.keymaps").set_keymaps

local dap_setup = function()
    local dap = require("dap")
    require("plugins.config.dap")

    set_keymaps({
        { "<leader>dR", function() dap.repl.toggle() end,       desc = "[d]ebug [R]EPL toggle" },

        -- during session
        { "<leader>di", function() dap.step_into() end,         desc = "[d]ebug step [i]nto" },
        { "<leader>do", function() dap.step_over() end,         desc = "[d]ebug step [o]ver" },
        { "<leader>dO", function() dap.step_out() end,          desc = "[d]ebug step [O]ut" },
        { "<leader>dc", function() dap.continue() end,          desc = "[d]ebug [c]ontinue" },
        { "<leader>dC", function() dap.run_to_cursor() end,     desc = "[d]ebug run to [C]ursor" },

        -- session manage
        { "<leader>ds", function() dap.continue() end,          desc = "[d]ebug [s]tart" },
        { "<leader>dq", function() dap.close() end,             desc = "[d]ebug [q]uit" },
        { "<leader>dQ", function() dap.terminate() end,         desc = "[d]ebug terminate" },
        { "<leader>dr", function() dap.restart() end,           desc = "[d]ebug [r]estart" },

        -- breakpoints
        { "<leader>db", function() dap.toggle_breakpoint() end, desc = "[d]ebug [b]reakpoint toggle" },
        { "<leader>dD", function() dap.clear_breakpoints() end, desc = "[d]ebug [D]elete all breakpoints" },
        {
            "<leader>dB",
            function()
                local input = vim.fn.input("Condition of breakpoint")
                dap.toggle_breakpoint(input)
            end,
            desc = "[d]ebug [B]reakpoint with condition"
        }
    })

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
    vim.fn.sign_define(
        "DapBreakpointCondition",
        {
            text = "",
            texthl = "DapBreakpointCondition",
            linehl = "DapBreakpointCondition",
            numhl = "DapBreakpointCondition"
        }
    )
end

local dapui_setup = function()
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    require("dapui").setup()

    set_keymaps({
        { "<leader>de", function() dapui.eval() end,   desc = "[d]ebug [e]valuate", mode = { "n", "x" } },
        { "<leader>du", function() dapui.toggle() end, desc = "[d]ebug [u]i" },
    })
end

return {
    "rcarriga/nvim-dap-ui",
    ft = { "lua", "rust", "go" },
    dependencies = {
        { "mfussenegger/nvim-dap", config = dap_setup },
        -- { "theHamsta/nvim-dap-virtual-text", config = function ()
        --     require("nvim-dap-virtual-text").setup({})
        -- end },
        "nvim-neotest/nvim-nio"
    },
    config = dapui_setup
}
