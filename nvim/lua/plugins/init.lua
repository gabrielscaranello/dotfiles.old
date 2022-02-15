local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add plugins
packer.startup { 
  function(use)
    local configs = require('plugins.configs')

    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    
    use {
      'antoinemadec/FixCursorHold.nvim',
      event = 'BufRead',
      config = configs['fix-cursor-hold'],
    }
    
    use {
      'nathom/filetype.nvim',
      config = configs['filetype']
    }

    use {
      'kyazdani42/nvim-web-devicons',
      config = configs['icons']
    }

    use {
      'nvim-lualine/lualine.nvim',
      config = configs['lualine']
    }

    use {
      'kyazdani42/nvim-tree.lua',
      config = configs['nvim-tree'],
      cmd = { 'NvimTreeToggle', 'NvimTreeFocus' }
    }

    use {
      'akinsho/bufferline.nvim',
      after = 'nvim-web-devicons',
      config = configs['bufferline']
    }

    use {
      'moll/vim-bbye',
      after = 'bufferline.nvim'
    }

    -- Syntax highlighting
    use {
     'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'BufRead',
      cmd = {
        'TSInstall',
        'TSInstallInfo',
        'TSInstallSync',
        'TSUninstall',
        'TSUpdate',
        'TSUpdateSync',
        'TSDisableAll',
        'TSEnableAll',
      },
      config = configs['treesitter'],
      requires = {
        {
          -- Parenthesis highlighting
          'p00f/nvim-ts-rainbow',
          after = 'nvim-treesitter',
        },
        {
          -- Autoclose tags
          'windwp/nvim-ts-autotag',
          after = 'nvim-treesitter',
        },
        {
          -- Context based commenting
          'JoosepAlviste/nvim-ts-context-commentstring',
          after = 'nvim-treesitter',
        },
      },
    }
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
    },
    auto_clean = true,
    compile_on_sync = true,
  },
}
