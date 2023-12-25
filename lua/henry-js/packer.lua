-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use 'nvim-lua/plenary.nvim'

	-- telescope
	use {
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.x', 
		requires = { {'nvim-lua/plenary.nvim'} } 
	}

	-- rosepine
	use({ 
		'rose-pine/neovim', 
		as = 'rose-pine'
	})
	use{
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	use 'nvim-treesitter/playground'

	use 'ThePrimeagen/harpoon'
end)
