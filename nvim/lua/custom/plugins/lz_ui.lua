return {
	{
		"stevearc/dressing.nvim",
		-- init = function()
		--   ---@diagnostic disable-next-line: duplicate-set-field
		--   vim.ui.select = function(...)
		--     require("lazy").load({ plugins = { "dressing.nvim" } })
		--     return vim.ui.select(...)
		--   end
		--   ---@diagnostic disable-next-line: duplicate-set-field
		--   vim.ui.input = function(...)
		--     require("lazy").load({ plugins = { "dressing.nvim" } })
		--     return vim.ui.input(...)
		--   end
		-- end,
	},

	-- Active indent guide and indent text objects. When you're browsing
	-- code, this highlights the current level of indentation, and animates
	-- the highlighting.
	{
		"folke/noice.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
			},
		},
		-- stylua: ignore
		keys = {
			{ "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                 desc = "Redirect Cmdline" },
			{ "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
			{ "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
			{ "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
			{ "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
			{ "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,              expr = true,              desc = "Scroll forward",  mode = { "i", "n", "s" } },
			{ "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,              expr = true,              desc = "Scroll backward", mode = { "i", "n", "s" } },
		},
	},
	{
		"echasnovski/mini.indentscope",
		enabled = false,
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
			draw = {}
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "rcarriga/nvim-notify" },


	-- ui components
	{ "MunifTanjim/nui.nvim",        lazy = true },

	-- basically nerd tree
	{
		"nvim-tree/nvim-tree.lua",
		init = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
				},
			})
		end,
		lazy = true
	},
	{
		"xiyaowong/transparent.nvim",
		init = function()
			require("transparent").setup({ -- Optional, you don't have to run setup.
				groups = {     -- table: default groups
					'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
					'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
					'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
					'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
					'EndOfBuffer',
				},
				extra_groups = {}, -- table: additional groups that should be cleared
				exclude_groups = {}, -- table: groups you don't want to clear
			})

			vim.keymap.set('n', '<leader>uT', vim.cmd.TransparentToggle, { desc = '[u]i [T]oggle Transparency' })
			local TransparentByDefault = true

			if(TransparentByDefault) then
				vim.cmd.TransparentEnable()
			end

		end
	}
}
