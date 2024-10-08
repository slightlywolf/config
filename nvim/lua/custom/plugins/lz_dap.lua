require("helpers.os_funcs")


return
{
	"mfussenegger/nvim-dap",
	dependencies = {

		-- fancy UI for the debugger
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"nvim-neotest/nvim-nio"
				},
			-- stylua: ignore
			keys = {
				{ "<leader>du", function() require("dapui").toggle({}) end,  desc = "Dap UI" },
				{ "<leader>de", function() require("dapui").eval() end,      desc = "Eval",  mode = { "n", "v" } },
			},
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
			end,
		},
		-- single step
		{
			"jbyuki/one-small-step-for-vimkind",
			enabled = false,
			-- stylua: ignore

			keys = {
				{ "<leader>daL", function() require("osv").launch({ port = 8086 }) end, desc = "Adapter Lua Server" },
				{ "<leader>dal", function() require("osv").run_this() end,              desc = "Adapter Lua" },
			},
			config = function()
				local dap = require("dap")
				dap.adapters.nlua = function(callback, config)
					callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
				end
				dap.configurations.lua = {
					{
						type = "nlua",
						request = "attach",
						name = "Attach to running Neovim instance",
					},
				}
			end,
		},

		-- virtual text for the debugger
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},

		--which key integration
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			optional = true,
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 0
			end,
			opts = {
				defaults = {
					["<leader>d"] = { name = "+debug" },
					["<leader>da"] = { name = "+adapters" },
				},
			},
		},

		-- mason.nvim integration
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = "mason.nvim",
			cmd = { "DapInstall", "DapUninstall" },
			opts = {
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {
					function(config)
						-- all sources with no handler get passed here

						-- Keep original functionality
						require('mason-nvim-dap').default_setup(config)
					end,
					coreclr = function(config)
						if not IsLinux() then
							config.adapters = {
								type = "executable",
								command = "C:\\dev\\netcoredbg\\netcoredbg.exe",
								args = {
									"--interpreter=vscode"
								},
							}
						end

						require('mason-nvim-dap').default_setup(config) -- don't forget this!
					end,
					python = function(config)
						if not IsLinux() then
							config.adapters = {
								type = "executable",
								--command = "C:\\Users\\nathan.harmer\\AppData\\Local\\nvim-data\\mason\\bin\\debugpy-adapter.cmd",
								-- command = "python -m debugpy",
								args = {
									"--listen 127.0.0.1:${port}"
								},
							}
						end

						require('mason-nvim-dap').default_setup(config) -- don't forget this!
					end,

				},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					'corelr',
				},
			},
		},
	},

	-- stylua: ignore
	keys = {
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
		{ "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
		{ "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
		{ "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
		{ "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
		{ "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
		{ "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
		{ "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
		{ "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
		{ "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
		{ "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
		{ "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
		{ "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
		{ "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
		{ "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
	},

	config = function()
		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

	end,
}
