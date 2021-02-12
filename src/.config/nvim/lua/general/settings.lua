require('general.opt')
local opt = vim.opt

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

-- Tab
opt.expandtab     = true
opt.shiftwidth    = 2
opt.tabstop       = 2
opt.tabstop       = 2

-- Messing around
opt.inccommand     = 'split'

-- Thanks tj
opt.formatoptions = opt.formatoptions
                    - 'a'     -- Auto formatting is BAD.
                    - 't'     -- Don't auto format my code. I got linters for that.
                    - 'c'     -- In general, I like it when comments respect textwidth
                    + 'q'     -- Allow formatting comments w/ gq
                    - 'o'     -- O and o, don't continue comments
                    - 'r'     -- But do continue when pressing enter.
                    + 'n'     -- Indent past the formatlistpat, not underneath it.
                    + 'j'     -- Auto-remove comments if possible.
                    - '2'     -- I'm not in gradeschool anymore

-- Prevents from creating .netrwhist
vim.g.netrw_dirhistmax = 0

-- Remove whitespace on save
vim.cmd[[autocmd BufWritePre * %s/\s\+$//e]]
