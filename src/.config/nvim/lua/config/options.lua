local o = vim.opt
o.colorcolumn = "80"
o.cursorline = true
o.number = true
o.relativenumber = true
o.ruler = false
o.showmode = false
o.signcolumn = "yes"
o.termguicolors = true
o.updatetime = 100
o.wrap = false
o.pumheight = 8

o.backup = false
o.writebackup = false
o.swapfile = false

o.clipboard = "unnamedplus"
o.scrolloff = 8
o.splitbelow = true
o.splitright = true
o.virtualedit = "block"

-- Search
o.inccommand = "nosplit"
o.ignorecase = true
o.smartcase = true
o.wildignore = { ".git/*", "node_modules/*" }
o.wildignorecase = true

-- Tabs
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4

-- Shortmess
o.shortmess = o.shortmess
  + {
    A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
    I = true, -- don't give the intro message when starting Vim |:intro|.
    W = true, -- don't give "written" or "[w]" when writing a file
    c = true, -- don't give |ins-completion-menu| messages
    m = true, -- use "[+]" instead of "[Modified]"
  }

-- Format options
o.formatoptions = o.formatoptions
  + {
    c = false,
    o = false, -- O and o, don't continue comments
    r = true, -- Pressing Enter will continue comments
  }

-- Remove builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1
