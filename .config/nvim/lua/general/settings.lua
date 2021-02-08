
require('general.opt')
local opt = vim.opt

opt.pumheight     = 10
opt.showmode      = false
opt.termguicolors = true
opt.cursorline    = true
opt.nu            = true
opt.rnu           = true
opt.signcolumn    = 'yes'
opt.wrap          = false
opt.backup        = false
opt.writebackup   = false
opt.clipboard     = 'unnamedplus'
opt.cmdheight     = 1
opt.hidden        = true
opt.mouse         = 'a'
opt.scrolloff     = 8
opt.splitbelow    = true
opt.splitright    = true
opt.timeoutlen    = 1000
opt.updatetime    = 100
opt.ignorecase    = true
opt.smartcase     = true
opt.wildignore    = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**';
opt.wildignorecase= true
opt.expandtab     = true
opt.shiftwidth    = 0
opt.tabstop       = 2
opt.shiftwidth    = 0
opt.tabstop       = 2
opt.swapfile      = false

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
