return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("snacks").setup(require("plugins.config.snacks"))

        local pick = Snacks.picker

        local toggle_dim = function()
            if Snacks.dim.enabled then
                Snacks.dim.disable()
            else
                Snacks.dim.enable()
            end
        end

        local pick_config_files = function()
            Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end

        local select_layout = { layout = "select" }

        require("utils").keyset({
            -- view
            { "<leader>vi", icon = " ", function() Snacks.image.hover() end, desc = "[v]iew [i]mage", },
            -- toggles                ,
            { "<leader>td", icon = " ", function() toggle_dim() end, desc = "[t]oggle [d]im", },
            { "<leader>tn", icon = " ", function() Snacks.notifier.hide() end, desc = "[t]oggle [n]otices", },
            { "<leader>tt", icon = " ", function() Snacks.terminal.toggle() end, desc = "[t]oggle [t]terminal", },
            { "<leader>tz", icon = " ", function() Snacks.zen.zoom() end, desc = "[t]oggle [z]oom", },

            -- finds
            { "<leader>fa", icon = " ", function() pick.autocmds() end, desc = "[f]ind [a]utocmds", },
            { "<leader>fb", icon = "󱔗 ", function() pick.buffers() end, desc = "[f]ind [b]uffers", },
            { "<leader>fB", icon = "󰈙 ", function() pick.lines() end, desc = "[f]ind [B]uffer lines", },
            { "<leader>fc", icon = " ", function() pick.command_history(select_layout) end, desc = "[f]ind [c]ommand history", },
            { "<leader>fC", icon = " ", function() pick_config_files() end, desc = "[f]ind [C]onfig files", },
            { "<leader>fd", icon = " ", function() pick.diagnostics() end, desc = "[f]ind [d]iagnostics", },
            { "<leader>fD", icon = " ", function() pick.diagnostics_buffer() end, desc = "[f]ind [D]iagnostics(buf)", },
            { "<leader>ff", icon = " ", function() pick.files() end, desc = "[f]ind [f]iles", },
            { "<leader>fF", icon = " ", function() pick.files({ hidden = true }) end, desc = "[f]ind [f]iles (hidden)", },
            { "<leader>fg", icon = "󰈞 ", function() pick.grep() end, desc = "[f]ind [g]reps", },
            { "<leader>fh", icon = "󰋖 ", function() pick.help() end, desc = "[f]ind [h]elp", },
            { "<leader>fH", icon = " ", function() pick.highlights() end, desc = "[f]ind [H]ighlights", },
            { "<leader>fi", icon = " ", function() pick.icons(select_layout) end, desc = "[f]ind [i]cons", },
            { "<leader>fj", icon = " ", function() pick.jumps() end, desc = "[f]ind [j]umps", },
            { "<leader>fk", icon = " ", function() pick.keymaps(select_layout) end, desc = "[f]ind [k]eymaps", },
            { "<leader>fl", icon = " ", function() pick.loclist() end, desc = "[f]ind [l]ocation list", },
            { "<leader>fn", icon = " ", function() pick.notifications() end, desc = "[f]ind [n]otifications", },
            { "<leader>fp", icon = " ", function() pick.projects() end, desc = "[f]ind [p]rojects", },
            { "<leader>fq", icon = "󰁨 ", function() pick.qflist() end, desc = "[f]ind [q]uickfix", },
            { "<leader>fr", icon = " ", function() pick.registers() end, desc = "[f]ind [r]egisters", },
            { "<leader>fR", icon = nil, function() pick.resume() end, desc = "[f]ind [R]esume", },
            { "<leader>fs", icon = " ", function() pick.search_history(select_layout) end, desc = "[f]ind [s]earch history", },
            { "<leader>fu", icon = " ", function() pick.undo() end, desc = "[f]ind [u]ndo history", },
        })
    end
}
