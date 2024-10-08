require("helpers.funcs")
local Util = require("util.init")


local function augroup(name)
	return vim.api.nvim_create_augroup("nathanvim_" .. name, { clear = true })
end


-- chose a random color on buff open
if (vim.g.RandomSchemeOnOpen) then
	vim.api.nvim_create_autocmd({ "BufReadPre" }, {
		group = augroup("fileopen"),
		callback = function()
			C_set_random_colorscheme(C_all_filter)
		end,
	})
end


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- set indent settings of some files
vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'*.js',
		'*.ts',
		'*.vue',
	},
	callback = function()
		vim.o.shiftwidth = 4
		vim.o.tabstop = 4
		vim.opt.foldmethod = 'indent'
	end,
})

-- filetype aliases
vim.filetype.add { extension = { xaml = 'xml' } }

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = false
		vim.opt_local.spell = true
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
