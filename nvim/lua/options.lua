local options = {
	encoding = "utf-8",
	fileencoding = "utf-8",
	title = true,
	backup = false,
  -- clipboard = {"unnamed","unnamedplus"},
	cmdheight = 2,
	completeopt = {"menuone", "noselect"},
	conceallevel = 0,
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 300,
	writebackup = false,
	backupskip = {"/tmp*","/private/tmp"},
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	cursorline = true,
	number = true,
	relativenumber = false,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = false,
	winblend = 0,
	wildoptions = "pum",
	pumblend = 5,
	background = "dark",
	scrolloff = 8,
}

vim.opt.shortmess:append("c")

for k,v in pairs(options) do
	vim.opt[k] = v
end

-- vim.cmd([[set clipboard&]])
-- vim.cmd([[set clipboard^=unnamedplus]])
vim.cmd([[if system('uname -a | grep Microsoft') != ""
  let g:clipboard = {
        \   'name': 'myClipboard',
        \   'copy': {
        \      '+': 'win32yank.exe -i',
        \      '*': 'win32yank.exe -i',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o',
        \      '*': 'win32yank.exe -o',
        \   },
        \   'cache_enabled': 1,
        \ }
endif]])

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])
