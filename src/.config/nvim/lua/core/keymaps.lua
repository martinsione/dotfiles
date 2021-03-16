
vim.g.mapleader = ' '
nmap('<leader>',  '')
xmap('<leader>',  '')


-- Window Navigation
wmap('n', '<C-h>',    'h')
wmap('n', '<C-j>',    'j')
wmap('n', '<C-k>',    'k')
wmap('n', '<C-l>',    'l')
-- Window Resizing
wmap('n', '<Up>',     '-')
wmap('n', '<Down>',   '+')
wmap('n', '<Left>',   '<')
wmap('n', '<Right>',  '>')
wmap('n', '<space>=', '=')
-- Terminal window navigation
wmap('t', '<C-w>h',   'h')
wmap('t', '<C-w>j',   'j')
wmap('t', '<C-w>k',   'k')
wmap('t', '<C-w>l',   'l')
wmap('t', '<C-w><C-h>',  'h')
wmap('t', '<C-w><C-j>',  'j')
wmap('t', '<C-w><C-k>',  'k')
wmap('t', '<C-w><C-l>',  'l')


-- Normal
nmap('<C-s>',       '<cmd>w<CR>')
nmap('<CR>',        '{-> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', {expr = true})
nmap('Q',           '<Nop>')
nmap('q:',          '<Nop>')
nmap('Y',           'y$')
nmap('yil',         '0y$')
-- Buffers
nmap('<Tab>',       '<cmd>bnext<CR>')
nmap('<S-Tab>',     '<cmd>bprevious<CR>')
nmap('<space>bd',   '<cmd>bd<CR>')

-- Insert
imap('<C-c>',       '<esc>')
-- Tab completion
imap('<S-Tab>',     'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
imap('<Tab>',       'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
-- Jump up/down a line
imap('<S-CR>',      '<C-O>o')
imap('<C-CR>',      '<C-O>O')

-- Visual
xmap('<',           '<gv')
xmap('>',           '>gv')
xmap('K',           ":move '<-2<CR>gv-gv")
xmap('J',           ":move '>+1<CR>gv-gv")


-- Command
cmap('<C-f>',       '')
cmap('<C-a>',       '<Home>')
cmap('<C-e>',       '<End>')
cmap('<C-h>',       '<Left>')
cmap('<C-j>',       '<Down>')
cmap('<C-k>',       '<Up>')
cmap('<C-l>',       '<Right>')
cmap('<C-d>',       '<Del>')
-- Expand current file
cmap('<C-t>',       '<C-R>=expand("%:p")<CR>')


-- Vim surround ( noremap need to be false to work)
nmap('ds',  '<Plug>Dsurround',  {noremap =false})
nmap('cs',  '<Plug>Csurround',  {noremap =false})
nmap('cS',  '<Plug>CSurround',  {noremap =false})
nmap('s',   '<Plug>Ysurround',  {noremap =false})
nmap('S',   '<Plug>YSurround',  {noremap =false})
nmap('ss',  '<Plug>Yssurround', {noremap =false})
nmap('SS',  '<Plug>YSsurround', {noremap =false})
xmap('s',   '<Plug>VSurround',  {noremap =false})
xmap('S',   '<Plug>VgSurround', {noremap =false})
-- Telescope
nmap('<C-p>',       '<cmd>lua require("telescope.builtin").find_files()<CR>')
nmap('<space>pr',   '<cmd>lua require("telescope.builtin").oldfiles()<CR>')
nmap('<space>pw',   '<cmd>lua require("telescope.builtin").live_grep()<CR>')
nmap('<space>pb',   '<cmd>lua require("telescope.builtin").buffers()<CR>')
nmap('<space>ph',   '<cmd>lua require("telescope.builtin").help_tags()<CR>')
nmap('<space>pf',   '<cmd>lua require("telescope.builtin").git_files()<CR>')
nmap('<space>ps',   '<cmd>lua require("telescope.builtin").git_status()<CR>')
nmap('<space>pc',   '<cmd>lua require("telescope.builtin").git_commits()<CR>')
nmap('<space>pd',   '<cmd>lua require("plugin.telescope").edit_dotfiles()<CR>')
-- Toggle background
nmap('<space>bg',   '<cmd>call Toggle_transparent_background()<CR>')
-- Togle term
nmap('<C-t>',       '<cmd>call TerminalToggle()<CR>')
tmap('<C-t>',       '<cmd>call TerminalToggle()<CR>')
-- Tree
nmap('<C-n>',       '<cmd>NvimTreeToggle<CR>')

vim.cmd[[command! PackerDelete :silent !rm  -rf ~/.local/share/nvim/site/pack/packer <CR>]]
vim.cmd[[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]]
