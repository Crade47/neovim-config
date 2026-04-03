local gh = function(x)
	return "https://github.com/" .. x
end
local padd = vim.pack.add

padd({
	{ src = gh("nvim-lua/plenary.nvim") },
	{ src = gh("nvim-tree/nvim-web-devicons") },
	{ src = gh("nvim-treesitter/nvim-treesitter") },
	{ src = gh("stevearc/oil.nvim") },
	{ src = gh("ibhagwan/fzf-lua") },
	{ src = gh("folke/which-key.nvim") },
	{ src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("jpwol/thorn.nvim") },
	{ src = gh("folke/trouble.nvim") },
})
