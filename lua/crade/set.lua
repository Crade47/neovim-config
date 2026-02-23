OSHome = nil
if vim.fn.has('macunix') then
   OSHome = os.getenv("HOME")
else
    OSHome = os.getenv("USERPROFILE")
end

vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = OSHome .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true


vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
