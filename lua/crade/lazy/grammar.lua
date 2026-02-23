return {
    'PatrBal/vim-textidote',
    config = function()
        vim.keymap.set("n", "<leader>gm", ":TeXtidoteToggle<CR>")
        vim.g.textidote_jar='~/textidote.jar'
    end
}
