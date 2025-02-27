return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "gopls",
                "clangd",
                "pyright",
                "marksman",
                "jdtls"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup {
                        capabilities = capabilities,
                        before_init = function(_, config)
                            local util = require("lspconfig/util")
                            local path = util.path
                            local default_venv_path = path.join(vim.env.HOME, "virtual_envs", ".venv", "bin", "python")
                            config.settings.python.pythonPath = default_venv_path
                        end
                    }
                end,
                    -- local cmd = {
                    --     jdtls_path,
                    --     "-javaagent:" .. lombok_jar,
                    --     "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    --     "-Dosgi.bundles.defaultStartLevel=4",
                    --     "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    --     "-Dlog.protocol=true",
                    --     "-Dlog.level=ALL",
                    --     "-Xms1g",
                    --     "--add-modules=ALL-SYSTEM",
                    --     "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    --     "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    --     "-jar", "/Users/devansh/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher.cocoa.macosx.aarch64_1.2.1100.v20240722-2106.jar",
                    --     "-configuration", "/Users/devansh/.local/share/nvim/mason/packages/jdtls/config_ss_mac_arm",
                    --     "-data", "/Users/devansh/jdtls_workspace",
                    -- }
                -- ["jdtls"] = function()
                --     local jdtls = require("lspconfig")
                --     jdtls.jdtls.setup {
                --         capabilities = capabilities,
                --         cmd = { "jdtls",
                --         }, -- Ensure jdtls is in your PATH
                --         root_dir = require("lspconfig.util").root_pattern("pom.xml", ".git"),
                --     }
                -- end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                -- ['<C-m>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
