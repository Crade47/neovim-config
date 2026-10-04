local treesitter = require("nvim-treesitter")

local parsers = { "c", "lua", "rust", "c_sharp", "go", "gomod", "gowork", "gosum", "gotmpl", "yaml", "hcl" }
local filetypes = { "c", "lua", "rust", "cs", "go", "gomod", "gowork", "gosum", "gotmpl", "yaml", "hcl", "terraform", "terraform-vars", "opentofu", "opentofu-vars" }

vim.treesitter.language.register("c_sharp", "cs")
vim.treesitter.language.register("hcl", { "terraform", "terraform-vars", "opentofu", "opentofu-vars" })

if vim.fn.has("win32") == 1 and vim.fn.executable("gcc") == 1 then
    vim.env.CC = "gcc"
end

treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("my.treesitter", {}),
    pattern = filetypes,
    callback = function(ev)
        local name = vim.api.nvim_buf_get_name(ev.buf)
        if name:match("%.yaml%.tftpl$") or name:match("%.yml%.tftpl$") then
            vim.treesitter.stop(ev.buf)
            vim.bo[ev.buf].syntax = "yaml"
            return
        end
        pcall(vim.treesitter.start)
    end,
})
