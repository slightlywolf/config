return {
	{ 'gmist/vim-palette',    enabled = false, },

	-- this is the one with the base16 colors
	{ "bradcush/nvim-base16", enabled = false, },
	{
		'projekt0n/github-nvim-theme',
		enabled = false,
		name = 'github-theme',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('github-theme').setup({
				options = {
					styles = {
						comments = 'italic',
						keywords = 'bold',
						types = 'italic,bold',
					}
				}
			})
		end,
	},

	{
		"slugbyte/lackluster.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("lackluster-hack") -- my favorite
			-- vim.cmd.colorscheme("lackluster-mint")
		end,
	},
	{ "fcpg/vim-farout" },
	{ "projekt0n/caret.nvim" },
	{ "n1ghtmare/noirblaze-vim" },
	{ "nikolvs/vim-sunbather" },
	{ "ntk148v/komau.vim" },
	{ "andreasvc/vim-256noir" },
	{
		"neanias/everforest-nvim",
		enabled = false,
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				background = 'hard',
				-- Your config here
			})
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine", enabled = false }
}
