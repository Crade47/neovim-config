local root_markers1 = {
  '.emmyrc.json',
  '.luarc.json',
  '.luarc.jsonc',
}
local root_markers2 = {
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
}

local lua_ls_cmd = vim.fn.exepath('lua-language-server')

if lua_ls_cmd == '' and vim.fn.has('win32') == 1 and vim.env.LOCALAPPDATA then
  local winget_cmd = vim.fs.joinpath(
    vim.env.LOCALAPPDATA,
    'Microsoft',
    'WinGet',
    'Packages',
    'LuaLS.lua-language-server_Microsoft.Winget.Source_8wekyb3d8bbwe',
    'bin',
    'lua-language-server.exe'
  )

  if vim.fn.filereadable(winget_cmd) == 1 then
    lua_ls_cmd = winget_cmd
  end
end

---@type vim.lsp.ClientConfig
return {
  cmd = { lua_ls_cmd },
  filetypes = { 'lua' },
  root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers1, root_markers2, { '.git' } }
    or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { '.git' }),
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
  on_attach = function(client, bufnr)
        vim.cmd[[set completeopt+=menuone,noselect,popup]]
        vim.lsp.completion.enable(true, client.id, bufnr, {
          autotrigger = true,
          convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
          end,
        })
      end,
}
