----------------------------------------------------------------------------------------
-- VIM OPTIONS
----------------------------------------------------------------------------------------
-- [[ Setting options ]]
-- See `:help vim.o`

-- function! GetColorSchemes()
--    return uniq(sort(map(
--    \  globpath(&runtimepath, "colors/*.vim", 0, 1),
--    \  'fnamemodify(v:val, ":t:r")'
--    \)))
-- endfunction
--
require("helpers.funcs")

--vim.cmd.colorscheme("chocolate-contrast")
vim.cmd.colorscheme(vim.g.BackupColorschemeName)
-- SETS A RANDOM COLORSCHEME
if(vim.g.RandomSchemeOnStartup) then
	C_set_random_colorscheme(C_all_filter)
end
-- vim.cmd.colorscheme("catppuccin-mocha")
-- vim.cmd.colorscheme("redstring")
-- vim.cmd.colorscheme("scorch-contrast")

vim.cmd [[highlight guicursor ctermbg=0 guibg=White]]

vim.cmd "hi! TermCursor guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"
vim.cmd "hi! TermCursorNC guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"

vim.cmd "hi! Cursor guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"
vim.cmd "hi! CursorNC guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"

-- disable background
Disable_Background()

--
-- Set highlight on search
vim.o.hlsearch = true
vim.o.wrap = false
vim.o.cursorline = false

-- set the nvim guifont
-- vim.opt.guifont = { "GohuFont 11 Nerd Font:h17"}
vim.opt.guifont = { "UnifontExMono:h24"}
-- vim.opt.guifont = { "Iosevka Nerd Font Mono:h11"}
-- vim.opt.guifont = { "Iosevka Nerd Font:h18"}
-- vim.opt.guifont = { "CaskaydiaCove Nerd Font Mono:h16"}
-- vim.opt.guifont = { "JetBrainsMono Nerd Font:h18"}
-- vim.opt.guifont = { "Hurmit Nerd Font:h11"}

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.colorcolumn = "88"
vim.cmd [[highlight ColorColumn ctermbg=0 guibg=Black]]

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.ttimeoutlen = 10

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true
vim.keymap.set({ 'n', 'v' }, '<leader>fI', require('guess-indent').set_from_buffer, { desc = "fix [I]ndent" })

-- make the cursor a block
vim.o.guicursor = 'n-v-c-i:block-Cursor'

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'number'
--vim.wo.signcolumn = 'no'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 0

vim.o.shiftwidth = 8
vim.o.tabstop = 8
vim.o.softtabstop = 8

vim.o.expandtab = false
vim.o.smartindent = true
vim.o.shiftround = true
vim.o.autoindent = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- neovide configuration
if vim.g.neovide then
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	vim.g.neovide_position_animation_length = 0.0 -- 0.15
	vim.g.neovide_scroll_animation_length = 0.0 -- 0.3
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_theme = 'auto'
	vim.g.neovide_cursor_animation_length = 0.0 -- 0.13
	vim.g.neovide_cursor_trail_size = 0.0 -- 0.8
	vim.opt.guifont = { "UnifontExMono:h24"}
end
