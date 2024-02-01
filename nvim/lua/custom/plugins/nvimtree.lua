local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings for when inside nvim-tree
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

  -- basically nerd tree
return {
    "nvim-tree/nvim-tree.lua",
    init = function()
		local api = require "nvim-tree.api"
		local conf = require "nvim-tree"
		require("nvim-tree").setup({
			on_attach = my_on_attach,
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
				add_trailing = true,
			},
			filters = {
				dotfiles = false,
			},
			reload_on_bufenter = true,
			git = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
				disable_for_dirs = {},
				timeout = 5000,
			},
			-- update_focused_file = {
			-- 	enable = true,
			-- 	update_root = true
			-- },		
			actions = {
				open_file = {
					quit_on_open = true
				}
			}
		})

	-- set keymaps for using nvim-tree
    vim.keymap.set('n', '<leader>nt', function() vim.cmd('NvimTreeToggle') end, { desc = "Opens nvim-tree in the root directory" })
    vim.keymap.set('n', '<leader>nc', function() vim.cmd('NvimTreeClose') end , { desc = "Closes nvim tree" })
    vim.keymap.set('n', '<leader>nC', function() vim.cmd('NvimTreeCollapse') end, { desc = "Collapses folders in nvim tree" })
    vim.keymap.set('n', '<leader>nf', function() vim.cmd('NvimTreeFindFile') end, { desc = "Finds files in nvim tree" })
	
    vim.keymap.set('n', '<leader>nu', function() api.tree.change_root(vim.fn.expand('%:h')) end, { desc = "Update root directory" })
		
	-- too much muscle memory
	vim.api.nvim_create_user_command('Ex', function() vim.cmd('NvimTreeToggle') end, {})
  end,
  lazy = true
}
