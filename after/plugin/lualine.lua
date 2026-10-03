local state = {
	show_path = true,
}
local config = {
	icons = {
		path_hidden = "", -- opened directory icon
	},
}

local function toggle_path()
	state.show_path = not state.show_path

	-- Draw the statusline manually
	vim.cmd("redrawstatus")
end

local function filepath()
	-- Modify the given file path with the given modifiers
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")

	if state.show_path then
		local fullPath = vim.fn.has("macunix") == 1 and string.format("%%<%s/", fpath) or string.format("%%<%s", fpath)
		return fullPath
	end

	return config.icons.path_hidden .. "/"
	-- `%%` -> `%`.
	-- `%s` -> value of `fpath`.
	-- The result is `%<fpath/`.
	-- `%<` tells where to truncate when there is not enough space.
end

local function roslyn_solution()
	local sln = vim.g.roslyn_nvim_selected_solution
	if not sln or sln == "" then
		return ""
	end
	return vim.fn.fnamemodify(sln, ":t")
end

vim.keymap.set("n", "<leader>gsp", function()
	toggle_path()
end, { desc = "Toggle statusline path" })

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "material",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { filepath, "filename" },
		lualine_b = { "branch", "diagnostics" },
		lualine_c = { "" },
		lualine_x = { "filetype" },
		lualine_y = { "lsp_status", roslyn_solution },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
