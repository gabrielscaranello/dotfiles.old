if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'chiedo/vim-case-convert'
Plug 'gabrielelana/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'lilydjwg/colorizer'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'wakatime/vim-wakatime'

if has("nvim")
  Plug 'BurntSushi/ripgrep'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'akinsho/bufferline.nvim'
  Plug 'editorconfig/editorconfig-vim' 
  Plug 'glepnir/dashboard-nvim'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'max397574/better-escape.nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'terrortylor/nvim-comment',
  Plug 'windwp/nvim-autopairs'
  Plug 'windwp/nvim-ts-autotag'
endif

call plug#end()

