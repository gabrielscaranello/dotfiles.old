call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'gabrielscaranello/ctrlp.vim'

call plug#end()
