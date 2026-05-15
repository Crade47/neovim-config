local treesitter = require("nvim-treesitter")

local parsers = { "c", "lua", "rust", "c_sharp", "go", "gomod", "gowork", "gosum", "gotmpl" }
local filetypes = { "c", "lua", "rust", "cs", "go", "gomod", "gowork", "gosum", "gotmpl" }

vim.treesitter.language.register("c_sharp", "cs")

if vim.env.CC and vim.fn.executable(vim.env.CC) == 0 and vim.fn.executable("gcc") == 1 then
	vim.env.CC = "gcc"
end

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my.treesitter", {}),
	pattern = filetypes,
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
