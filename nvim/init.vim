" plugins
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/coc.nvim.vim

" keys mapped
map q :quit<CR>
map <C-s> :w<CR>
map <leader>n :NERDTreeFocus<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
map <space> za

:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d


" Set config
syntax on
set nu!
set mouse=a 
set guicursor=""
set cursorline
set autoindent
set smartindent
set incsearch
set wildmenu
set hidden
set smarttab
set laststatus=2
set cmdheight=2
set signcolumn=number
set confirm
set updatetime=200
set encoding=utf-8
set clipboard+=unnamedplus
set foldmethod=syntax
set scrolloff=8
set signcolumn=yes
set foldlevel=99
set tabstop=2 softtabstop=2 expandtab shiftwidth=2
set termguicolors
set splitbelow
set splitright
filetype on
filetype plugin on
filetype indent on
colorscheme nord
set spell spelllang=pt_br

" *************************************************************************
" Plugin config
" NerdTree
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

" Nerd Commenter
map cc <Plug>NERDCommenterInvert

" MarkdownPreview
map <C-m> :MarkdownPreviewToggle<CR>
let g:mkdp_auto_close = 0


" Vim Airline
let g:airline_theme='nord'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop=0
let g:airline#extensions#hunks#enabled = 0
nnoremap <C-d> :bn<cr>
nnoremap <C-a> :bp<cr>
nnoremap <C-w> :bp\|bd #<cr>

" Nord theme
let g:nord_bold = 1
let g:nord_uniform_diff_background = 1

" CTRLP
let g:ctrlp_custom_ignore = '\v[\/]\.(swp|zip)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_show_hidden = 1 
let g:ctrlp_match_window = 'top,order:btt,min:1,max:5,results:10'
let g:ctrlp_customization#CtrlPPrtCursor=""

" EmmitVim
let g:user_emmet_leader_key='<C-l>'

" Indent line
let g:indentLine_enabled = 1
let g:indentLine_char = '¦'
let g:indentLine_noConcealCursor='nc'
let g:indentLine_defaultGroup = 'SpecialKey'

" json syntax
let g:vim_json_syntax_conceal = 0
let g:vim_json_syntax_conceal = 0

" Copy file name 
nmap <leader>cp :CopyRelativePath<CR>
nmap <leader>cl :CopyRelativePathAndLine<CR>
nmap <leader>cP :CopyAbsolutePath<CR>
nmap <leader>cf :CopyFileName<CR>
nmap <leader>cd :CopyDirectoryPath<CR>

