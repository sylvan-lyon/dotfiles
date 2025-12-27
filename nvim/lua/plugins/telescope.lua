return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ff', desc = '[telescope] [f]ind [f]iles' },
        { '<leader>fg', desc = '[telescope] live [g]rep' },
        { '<leader>fb', desc = '[telescope] [b]uffers' },
        { '<leader>fh', desc = '[telescope] [h]elp tags' },
        { '<leader>fb', desc = '[telescope] [f]ind [b]uffers' }
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files,   { desc = '[telescope] [f]ind [f]iles' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep,    { desc = '[telescope] live [g]rep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers,      { desc = '[telescope] [b]uffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags,    { desc = '[telescope] [h]elp tags' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers,      { desc = '[telescope] [f]ind [b]uffers' })
    end
}
