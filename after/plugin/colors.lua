-- vim.cmd([[colorscheme thorn]])
--
require("gruvbox").setup({
	overrides = {
		FoldColumn = { bg = "#282828" },
	},
})
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
