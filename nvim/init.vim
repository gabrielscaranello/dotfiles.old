"" plugins
source ~/.config/nvim/plugins.vim

" keys mapped
map q :quit<CR>
map <C-s> :w<CR>
map <leader>n :NERDTreeFocus<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
map <space> za

" Set config
set nu!
set mouse=a 
set guicursor=""
set cursorline
set autoindent
set incsearch
set wildmenu
set laststatus=2
set confirm
set updatetime=300
set encoding=utf-8
set foldmethod=syntax
set foldlevel=99
colorscheme nord

" *************************************************************************
" Plugin config
" NerdTree
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
let NERDTreeQuitOnOpen=1

" MarkdownPreview
map <C-m> :MarkdownPreviewToggle<CR>

" Vim Airline
let g:airline_theme='nord'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop=0
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

