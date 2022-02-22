local opt = vim.opt
local cmd = vim.cmd

opt.autoindent = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.confirm = true
opt.cursorline = true
opt.encoding = "utf-8"
opt.expandtab = true
opt.foldlevel = 99
opt.foldmethod = "syntax"
opt.guicursor = ""
opt.hidden = true
opt.incsearch = true
opt.laststatus = 2
opt.mouse = "a"
opt.nu = true
opt.scrolloff = 10
opt.shiftwidth = 2
opt.shortmess = "c"
opt.showmode = false
opt.signcolumn = "number"
opt.signcolumn = "yes"
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 200
opt.wildmenu = true
opt.timeoutlen = 150

cmd("filetype on")
cmd("filetype indent on")
cmd("filetype plugin on")
cmd("filetype plugin indent on")
cmd("colorscheme onedark")

cmd([[
autocmd!
if (empty($TMUX))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  if (has("termguicolors"))
    set termguicolors
  endif
endif
]])
