local lsps = { "lua_ls", "pyright", "OmniSharp" }
local map = vim.keymap

-- REFERENCE
-- - "gra" (Normal and Visual mode) is mapped to |vim.lsp.buf.code_action()|
-- - "gri" is mapped to |vim.lsp.buf.implementation()|
-- - "grn" is mapped to |vim.lsp.buf.rename()|
-- - "grr" is mapped to |vim.lsp.buf.references()|
-- - "grt" is mapped to |vim.lsp.buf.type_definition()|
-- - "grx" is mapped to |vim.lsp.codelens.run()|
-- - "gO" is mapped to |vim.lsp.buf.document_symbol()

local default_keymaps = {
	{ keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code Actions" },
	{ keys = "<leader>cr", func = vim.lsp.buf.rename, desc = "Code Rename" },
	{ keys = "K", func = vim.lsp.buf.hover, desc = "Hover", has = "hoverProvider" },
	{ keys = "gd", func = vim.lsp.buf.definition, desc = "Goto Definition", has = "definitionProvider" },
	{ keys = "gri", func = vim.lsp.buf.implementation, desc = "Goto Implementation", has = "implementation" },
	{ keys = "grx", func = vim.lsp.codelens.run, desc = "Run codelens" },
}

vim.filetype.add({
	extension = {
		razor = "razor",
		cshtml = "razor",
	},
})

-- COMPLETION STUFF
local completion = "blink"

-- Enable completion on lsp attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		local completion_autotrigger = client.name ~= "roslyn_ls"

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if completion == "native" and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = completion_autotrigger })
		end

		if client:supports_method("textDocument/inlayHints") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end

		for _, km in ipairs(default_keymaps) do
			-- Only bind if there's no `has` requirement, or the server supports it
			if not km.has or client.server_capabilities[km.has] then
				vim.keymap.set(
					km.mode or "n",
					km.keys,
					km.func,
					{ buffer = ev.buf, desc = "LSP: " .. km.desc, nowait = km.nowait }
				)
			end
		end
	end,
})

for _, lsp in pairs(lsps) do
	vim.lsp.enable(lsp)
end
