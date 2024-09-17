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

	{
		"sindrets/diffview.nvim",
		enabled = false,
		config = function()
			require("diffview").setup()
		end
	},

	{
		'petertriho/nvim-scrollbar',
		enabled = false,
		config = function()
			require("scrollbar").setup()
		end
	},

	{
		{
			"folke/todo-comments.nvim",
			enabled = false,
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		}
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
	-- if no nerd font
	-- { "nvim-tree/nvim-web-devicons", lazy = true },

	{ "rcarriga/nvim-notify", enabled = false },

	{ -- this plugin causes huge slowdown
		"HiPhish/nvim-ts-rainbow2",
		enabled = false,
		config = function()
			require('nvim-treesitter.configs').setup {
				rainbow = {
					enable = true,
					-- list of languages you want to disable the plugin for
					disable = { 'jsx', 'cpp' },
					-- Which query to use for finding delimiters
					query = 'rainbow-parens',
					-- Highlight the entire buffer all at once
					strategy = require('ts-rainbow').strategy.global,
				}
			}
		end
	},

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- basically nerd tree
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
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
				groups = { -- table: default groups
					'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
					'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
					'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
					'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
					'EndOfBuffer',
				},
				extra_groups = {}, -- table: additional groups that should be cleared
				exclude_groups = {}, -- table: groups you don't want to clear
			})

			vim.keymap.set('n', '<leader>uT', vim.cmd.TransparentToggle,
				{ desc = '[u]i [T]oggle Transparency' })
			local TransparentByDefault = false

			if (TransparentByDefault) then
				vim.cmd.TransparentEnable()
			end
		end
	},
	{
		"folke/twilight.nvim",
		enabled = false,
		opts = {
			{
				dimming = {
					alpha = 0.25, -- amount of dimming
					-- we try to get the foreground from the highlight groups or fallback color
					color = { "Normal", "#ffffff" },
					term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
					inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
				},
				context = 15, -- amount of lines we will try to show around the current line
				treesitter = true, -- use treesitter when available for the filetype
				-- treesitter is used to automatically expand the visible text,
				-- but you can further control the types of nodes that should always be fully expanded
				expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
					"function",
					"method",
					"table",
					"if_statement",
				},
				exclude = {}, -- exclude these filetypes
			}
		},
		init = function()
			vim.keymap.set('n', '<leader>TW', function()
					vim.cmd("Twilight")
				end,
				{ desc = '[T][W]ilight' })
		end
	},
	{
		"folke/zen-mode.nvim",
		enabled = false,
		opts =
		{
			window = {
				backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
				-- height and width can be:
				-- * an absolute number of cells when > 1
				-- * a percentage of the width / height of the editor when <= 1
				-- * a function that returns the width or the height
				width = 92, -- width of the Zen window
				height = 1, -- height of the Zen window
				-- by default, no options are changed for the Zen window
				-- uncomment any of the options below, or add other vim.wo options you want to apply
				options = {
					-- signcolumn = "no", -- disable signcolumn
					-- number = false, -- disable number column
					-- relativenumber = false, -- disable relative numbers
					-- cursorline = false, -- disable cursorline
					-- cursorcolumn = false, -- disable cursor column
					-- foldcolumn = "0", -- disable fold column
					-- list = false, -- disable whitespace characters
				},
			},
			plugins = {
				-- disable some global vim options (vim.o...)
				-- comment the lines to not apply the options
				options = {
					enabled = true,
					ruler = false, -- disables the ruler text in the cmd line area
					showcmd = false, -- disables the command in the last line of the screen
					-- you may turn on/off statusline in zen mode by setting 'laststatus'
					-- statusline will be shown only if 'laststatus' == 3
					laststatus = 0, -- turn off the statusline in zen mode
				},
				twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
				gitsigns = { enabled = false }, -- disables git signs
				tmux = { enabled = false }, -- disables the tmux statusline
				-- this will change the font size on kitty when in zen mode
				-- to make this work, you need to set the following kitty options:
				-- - allow_remote_control socket-only
				-- - listen_on unix:/tmp/kitty
			},
			-- callback where you can add custom code when the Zen window opens
			on_open = function(win)
			end,
			-- callback where you can add custom code when the Zen window closes
			on_close = function()
			end,
		},
		init = function()
			vim.keymap.set('n', '<leader>ZM',
				vim.cmd.ZenMode, { desc = '[Z]en [M]ode' })
		end

	},
}
