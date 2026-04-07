local map = vim.keymap.set
-- Leader
vim.g.mapleader = " "

-- Disable netrw (for nvim-tree or similar)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- =========================
-- General Keymaps
-- =========================
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "E", "$", { desc = "Start of sentence" })
map("n", "0", "^", { desc = "Start of line" })
map("n", "$", "0", { desc = "Start of line" })
map("n", "Q", "<nop>")
map("x", "/", "<Esc>/\\%V")

-- Select everythin
map("n", "==", "gg<S-v>GE", { desc = "Start of sentence" })

-- Clipboard
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", "[[_d]]", { desc = "Delete without yank" })

-- Line end shortcut
map({ "n", "v" }, "<S-E>", "$", { desc = "Go to end of line" })

-- Join lines (keep cursor position)
map("n", "J", "mzJ`z")

-- Center cursor while scrolling
map("n", "<C-d>", "<C-d>zz")

-- Make file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Search and replace word under cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- =========================
-- Window Management
-- =========================

-- Navigation between splits
map("n", "<leader>h", "<C-w>h", { desc = "Move left" })
map("n", "<leader>j", "<C-w>j", { desc = "Move down" })
map("n", "<leader>k", "<C-w>k", { desc = "Move up" })
map("n", "<leader>l", "<C-w>l", { desc = "Move right" })

-- Splits
map("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>z", "<C-w>s", { desc = "Horizontal split" })

-- Resize
map("n", "<leader>,", "<C-w><", { desc = "Resize left" })
map("n", "<leader>.", "<C-w>>", { desc = "Resize right" })
map("n", "<leader>=", "<C-w>+", { desc = "Resize up" })
map("n", "<leader>-", "<C-w>-", { desc = "Resize right" })

-- =========================
-- Quickfix
-- =========================

local function clear_quickfix_list()
	vim.fn.setqflist({})
end

vim.api.nvim_create_user_command("ClearQuickfixList", clear_quickfix_list, {})

map("n", "<C-f>h", ":ClearQuickfixList<CR>", { desc = "Clear quickfix" })
map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
map("n", "<C-f>o", "<cmd>copen<CR>", { desc = "Open quickfix" })
map("n", "<C-f>c", "<cmd>cclose<CR>", { desc = "Close quickfix" })

-- =========================
-- LSP
-- =========================

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>cr", vim.lsp.buf.references, { desc = "References" })

-- Diagnostics
map("n", "ge", function()
	vim.diagnostic.open_float({ focusable = true })
end, { desc = "Show diagnostic" })

-- =========================
-- Misc
-- =========================

-- Match bracket
map("n", "<leader>b", "%", { desc = "Jump to matching bracket" })

-- Commenting (add comment above/below current line)
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- auto close pairs
map("i", "'", "''<left>") -- commented out - smart!
map("i", "`", "``<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "<", "<><left>")

-- Close all fold except the current one.
map("n", "zv", "zMzvzz", {
	desc = "Close all folds except the current one",
})
