----------------------------------------------------------------------------------------
-- NATHAN CONFIG 23-08-23
-- Quick Settings
----------------------------------------------------------------------------------------
vim.g.RandomSchemeOnFileOpen = false
vim.g.RandomSchemeOnStartup = false

-- backup scheme
--vim.g.BackupColorschemeName = "github_dark_default"
-- vim.g.BackupColorschemeName = "lackluster-dark"
-- vim.g.BackupColorschemeName = "elflord" best default dark scheme
-- vim.g.BackupColorschemeName = "farout"
-- vim.o.background = 'light'
---
vim.g.have_nerd_font = false
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- uses nvim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

----------------------------------------------------------------------------------------
-- PLUGINS BUILT IN
----------------------------------------------------------------------------------------
require('config.lazysetup')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup { defaults = { mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false, }, }, }, }

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, 'fzf')

--
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

require("config.lspsettings")

----------------------------------------------------------------------------------------
-- REQUIRE THE OTHER FILES
----------------------------------------------------------------------------------------
require("config.init2")
require("config.autocmds")
require("config.keymaps")
require("config.vimtion")
require("util.init")
require("helpers.funcs")

-- vim.cmd.colorscheme("azure-contrast")
-- C_set_random_colorscheme(C_all_filter)

