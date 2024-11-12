return {
		{
			"ionide/Ionide-vim",
			config = function()
				require("ionide").setup({
					vim.cmd("let g:fsharp#lsp_auto_setup = 0")
				})
			end
		}
	}
