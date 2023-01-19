local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "#2e3440"
    })
    PACKER_BOOTSTRAP = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path})
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init(require("utils.config").packer_init_opts())

return packer.startup(function(use)

    -- self assign and impatient
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"

    -- dependencies
    use "nvim-lua/plenary.nvim"
    use "MunifTanjim/nui.nvim"
    use {
        "nvim-tree/nvim-web-devicons",
        config = function() require "plugins.configs.nvim-web-devicons" end
    }

    use {
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter"
    }

    use {
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter"
    }

    use {
        "JoosepAlviste/nvim-ts-context-commentstring",
        after = "nvim-treesitter"
    }

    -- nord theme
    use "arcticicestudio/nord-vim"

    -- file explorer
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        config = function() require "plugins.configs.neo-tree" end
    }

    -- buffer manager
    use {
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        config = function() require "plugins.configs.bufferline" end
    }

    -- delete buffer
    use {
        "famiu/bufdelete.nvim",
        config = function() require "plugins.configs.bufdelete" end
    }

    -- indent
    use {
        "lukas-reineke/indent-blankline.nvim",
        after = "nvim-treesitter",
        config = function() require "plugins.configs.indent-blankline" end
    }

    use {
        "Darazaki/indent-o-matic",
        opt = true,
        config = function() require "plugins.configs.indent-o-matic" end
    }

    -- syntax hightlight
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        event = "BufRead",
        cmd = {"TSInstall", "TSInstallInfo", "TSInstallSync", "TSUninstall", "TSUpdate", "TSUpdateSync", "TSDisableAll",
               "TSEnableAll"},
        config = function() require "plugins.configs.treesitter" end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
