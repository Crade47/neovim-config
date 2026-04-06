vim.g.ale_linters_explicit = 1
vim.g.OmniSharp_server_use_net6 = 1
vim.g.ale_linters = {
	cs = { "OmniSharp" },
}
vim.g.ale_use_neovim_diagnostics_api = 1
vim.g.ale_sign_column_always = 1
vim.g.ale_open_list = 0

-- KEYBINDINGS
-- this should mirror the ones in the native lsp

local map = vim.keymap.set

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function(ev)
		local opts = { silent = true, buffer = ev.buf }

		map(
			"n",
			"gd",
			"<Plug>(omnisharp_go_to_definition)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Go to definition" })
		)
		map(
			"n",
			"gsu",
			"<Plug>(omnisharp_find_usages)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Find usages" })
		)
		map(
			"n",
			"gri",
			"<Plug>(omnisharp_find_implementations)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Find implementations" })
		)
		map(
			"n",
			"K",
			"<Plug>(omnisharp_preview_definition)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Preview definition" })
		)
		map(
			"n",
			"gst",
			"<Plug>(omnisharp_type_lookup)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Type lookup" })
		)
		map(
			"n",
			"<Leader>k",
			"<Plug>(omnisharp_documentation)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Documentation" })
		)
		map(
			"n",
			"gsfs",
			"<Plug>(omnisharp_find_symbol)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Find symbol" })
		)
		map(
			"n",
			"<Leader>osfx",
			"<Plug>(omnisharp_fix_usings)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Fix usings" })
		)
		map(
			"i",
			"<C-\\>",
			"<Plug>(omnisharp_signature_help)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Signature help" })
		)

		map(
			"n",
			"<Leader>osgcc",
			"<Plug>(omnisharp_global_code_check)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Global code check" })
		)

		map(
			"n",
			"<Leader>ca",
			"<Plug>(omnisharp_code_actions)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Code actions" })
		)

		map(
			"n",
			"<Leader>osf",
			"<Plug>(omnisharp_code_format)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Format code" })
		)
		map(
			"n",
			"<Leader>osnm",
			"<Plug>(omnisharp_rename)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Rename" })
		)

		map(
			"n",
			"<Leader>osre",
			"<Plug>(omnisharp_restart_server)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Restart server" })
		)
		map(
			"n",
			"<Leader>osst",
			"<Plug>(omnisharp_start_server)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Start server" })
		)
		map(
			"n",
			"<Leader>ossp",
			"<Plug>(omnisharp_stop_server)",
			vim.tbl_extend("force", opts, { desc = "OmniSharp: Stop server" })
		)
	end,
})
