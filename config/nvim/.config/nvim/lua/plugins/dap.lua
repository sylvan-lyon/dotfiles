local function set_keymaps()
    local dap, dapui = require("dap"), require("dapui")
    require("config.keymaps").set_keymaps({
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

        -- dapui
        { "<leader>de", function() dapui.eval() end,            desc = "[d]ebug [e]valuate",              mode = { "n", "x" } },
        { "<leader>du", function() dapui.toggle() end,          desc = "[d]ebug [u]i" },
        {
            "<leader>dB",
            function()
                local input = vim.fn.input("Condition of breakpoint")
                dap.toggle_breakpoint(input)
            end,
            desc = "[d]ebug [B]reakpoint with condition"
        }
    })
end

local function sign_define()
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
    vim.fn.sign_define(
        "DapBreakpointCondition",
        {
            text = "",
            texthl = "DapBreakpointCondition",
            linehl = "DapBreakpointCondition",
            numhl = "DapBreakpointCondition"
        })
end

return {
    "rcarriga/nvim-dap-ui",
    keys = {
        { "<leader>dR", desc = "[d]ebug [R]EPL toggle" },
        { "<leader>di", desc = "[d]ebug step [i]nto" },
        { "<leader>do", desc = "[d]ebug step [o]ver" },
        { "<leader>dO", desc = "[d]ebug step [O]ut" },
        { "<leader>dc", desc = "[d]ebug [c]ontinue" },
        { "<leader>dC", desc = "[d]ebug run to [C]ursor" },
        { "<leader>ds", desc = "[d]ebug [s]tart" },
        { "<leader>dq", desc = "[d]ebug [q]uit" },
        { "<leader>dQ", desc = "[d]ebug terminate" },
        { "<leader>dr", desc = "[d]ebug [r]estart" },
        { "<leader>db", desc = "[d]ebug [b]reakpoint toggle" },
        { "<leader>dD", desc = "[d]ebug [D]elete all breakpoints" },
        { "<leader>dB", desc = "[d]ebug [B]reakpoint with condition" },
        { "<leader>de", desc = "[d]ebug [e]valuate",                 mode = { "n", "x" } },
        { "<leader>du", desc = "[d]ebug [u]i" },
    },
    dependencies = {
        "mfussenegger/nvim-dap",
        -- { "theHamsta/nvim-dap-virtual-text", config = function ()
        --     require("nvim-dap-virtual-text").setup({})
        -- end },
        "mason-org/mason.nvim",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        require("plugins.config.dap")


        local open_dap = function() dapui.open() end
        local close_dap = function() dapui.close() end

        dap.listeners.before.attach.dapui_config = open_dap
        dap.listeners.before.launch.dapui_config = open_dap
        -- dap.listeners.before.event_terminated.dapui_config = close_dap
        -- dap.listeners.before.event_exited.dapui_config = close_dap

        set_keymaps()
        sign_define()

        require("dapui").setup()
    end
}
