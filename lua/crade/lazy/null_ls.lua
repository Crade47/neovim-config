return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    require("mason").setup()
    require("mason-null-ls").setup({
      ensure_installed = { "prettier", "eslint_d", "ruff" },
      automatic_installation = true,
    })

    -- Check which builtins are available
    local available_sources = {
      -- Add formatters/linters here
      null_ls.builtins.formatting.prettier.with({
        filetypes = { "javascript", "typescript", "json", "html", "css", "markdown", "cpp" },
      }),
    }

    -- Conditionally add ESLint if available
    if null_ls.builtins.diagnostics.eslint_d then
      table.insert(available_sources, null_ls.builtins.diagnostics.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file(".eslintrc.json")
        end,
      }))
    elseif null_ls.builtins.diagnostics.eslint then
      table.insert(available_sources, null_ls.builtins.diagnostics.eslint.with({
        condition = function(utils)
          return utils.root_has_file(".eslintrc.json")
        end,
      }))
    end

    -- Conditionally add Ruff if available
    if null_ls.builtins.diagnostics.ruff then
      table.insert(available_sources, null_ls.builtins.diagnostics.ruff)
    end

    null_ls.setup({
      sources = available_sources
    })
    -- Keymap for formatting
    vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
  end,
}
