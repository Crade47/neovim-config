vim.g.mapleader = " "
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keymap for copying text in the system clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")


--quickfix stuff

local function clear_quickfix_list()
  vim.fn.setqflist({})
end

api.nvim_create_user_command('ClearQuickfixList', clear_quickfix_list, {})

vim.api.nvim_set_keymap('n', '<leader>cf', ':ClearQuickfixList<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-f>o", "<cmd>copen<CR>zz")
vim.keymap.set("n", "<C-f>c", "<cmd>cclose<CR>zz")


--error
vim.keymap.set("n", "ge", ":lua vim.diagnostic.open_float({ focusable = true })<CR>")


vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- keymap fro moving between split panes
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true, desc = 'Next buffer' })

vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true, desc = 'Upper buffer' })

vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true, desc = 'Bottom buffer' })
--splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
--resize
vim.keymap.set("n", "<leader>,", "<C-w><")
vim.keymap.set("n", "<leader>.", "<C-w>>")


vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>b", "%");


vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set({ "n", "v" }, "<S-E>", "$")


vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
  "n",
  "<leader>ee",
  "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)


vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)
