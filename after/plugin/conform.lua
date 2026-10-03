require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		cs = { "csharpier" },
	},
	formatters = {
		stylua = {
			prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
		},
		biome = { require_cwd = true },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = function(bufnr)
		local ignore_filetypes = { "cs" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end

		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname:match("/node_modules/") then
			return
		end

		if vim.bo[bufnr].filetype == "lua" then
			-- Keep Lua formatting deterministic via StyLua and avoid LSP fallback style drift.
			return { timeout_ms = 500, lsp_format = "never" }
		end

		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true }, function(err, did_edit)
		if not err and did_edit then
			vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
		end
	end)
end, { desc = "Format buffer" })
