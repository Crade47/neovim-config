return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                layout_strategy = "horizontal",
                sorting_strategy = "descending",
                path_display = { "smart" },
                selection_caret = "> ",
                winblend = 10,
                mappings = {
                    i = {
                        ["<CR>"] = require('telescope.actions').select_default + require('telescope.actions').center
                    }
                }
            }
        })


        local function grep_selected()
            local builtin = require('telescope.builtin')
            local utils = require('crade.utils')
            local text = utils.Get_visual_selection();
            print("Selected text = " .. text)
            builtin.grep_string({ default_text = text })
        end
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<C-s>', builtin.git_status, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('v', '<leader>fg', grep_selected, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
        vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
    end
}
