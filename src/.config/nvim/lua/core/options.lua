local opt = vim.opt

-- Appearance
opt.cmdheight = 1
opt.cursorline = true
opt.foldmethod = 'marker'
opt.number = true
opt.relativenumber = true
opt.ruler = false -- My statusline take care of that
opt.showmode = false
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.wrap = false

-- Backups
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Completion
opt.completeopt = 'menuone,noinsert,noselect'
opt.pumheight = 8
opt.pumblend = 10

-- General
opt.clipboard = 'unnamedplus'
opt.hidden = true
opt.joinspaces = false
opt.mouse = 'a'
opt.scrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 1000
opt.updatetime = 100
opt.virtualedit = 'block'
opt.iskeyword = opt.iskeyword + '-'

-- Performance
opt.lazyredraw = true

-- Search
opt.inccommand = 'nosplit' -- show substitutions incrementally
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = '.git,**/node_modules/**';
opt.wildignorecase = true

-- Tabs
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 0
opt.tabstop = 2

-- Shortmess
opt.shortmess = opt.shortmess + 'A' + 'c' + 'I' + 'W'

-- Format options
opt.formatoptions = opt.formatoptions + 'j' -- Auto-remove comments when combining lines ( <C-J> )
+ 'n' -- Indent past the formatlistpat, not underneath it.
+ 'q' -- Allow formatting comments w/ gq
- 'c' -- In general, I like it when comments respect textwidth
- 'r' -- But do continue when pressing enter.
- 'o' -- O and o, don't continue comments
- 't' -- Don't auto format my code. I got linters for that.
