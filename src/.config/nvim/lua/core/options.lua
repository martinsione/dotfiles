-- TODO: REMOVE when https://github.com/neovim/neovim/pull/13479 comes

local opt = vim.opt

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

-- Backups
opt.backup        = false
opt.writebackup   = false
opt.swapfile      = false

-- Completion
opt.completeopt   = "menuone,noinsert,noselect"
opt.pumheight     = 15
opt.pumblend      = 10

-- General
opt.clipboard     = 'unnamedplus'
opt.hidden        = true
opt.joinspaces    = false
opt.mouse         = 'a'
opt.scrolloff     = 8
opt.shortmess     = 'filnxtToOFAcIW'
opt.splitbelow    = true
opt.splitright    = true
opt.timeoutlen    = 1000
opt.updatetime    = 100
opt.virtualedit   = 'block'

-- Performance
opt.lazyredraw    = true

-- Search
opt.inccommand    = 'nosplit'                        -- show substitutions incrementally
opt.ignorecase    = true
opt.smartcase     = true
opt.wildignore    = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**';
opt.wildignorecase= true

-- Tabs
opt.expandtab     = true
opt.shiftwidth    = 2
opt.softtabstop   = 0
opt.tabstop       = 2

opt.iskeyword     = opt.iskeyword + '-'
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

