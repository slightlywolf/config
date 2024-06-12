local Util = require("util.init")


require('lazy').setup(
	{
		-- NOTE: First, some plugins that don't require any configuration

		-- Git related plugins
		'tpope/vim-fugitive',
		'tpope/vim-rhubarb',

		-- Detect tabstop and shiftwidth automatically
		-- 'tpope/vim-sleuth',

		{
			'nmac427/guess-indent.nvim',
			config = function()
				require('guess-indent').setup {
					auto_cmd = false, -- Set to false to disable automatic execution
					override_editorconfig = false, -- Set to true to override settings set by .editorconfig
					filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
						"netrw",
						"tutor",
					},
					buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
						"help",
						"nofile",
						"terminal",
						"prompt",
					},
				}
			end
		},
		--
		-- NOTE: This is where your plugins related to LSP can be installed.
		--  The configuration is done below. Search for lspconfig to find it below.
		{
			-- LSP Configuration & Plugins
			'neovim/nvim-lspconfig',
			dependencies = {
				-- Automatically install LSPs to stdpath for neovim
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',

				-- Useful status updates for LSP
				-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
				{
					'j-hui/fidget.nvim',
					tag = "legacy",
					opts = {},
				},

				-- Additional lua configuration, makes nvim stuff amazing!
				'folke/neodev.nvim',
			},
		},

		{
			-- Autocompletion
			'hrsh7th/nvim-cmp',
			dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
		},


		-- Useful plugin to show you pending keybinds.
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init  = function()
				vim.o.timeout = false
				vim.o.timeoutlen = 0
			end,
			opts  = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				window = {
					border = "none", -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
					padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
					winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
					zindex = 1000, -- positive value to position WhichKey above other floating windows.
				},
				layout = {
					height = { min = 4, max = 50 }, -- min and max height of the columns
					width = { min = 20, max = 100 }, -- min and max width of the columns
					spacing = 2, -- spacing between columns
				}
			}
		},

		{
			-- Adds git releated signs to the gutter, as well as utilities for managing changes
			'lewis6991/gitsigns.nvim',
			opts = {
				-- See `:help gitsigns.txt`
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				},
			},
		},

		{
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup {
					signs = false
				}
			end
		},

		{
			-- Add indentation guides even on blank lines
			'lukas-reineke/indent-blankline.nvim',
			-- Enable `lukas-reineke/indent-blankline.nvim`
			-- See `:help indent_blankline.txt`
			main = "ibl",
			ops = {},
			config = function()
				require("ibl").setup({
					indent = {
						char = "│"
						--char = "┊"
					}
				})
			end,
		},

		-- "gc" to comment visual regions/lines
		{ 'numToStr/Comment.nvim', enabled = true, opts = {}, lazy = false },


		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
		-- undotree
		{ 'mbbill/undotree' },
		{ 'mg979/vim-visual-multi' },

		{
			-- Highlight, edit, and navigate code
			'nvim-treesitter/nvim-treesitter',
			dependencies = {
				'nvim-treesitter/nvim-treesitter-textobjects',
			},
			config = function()
				-- This line makes it so that it says
				-- parsers are up to date every time that vim opens
				-- which is quite annoying
				--pcall(require('nvim-treesitter.install').update { with_sync = true })
			end,
		},

		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"debugloop/telescope-undo.nvim",
			},
			config = function()
				require("telescope").setup({
					extensions = {
						undo = {
							-- telescope-undo.nvim config, see below
						},
					},
					defaults = {
						layout_strategy = 'vertical',
						layout_config = {
							height = 0.95,
							width = 0.95,
							preview_cutoff = 1
						},
					}
				})
				require("telescope").load_extension("undo")
				vim.keymap.set("n", "<leader>tu", "<cmd>Telescope undo<cr>")
			end,
		},
		--
		{ import = 'custom.plugins' },
	},
	{
		change_detection = {
			enabled = false,
			notify = false
		},
	})
