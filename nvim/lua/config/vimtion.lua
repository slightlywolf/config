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
--vim.cmd.colorscheme(vim.g.BackupColorschemeName)

-- SETS A RANDOM COLORSCHEME
if(vim.g.RandomSchemeOnStartup) then
	C_set_random_colorscheme(C_all_filter)
end
-- vim.cmd.colorscheme("catppuccin-mocha")

-- vim.cmd [[highlight guicursor ctermbg=0 guibg=White]]
--
vim.cmd "hi! TermCursor guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"
vim.cmd "hi! TermCursorNC guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"

vim.cmd "hi! Cursor guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"
vim.cmd "hi! CursorNC guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"

-- netrw settings
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = 'cp -r'
--
vim.g.netrw_altv = 1
--
--
-- Open files in previous window. This emulates the typical "drawer" behavior
--vim.g.netrw_browse_split = 4

-- Set the styling of the file list to be that of a tree
vim.g.netrw_liststyle = 1

vim.g.netrw_winsize = -25 -- Set the width of the "drawer"

vim.g.netrw_clipboard = 0
vim.g.netrw_fastbrowse = 2


-- vim.cmd "hi! link netrwMarkFile Search"

vim.keymap.set({ 'n', 'v' }, '<leader>fI', require('guess-indent').set_from_buffer, { desc = "fix [I]ndent" })

-- Remove all empty "No Name" buffers that are unmodified
local function clean_empty_bufs()
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
        if
            vim.api.nvim_buf_get_name(buf) == ""
            and not vim.api.nvim_buf_get_option(buf, "modified")
            and vim.api.nvim_buf_is_loaded(buf)
        then
            vim.api.nvim_buf_delete(buf, {})
        end
	end
end

-- Clean up netrw's empty buffer artifacts and let that logic toggle it
local function toggle_netrw()
	clean_empty_bufs()
	local flag = false
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
        local e, v = pcall(function()
            return vim.api.nvim_buf_get_var(buf, "current_syntax")
        end)
        if
            (e and v == "netrwlist")
            and not vim.api.nvim_buf_get_option(buf, "modified")
            and vim.api.nvim_buf_is_loaded(buf)
        then
            flag = true
            vim.api.nvim_buf_delete(buf, {})
        end
	end

	if not flag then
		vim.cmd(":Lexplore")
	end
end



--
-- Set highlight on search
vim.o.hlsearch = true
vim.o.wrap = false
vim.o.cursorline = false

-- set the nvim guifont
-- vim.opt.guifont = { "GohuFont 11 Nerd Font:h17"}
-- vim.opt.guifont = { "UnifontExMono:h24"}
-- vim.opt.guifont = { "Monaspace Radon:h24"}
-- vim.opt.guifont = { "Iosevka Nerd Font Mono:h11"}
-- vim.opt.guifont = { "BigBlueTerm437 Nerd Font:h18"}
-- vim.opt.guifont = { "Iosevka Nerd Font:h18"}
-- vim.opt.guifont = { "CaskaydiaCove Nerd Font Mono:h16"}
-- vim.opt.guifont = { "JetBrainsMono Nerd Font:h18"}
-- vim.opt.guifont = { "Hurmit Nerd Font:h11"}

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.colorcolumn = "88,120"
-- vim.cmd [[highlight ColorColumn ctermbg=0 guibg=Black]]

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
vim.o.errorbells = false
vim.o.vb = false
vim.o.belloff = 'all'


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
	-- vim.opt.guifont = { "Monaspace Radon:h24"}
	vim.opt.guifont = { "BigBlueTerm437 Nerd Font:h18"}
end
