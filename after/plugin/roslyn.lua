---@diagnostic disable-next-line: undefined-field
require("roslyn").setup({
    filewatching = "roslyn",
    broad_search = false,
    lock_target = true,
})
local is_win = vim.fn.has("win32") == 1
local dotnet_root = [[C:\Program Files\dotnet]]
local vs_root = [[C:\Program Files\Microsoft Visual Studio\2022\Enterprise]]
local vs_msbuild = vs_root .. [[\MSBuild]]
local roslynDll =
    [[C:\tools\bin\Microsoft.CodeAnalysis.LanguageServer.win-x64.5.4.0-2.26179.14\content\LanguageServer\win-x64\Microsoft.CodeAnalysis.LanguageServer.dll]]

-- cmd/cmd_env are Windows-only; elsewhere roslyn.nvim's default cmd (Mason/PATH) is used.
vim.lsp.config("roslyn", {
    cmd = is_win and {
        "dotnet",
        roslynDll,
        "--logLevel", -- this property is required by the server
        "Information",
        "--extensionLogDirectory", -- this property is required by the server
        vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls/logs"),
        "--stdio",
    } or nil,
    -- cmd_env = {
    -- 	Configuration = "Debug",
    -- 	Platform = "x64",
    -- 	DOTNET_ROOT = dotnet_root,
    -- 	Path = dotnet_root .. ";" .. (vim.env.Path or vim.env.PATH or ""),
    --     VCTargetsPath = [[C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Microsoft\VC\v170\]],
    -- },
    cmd_env = is_win and {
        Configuration = "Debug",
        Platform = "x64",

        DOTNET_ROOT = dotnet_root,
        Path = dotnet_root .. ";" .. (vim.env.Path or vim.env.PATH or ""),

        VSINSTALLDIR = vs_root .. [[\]],
        VisualStudioVersion = "17.0",
        MSBuildExtensionsPath = vs_msbuild,
        MSBuildExtensionsPath32 = vs_msbuild,
        MSBuildExtensionsPath64 = vs_msbuild,
        CustomAfterMicrosoftCommonTargets = vs_msbuild
            .. [[\Current\Microsoft.Common.Targets\ImportAfter\Microsoft.QualityTools.Testing.Fakes.ImportAfter.targets]],

        FakesBinPath = vs_msbuild .. [[\Microsoft\VisualStudio\v17.0\Fakes]],
        FakesTargets = vs_msbuild
            .. [[\Microsoft\VisualStudio\v17.0\Fakes\Microsoft.QualityTools.Testing.Fakes.targets]],

        VCTargetsPath = [[C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Microsoft\VC\v170\]],
    } or nil,
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
