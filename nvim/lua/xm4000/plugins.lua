local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
      "git",
    	"clone",
    	"--depth",
    	"1",
    	"https://github.com/wbthomason/packer.nvim",
    	install_path,
  	}
  	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end
vim.cmd [[
	augroup packer_user_config
    	autocmd!
    	autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end
-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'rounded' })
		end
	}
})
-- Plugins are here
return packer.startup(function(use)
	use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
	use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins
	-- Cmp
	use {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'saadparwaiz1/cmp_luasnip',
		-- Snippets
		'L3MON4D3/LuaSnip',
		'rafamadriz/friendly-snippets'
	}
	-- Lsp
	use {
		'neovim/nvim-lspconfig',
		'williamboman/mason.nvim',
    	'williamboman/mason-lspconfig.nvim',
		--'jose-elias-alvarez/null-ls.nvim',
		-- Trouble
		{ 'folke/trouble.nvim', 
			requires = { 'kyazdani42/nvim-web-devicons' }
		}
	}
	-- Telescope
	use 'nvim-telescope/telescope.nvim'
	-- Bufferline
	use 'akinsho/bufferline.nvim'
	-- Colorschemes
	use 'folke/tokyonight.nvim'
  -- Lualine
  use "nvim-lualine/lualine.nvim"
	-- Automatically set up your configuration after cloning packer.nvim
  	-- Put this at the end after all plugins
  	if PACKER_BOOTSTRAP then
    	require("packer").sync()
  	end
end)

