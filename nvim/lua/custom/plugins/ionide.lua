return {
		{
			"ionide/Ionide-vim",
			enabled = false,
			config = function()
				require("ionide").setup({
					vim.cmd("let g:fsharp#lsp_auto_setup = 0")
				})
			end
		}
	}
