require("helpers.funcs")
local Util = require("util.init")

----------------------------------------------------------------------------------------
-- Diagnostic keymaps
----------------------------------------------------------------------------------------
local function map(mode, lhs, rhs, opts)
  -- do not create the keymap if a lazy keys handler exists
	opts = opts or {}
	opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end

----------------------------------------------------------------------------------------
-- Diagnostic keymaps
----------------------------------------------------------------------------------------
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

----------------------------------------------------------------------------------------
-- copy and pasting to system clipboard
----------------------------------------------------------------------------------------
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = "[y]ank" })
vim.keymap.set({'n', 'v'}, '<leader>y', '"*y', { desc = "[y]ank" })
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', { desc = "[p]aste" })
vim.keymap.set({'n', 'v'}, '<leader>p', '"*p', { desc = "[p]aste" })

vim.keymap.set({'n', 'v'}, '<leader>Y', '"+Y', { desc = "[Y]ank" })
vim.keymap.set({'n', 'v'}, '<leader>Y', '"*Y', { desc = "[Y]ank" })
vim.keymap.set({'n', 'v'}, '<leader>P', '"+P', { desc = "[P]aste" })
vim.keymap.set({'n', 'v'}, '<leader>P', '"*P', { desc = "[P]aste" })


local keys = {
	{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
	{ "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
	{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
	{ "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },

	-- find
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	{ "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
	{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
	{ "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
	-- git
	{ "<leader>Gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
	{ "<leader>Gs", "<cmd>Telescope git_status<CR>", desc = "status" },
	{
		"<leader>GT",
		function()
			if vim.o.signcolumn == 'yes' or vim.o.signcolumn == 'auto' then
				vim.o.signcolumn = 'number'
				vim.print("Signcolumn: number")
			elseif vim.o.signcolumn == 'no' then
				vim.o.signcolumn = 'yes'
				vim.print("Signcolumn: yes")
			elseif vim.o.signcolumn == 'number' then
				vim.o.signcolumn = 'no'
				vim.print("Signcolumn: no")
			end
		end,
		desc = "Toggle Signcolumn / Git column (No, Yes, Number)"
	},
	-- search
	{ '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
	{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
	{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
	{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
	{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
	{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
	{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
	{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
	{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
	{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
	{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
	{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
	{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
	{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
	{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
	{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
	{ "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
	{ "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
	{ "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
	{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
	{ "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
	{
		"<leader>ss",
		Util.telescope("lsp_document_symbols", {
			symbols = {
				"Class",
				"Function",
				"Method",
				"Constructor",
				"Interface",
				"Module",
				"Struct",
				"Trait",
				"Field",
				"Property",
			},
		}),
		desc = "Goto Symbol",
	},
	{
		"<leader>sS",
		Util.telescope("lsp_dynamic_workspace_symbols", {
			symbols = {
				"Class",
				"Function",
				"Method",
				"Constructor",
				"Interface",
				"Module",
				"Struct",
				"Trait",
				"Field",
				"Property",
			},
		}),
		desc = "Goto Symbol (Workspace)",
	},
}

for _, key in ipairs(keys) do
  vim.keymap.set('n', key[1], key[2], { desc = key["desc"] })
end


-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>te', require('telescope.builtin').diagnostics, { desc = '[e] Telescope List errors' })

vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

----------------------------------------------------------------------------------------
-- BASIC KEY MAPS
----------------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set( 'n', 'Q', '<Nop>', { silent = true} );

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- scrolling up and down the page should be centred
vim.keymap.set('n', '<C-u>', math.floor(vim.fn.winheight(0) * 1 / 3) .. "<C-u>zz", { silent = true })
vim.keymap.set('n', '<C-d>', math.floor(vim.fn.winheight(0) * 1 / 3) .. "<C-d>zz", { silent = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- toggle options
if vim.lsp.inlay_hint then
	map("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
--
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })


-- various editing macros
-- insert current filename
map (
	{'n'},
	'<leader>if',
	function ()
		vim.cmd("let @q=expand('%:t')")
		vim.cmd('normal "qp')
	end ,
	{
		desc = "insert [f]ilename"
	}
)

map (
	{'n'},
	'<leader>iF',
	function ()
		vim.cmd("let @q=expand('%:p')")
		vim.cmd('normal "qp')
	end ,
	{ desc = "insert full path" }
)

map(
	{'n'},
	'<leader>iW',
	function()
		vim.cmd('%s/\\s\\+$//e')
	end,
	{ desc = "remove trailing whitespace" }
)


-- random color scheme
map (
	{'n'},
	'<leader>R',
	function()
		C_set_random_colorscheme(C_all_filter)
	end,
	{ desc = "Random colorscheme" }
)

-- Print avaliable colorschemes
map (
	{'n'},
	'<leader>PR',
	function()
		C_print_colorscheme_list(C_all_filter)
	end,
	{ desc = "Print avaliable colorschemes" }
)

-- current date
map (
	{'n'},
	'<leader>id',
	function()
		vim.cmd('let @q=strftime("%d-%m-%Y")')
		vim.cmd('normal "qp')
	end,
	{ desc = "Current date dd-mm-yyyy" }
)
