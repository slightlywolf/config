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
			vim.cmd('colorscheme everforest')
		end,
	}
}
