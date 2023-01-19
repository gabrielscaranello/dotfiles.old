vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "syntax"
vim.opt.guicursor = ""
vim.opt.hidden = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.mouse = "a"
vim.opt.nu = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.shortmess = "c"
vim.opt.showmode = false
vim.opt.signcolumn = "number"
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 200
vim.opt.wildmenu = true
vim.opt.timeoutlen = 300

vim.cmd("filetype on")
vim.cmd("filetype indent on")
vim.cmd("filetype plugin on")
vim.cmd("filetype plugin indent on")

vim.cmd([[
autocmd!
if (empty($TMUX))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  if (has("termguicolors"))
    set termguicolors
  endif
endif
]])

local colorscheme = "nord"
colorscheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not colorscheme_ok then
    vim.cmd([["colorscheme habamax"]])
end
