-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.have_nerd_font = true

local opt = vim.opt
opt.clipboard = "unnamedplus" -- Sync with system clipboard

opt.completeopt = "menuone,noselect,popup" -- popup shows docs for the selected LSP item
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.cursorline = true
opt.expandtab = true
opt.fillchars = { diff = "╱", eob = " " }
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt"
opt.grepprg = "rg --vimgrep" -- default adds -uu, which greps ignored files
opt.ignorecase = true
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 8
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
