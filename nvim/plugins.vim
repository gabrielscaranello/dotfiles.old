call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'gabrielscaranello/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'gabrielelana/vim-markdown'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'elzr/vim-json'
Plug 'AdamWhittingham/vim-copy-filename'
Plug 'lilydjwg/colorizer'

call plug#end()
