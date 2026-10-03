local map = vim.keymap.set

-- Bindings for roslyn
map("n", "<leader>rt", "<cmd>Roslyn target<CR>", { desc = "Roslyn target selection" })
