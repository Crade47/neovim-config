-- return {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     config = function()
--         local color = 'rose-pine-moon'
--         require("rose-pine").setup({
--             disable_background = true,
--             disable_float_background = true
--
--         })
--
--         vim.cmd.colorscheme(color)
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     end
-- }
return {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    end,
}
