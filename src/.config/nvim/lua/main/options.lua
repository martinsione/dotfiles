require('main.utils')
local opt = vim.opt

-- General
opt.clipboard     = 'unnamedplus'
opt.hidden        = true
opt.mouse         = 'a'
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

-- Completion
opt.completeopt   = "menuone,noinsert,noselect"
opt.pumheight     = 10

-- Search
opt.ignorecase    = true
opt.smartcase     = true
opt.wildignore    = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**';
opt.wildignorecase= true

-- On the edge
opt.backup        = false
opt.writebackup   = false
opt.swapfile      = false

-- Tabs
opt.expandtab     = true
opt.shiftwidth    = 2
opt.softtabstop   = 0
opt.tabstop       = 2


-- Messing around
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
