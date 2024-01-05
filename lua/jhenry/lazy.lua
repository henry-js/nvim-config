local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- required
    {
        'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'
    },
    {
        'neovim/nvim-lspconfig'
    },
    {
        'hrsh7th/cmp-nvim-lsp'
    },
    {
        'hrsh7th/nvim-cmp'
    },
    {
        'L3MON4D3/LuaSnip',
	    version = "v2.*", 
	    build = "make install_jsregexp",
    },

    -- themes
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        config = function() 
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
            })
            vim.cmd([[colorscheme catppuccin]]) 
        end,
    },

    -- navigation
    { 
        "nvim-lua/plenary.nvim"
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    { 
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate" 
    },
    {
        "ggandor/leap.nvim",
    },

    -- utils
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = { }
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        config = function() require("lualine").setup() end
    },
    {
        "lukas-reineke/indent-blankline.nvim"
    },
--    {
--        "windwp/nvim-autopairs",
--        event = "InsertEnter",
--        opts = {}
--    },
--    {
--        "rcarriga/nvim-notify"
--    },
--    {
--        "folke/noice.nvim",
-- --       event = "VeryLazy",
--        opts = {},
--        dependencies = {
--            "MunifTanjim/nui.nvim",
--            "rcarriga/nvim-notify",
--        }
--    },
})

--- Uncomment these if you want to manage the language servers from neovim
-- {'williamboman/mason.nvim'},
-- {'williamboman/mason-lspconfig.nvim'},
