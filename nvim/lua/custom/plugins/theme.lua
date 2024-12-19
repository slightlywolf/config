return {
	{ 'gmist/vim-palette',    enabled = false, },
	{'yorickpeterse/vim-paper'},
	{'yorik1984/newpaper.nvim'},

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
}
