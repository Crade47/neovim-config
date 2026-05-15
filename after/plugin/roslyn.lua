require("roslyn").setup({
	filewatching = "roslyn",
	broad_search = false,
	lock_target = true,
})
local dotnet_root = [[C:\Program Files\dotnet]]
local vs_root = [[C:\Program Files\Microsoft Visual Studio\2022\Enterprise]]
local vs_msbuild = vs_root .. [[\MSBuild]]

vim.lsp.config("roslyn", {
	-- cmd_env = {
	-- 	Configuration = "Debug",
	-- 	Platform = "x64",
	-- 	DOTNET_ROOT = dotnet_root,
	-- 	Path = dotnet_root .. ";" .. (vim.env.Path or vim.env.PATH or ""),
    --     VCTargetsPath = [[C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Microsoft\VC\v170\]],
	-- },
	cmd_env = {
		Configuration = "Debug",
		Platform = "x64",

		DOTNET_ROOT = dotnet_root,
		Path = dotnet_root .. ";" .. (vim.env.Path or vim.env.PATH or ""),

		VSINSTALLDIR = vs_root .. [[\]],
		VisualStudioVersion = "17.0",
		MSBuildExtensionsPath = vs_msbuild,
		MSBuildExtensionsPath32 = vs_msbuild,
		MSBuildExtensionsPath64 = vs_msbuild,
		CustomAfterMicrosoftCommonTargets =
  		vs_msbuild .. [[\Current\Microsoft.Common.Targets\ImportAfter\Microsoft.QualityTools.Testing.Fakes.ImportAfter.targets]],

		FakesBinPath = vs_msbuild .. [[\Microsoft\VisualStudio\v17.0\Fakes]],
		FakesTargets = vs_msbuild .. [[\Microsoft\VisualStudio\v17.0\Fakes\Microsoft.QualityTools.Testing.Fakes.targets]],

		VCTargetsPath = [[C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Microsoft\VC\v170\]],
	},
	settings = {
		["navigation"] = {
			dotnet_navigate_to_decompiled_sources = true,
		},
		["csharp|background_analysis"] = {
			["dotnet_compiler_diagnostics_scope"] = "openFiles",
			["dotnet_analyzer_diagnostics_scope"] = "openFiles",
		},
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
		},
		["csharp|code_lens"] = {
			dotnet_enable_references_code_lens = true,
		},
		["csharp|completion"] = {
			dotnet_show_name_completion_suggestions = true,
			dotnet_show_completion_items_from_unimported_namespaces = true,
			dotnet_provide_regex_completions = true,
		},
		["csharp|symbol_search"] = {
			dotnet_search_reference_assemblies = true,
		},
	},
})
