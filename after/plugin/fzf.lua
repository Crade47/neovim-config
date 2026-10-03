local fzf = require("fzf-lua")
local mp = vim.keymap.set

fzf.setup({
	keymap = {
		fzf = {
			-- use cltr-q to select all items and convert to quickfix list
			["ctrl-q"] = "select-all+accept",
		},
	},
	winopts = {
		on_create = function()
			-- called once upon creation of the fzf main window
			-- can be used to add custom fzf-lua mappings, e.g:
			vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
			vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
		end,
	},
})

mp("n", "<leader>pf", "<cmd>FzfLua files<CR>", { desc = "Fzf files" })
mp("v", "<leader>fa", "<cmd>FzfLua grep_cword<CR>", { desc = "grep cword" })
mp("n", "<leader>fg", "<cmd>FzfLua live_grep_native<CR>", { desc = "grep" })
mp("n", "<leader>pgf", "<cmd>FzfLua live_grep_resume<CR>", { desc = "grep resume" })
mp("n", "<leader>fc", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "grep cur buffer" })

-- LSP
mp("n", "<leader>fd", "<cmd>FzfLua lsp_workspace_diagnostics<CR>", { desc = "LSP workspace_diagnostics" })
mp("n", "<leader>gi", "<cmd>FzfLua lsp_implementations<CR>", { desc = "LSP implementations" })
mp("n", "<leader>gi", "<cmd>FzfLua lsp_references<CR>", { desc = "LSP references" })

-- MISC
mp("n", "<leader>u", "<cmd>FzfLua undotree<CR>", { desc = "grep" })
