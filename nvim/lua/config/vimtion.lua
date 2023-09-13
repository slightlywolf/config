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

math.randomseed(os.time())

local my_colors = vim.fn.getcompletion("","color")
local rand_scheme = my_colors[math.ceil(#my_colors * math.random())]

-- vim.print(rand_scheme)
vim.cmd.colorscheme (rand_scheme)

vim.cmd[[highlight guicursor ctermbg=0 guibg=White]]

vim.cmd "hi! TermCursor guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"
vim.cmd "hi! TermCursorNC guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"

vim.cmd "hi! Cursor guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"
vim.cmd "hi! CursorNC guifg=#000000 guibg=#FFBF00 gui=NONE cterm=NONE"


--
-- Set highlight on search
vim.o.hlsearch = true
vim.o.wrap = false
vim.o.cursorline = false

-- set the nvim guifont
--vim.opt.guifont = { "GohuFont 14 Nerd Font:h10"}
-- vim.opt.guifont = { "CaskaydiaCove Nerd Font Mono:h16"}
vim.opt.guifont = { "BigBlueTerm437 Nerd Font:h10"}
-- vim.opt.guifont = { "Hurmit Nerd Font:h16"}

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.colorcolumn = "88"
vim.cmd[[highlight ColorColumn ctermbg=0 guibg=White]]

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.ttimeoutlen = 10

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true
vim.keymap.set({'n', 'v'}, '<leader>fI', require('guess-indent').set_from_buffer, { desc = "fix [I]ndent" })

-- make the cursor a block
vim.o.guicursor = 'n-v-c-i:block-Cursor'

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 0

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.expandtab = false
vim.o.smartindent = true
vim.o.shiftround = true
vim.o.autoindent = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

