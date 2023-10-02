return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')
	require('harpoon').setup({
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
			height = vim.api.nvim_win_get_height(0) - 4
		}
	})

    vim.keymap.set("n","<leader>m", mark.add_file, {desc = "Mark File with harpoon"})
    vim.keymap.set("n","<leader>hm", ui.toggle_quick_menu, {desc = "Harpoon Quick Menu"})
    vim.keymap.set("n","<leader>1", function() ui.nav_file(1) end , { desc = "Navigate to file 1"})
    vim.keymap.set("n","<leader>2", function() ui.nav_file(2) end , { desc = "Navigate to file 2"})
    vim.keymap.set("n","<leader>3", function() ui.nav_file(3) end , { desc = "Navigate to file 3"})
    vim.keymap.set("n","<leader>4", function() ui.nav_file(4) end , { desc = "Navigate to file 4"})
    vim.keymap.set("n","<leader>5", function() ui.nav_file(5) end , { desc = "Navigate to file 5"})
    vim.keymap.set("n","<leader>6", function() ui.nav_file(6) end , { desc = "Navigate to file 6"})
    vim.keymap.set("n","<leader>7", function() ui.nav_file(7) end , { desc = "Navigate to file 7"})
    vim.keymap.set("n","<leader>8", function() ui.nav_file(8) end , { desc = "Navigate to file 8"})
    vim.keymap.set("n","<leader>9", function() ui.nav_file(9) end , { desc = "Navigate to file 9"})
    vim.keymap.set("n","<leader>0", function() ui.nav_file(0) end , { desc = "Navigate to file 0"})
  end,
}
