return {
    'Wansmer/treesj',
    keys = { '<leader>tm', '<leader>ti', '<leader>ts' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
        local treesj = require('treesj')
        treesj.setup({})
        vim.keymap.set('n', '<leader>tm', treesj.toggle)
        vim.keymap.set('n', '<leader>tM', function()
            treesj.toggle({ split = { recursive = true } })
        end)
    end,
}
