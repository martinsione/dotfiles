require('main.utils')
local opt = vim.opt

vim.g.mapleader   = " "
-- General
opt.clipboard     = 'unnamedplus'
opt.hidden        = true
opt.mouse         = 'a'
opt.pumheight     = 10
opt.scrolloff     = 8
opt.splitbelow    = true
opt.splitright    = true
opt.timeoutlen    = 1000
opt.updatetime    = 100

-- Appearance
opt.cmdheight     = 1
opt.cursorline    = true
opt.foldmethod    = 'marker'
opt.nu            = true
opt.rnu           = true
opt.showmode      = false
opt.signcolumn    = 'yes'
opt.termguicolors = true
opt.wrap          = false

-- Search
opt.ignorecase    = true
opt.smartcase     = true
opt.wildignore    = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**';
opt.wildignorecase= true

-- On the edge
opt.backup        = false
opt.writebackup   = false
opt.swapfile      = false

-- -- Tab
opt.expandtab     = true
opt.shiftwidth    = 2
opt.softtabstop   = 0
opt.tabstop       = 2


-- Messing around
opt.rtp           = opt.rtp + "$XDG_CONFIG_HOME/nvim/after/keymap/**"
opt.joinspaces    = false
opt.inccommand    = 'split'
opt.shortmess     = 'filnxtToOFAcIW'
opt.virtualedit   = 'block'

-- Performance
opt.lazyredraw    = true

-- Thanks tj
opt.formatoptions = opt.formatoptions
                    - 'a'     -- Auto formatting is BAD.
                    - 't'     -- Don't auto format my code. I got linters for that.
                    - 'c'     -- In general, I like it when comments respect textwidth
                    + 'q'     -- Allow formatting comments w/ gq
                    - 'o'     -- O and o, don't continue comments
                    - 'r'     -- But do continue when pressing enter.
                    + 'n'     -- Indent past the formatlistpat, not underneath it.
                    + 'j'     -- Auto-remove comments when combining lines ( <C-J> )
                    - '2'     -- I'm not in gradeschool anymore

-- Disabling some default plugins
vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_matchparen        = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1
