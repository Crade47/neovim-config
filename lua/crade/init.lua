require("crade.set")
require("crade.remap")
require("crade.lazy_init")
vim.cmd([[
  highlight DiffAdd    ctermbg=22 guibg=#2a4f17
  highlight DiffDelete ctermbg=52 guibg=#4f1917
  highlight DiffChange ctermbg=23 guibg=#17474f
  highlight DiffText   ctermbg=24 guibg=#000000
]])
