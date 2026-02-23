-- return {
--     "tpope/vim-dispatch",
--     cmd = { "Dispatch", "Make", "Start" },
--     config = function()
--         -- Define dispatch commands for different filetypes
--         local dispatch_commands = {
--             javascript = "bb app test",
--             typescript = "bb app test",
--             java = "bb test",
--             python = "bb test",
--         }
--
--         -- Set up FileType autocmd for all defined types
--         vim.api.nvim_create_autocmd("FileType", {
--             pattern = vim.tbl_keys(dispatch_commands),
--             callback = function()
--                 local ft = vim.bo.filetype
--                 vim.b.dispatch = dispatch_commands[ft]
--             end
--         })
--
--         -- Keymaps
--         vim.keymap.set('n', '<leader>d', ':Dispatch<CR>', { silent = true })
--         vim.keymap.set('n', '<leader>m', ':Make<CR>', { silent = true })
--     end
-- }
return {
    -- vim-dispatch for async commands
    {
        "tpope/vim-dispatch",
        config = function()
            -- Set up brazil-build errorformat for Java

            vim.cmd([[
                " Clear existing errorformat first
                set errorformat=""

                " Java compiler (javac) error format - properly handle [javac] prefix
                set errorformat+=%*[\ ][javac]\ %f:%l:\ error:\ %m
                set errorformat+=%*[\ ][javac]\ %f:%l:\ warning:\ %m
                set errorformat+=%*[\ ][javac]\ %f:%l:%c:\ error:\ %m
                set errorformat+=%*[\ ][javac]\ %f:%l:%c:\ warning:\ %m

                " AspectJ compiler (iajc) error format
                set errorformat+=%*[\ ][iajc]\ %f:%l\ [error]\ %m
                set errorformat+=%*[\ ][iajc]\ %f:%l\ [warning]\ %m

                " Standard Java error formats (backup patterns)
                set errorformat+=%E[ERROR]\ %f:[%l\\,%c]\ %m
                set errorformat+=%E[ERROR]\ %f:[%l]\ %m
                set errorformat+=%W[WARNING]\ %f:[%l\\,%c]\ %m
                set errorformat+=%W[WARNING]\ %f:[%l]\ %m

                " Generic Java compiler formats (without prefix)
                set errorformat+=%E%f:%l:\ error:\ %m
                set errorformat+=%W%f:%l:\ warning:\ %m
                set errorformat+=%E%f:%l:%c:\ error:\ %m
                set errorformat+=%W%f:%l:%c:\ warning:\ %m

                " Ignore noise lines from build output
                set errorformat+=%-G%*[\ ][iajc]\ %\\s%\\+
                set errorformat+=%-G%*[\ ][echo]%\\s%\\+%m
                set errorformat+=%-GRunning\ build\ command%\\s%\\+%m
                set errorformat+=%-G%*[\ ][javac]\ Compiling%\\s%\\+%m
                set errorformat+=%-G%*[\ ][javac]\ Note:%\\s%\\+%m
                set errorformat+=%-Ghappytrails:%\\s%\\+%m
                set errorformat+=%-G***%\\s%\\+%m
                set errorformat+=%-GJAVA_HOME=%\\s%\\+%m
                set errorformat+=%-GBuildfile:%\\s%\\+%m
                set errorformat+=%-GTotal\ time:%\\s%\\+%m

                " Multi-line continuation patterns
                set errorformat+=%-Z%p^
                set errorformat+=%-C%.%#
            ]])

            -- Build command wrapper using Make instead of Dispatch
            vim.api.nvim_create_user_command('BB', function(opts)
                local args = opts.args or ""
                -- Set makeprg to brazil-build before running Make
                vim.opt.makeprg = "brazil-build"

                -- Use Make to populate quickfix list
                if args ~= "" then
                    vim.cmd("Make " .. args)
                else
                    vim.cmd("Make")
                end
            end, {
                nargs = "*",
                complete = function()
                    return { "release", "test", "clean", "compile" }
                end
            })

            -- Auto-open quickfix on errors
            vim.api.nvim_create_autocmd("QuickFixCmdPost", {
                pattern = { "[^l]*" },
                callback = function()
                    if vim.fn.getqflist({ size = 1 }).size > 0 then
                        vim.cmd('copen')
                        vim.cmd('wincmd p') -- Jump back to previous window
                    end
                end
            })

            -- Debug function to test errorformat parsing
            vim.api.nvim_create_user_command('TestErrorFormat', function()
                local test_lines = {
                    "     [javac] /path/to/MyFile.java:42: error: cannot find symbol",
                    "     [javac] /path/to/MyFile.java:42:8: error: cannot find symbol",
                    "     [iajc] /path/to/MyFile.java:42 [error] cannot find symbol",
                    "     [javac] Compiling 123 source files to /build/classes",
                }

                for _, line in ipairs(test_lines) do
                    local parsed = vim.fn.getmatches(line, vim.o.errorformat)
                    print("Line: " .. line)
                    print("Parsed: " .. vim.inspect(parsed))
                    print("---")
                end
            end, {})

            -- Helper command to show current errorformat
            vim.api.nvim_create_user_command('ShowErrorFormat', function()
                print("Current errorformat: " .. vim.o.errorformat)
            end, {})
        end,
        keys = {
            { "<C-d>b", "<cmd>BB<CR>",         desc = "Brazil Build" },
            { "<C-d>r", "<cmd>BB release<CR>", desc = "Brazil Build Release" },
            { "<C-d>t", "<cmd>BB test<CR>",    desc = "Brazil Build Test" },
        },
    },

    -- Enhanced quickfix window
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
            auto_enable = true,
            preview = {
                auto_preview = true,
                delay_syntax = 50,
            },
            func_map = {
                open = "<CR>",
                vsplit = "v",
                split = "s",
                tab = "t",
                filter = "f",
            },
        },
    },
}
