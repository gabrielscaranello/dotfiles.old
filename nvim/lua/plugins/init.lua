-- bootstrap Packer
local fn = vim.fn
local cmd = vim.cmd
local packer_path = "/site/pack/packer/start/packer.nvim"
local install_path = fn.stdpath("data") .. packer_path

if fn.empty(vim.fn.glob(install_path)) > 0 then
	local repo = "https://github.com/wbthomason/packer.nvim"
	local clone = { "git", "clone", "--depth", "1", repo, install_path }
	PackerBboostraped = vim.fn.system(clone)
end

cmd('packadd packer.nvim')

if PackerBboostraped then
	require("packer").sync()
end

-- add plugins
local startup = function(use)
  local configs = require('plugins.configs')

  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  
  use {
    'antoinemadec/FixCursorHold.nvim',
    event = "BufRead"
    config = configs['filetype'],
  }
  
  use {
    'nathom/filetype.nvim',
    config = configs['filetype']
  }

end


-- load plugins
return require("packer").startup(startup)

