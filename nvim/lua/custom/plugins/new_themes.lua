return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "catppuccin/nvim",      name = "catppuccin", priority = 1000 },
	{ "rebelot/kanagawa.nvim" },
	{
		"baliestri/aura-theme",
		lazy = false,
		priority = 1000,
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
			--vim.cmd([[colorscheme aura-dark]])
		end
	},
	{ "EdenEast/nightfox.nvim" },
	{ "rose-pine/neovim",                name = "rose-pine" },
	{ 'navarasu/onedark.nvim' },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "bluz71/vim-moonfly-colors",       name = "moonfly",  lazy = false, priority = 1000 },
	{ "bluz71/vim-nightfly-colors",      name = "nightfly", lazy = false, priority = 1000 },
	{ "savq/melange-nvim" },
	{
		'AlexvZyl/nordic.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require 'nordic'.load()
		end
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
	},
	{ 'Shatur/neovim-ayu' },
	{ "luisiacc/gruvbox-baby" },
	{
		'ribru17/bamboo.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('bamboo').setup {
				-- optional configuration here
			}
			require('bamboo').load()
		end,
	},
	{
		'uloco/bluloco.nvim',
		lazy = false,
		priority = 1000,
		dependencies = { 'rktjmp/lush.nvim' },
		config = function()
			-- your optional config goes here, see below.
		end,
	},
	{
		"oxfist/night-owl.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require("night-owl").setup()
			-- vim.cmd.colorscheme("night-owl")
		end,
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
			})
		end,
	}
}
