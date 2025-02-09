return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim", -- Manage null-ls sources via Mason
  },

  config = function()
    local null_ls = require("null-ls")
    require("mason").setup()
    require("mason-null-ls").setup({
      ensure_installed = { "prettier", "eslint_d", "ruff" }, -- Add formatters/linters to auto-install
      automatic_installation = true,
    })

    null_ls.setup({
      sources = {
        -- Add formatters/linters here
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "typescript", "json", "html", "css", "markdown", "cpp" },
        }),
        null_ls.builtins.diagnostics.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file(".eslintrc.json") -- Check for .eslintrc.json in the root
          end,
        }),
        null_ls.builtins.diagnostics.ruff,
      },
    })

    -- Keymap for formatting
    vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
  end,
}

