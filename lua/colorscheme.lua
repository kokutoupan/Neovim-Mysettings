vim.cmd [[
try
  colorscheme nightfox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

vim.cmd('hi Normal ctermbg=none guibg=none')
vim.o.winhighlight = "Normal:Normal,NormalNC:none"
