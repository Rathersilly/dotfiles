--vim.cmd "colorscheme jellybeans"
-- vim.cmd "colorscheme eldar"

vim.cmd [[
try
  "colorscheme jellybeans
  colorscheme bamboo
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
