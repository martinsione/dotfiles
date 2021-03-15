
vim.g.mapleader = ' '
nmap('<leader>',  '')
xmap('<leader>',  '')


-- All modes
-- Window Navigation
amap('<C-h>',       '<cmd>wincmd h<CR>')
amap('<C-j>',       '<cmd>wincmd j<CR>')
amap('<C-k>',       '<cmd>wincmd k<CR>')
amap('<C-l>',       '<cmd>wincmd l<CR>')
-- Window Resizing
amap('<Up>',        '<cmd>wincmd -<CR>')
amap('<Down>',      '<cmd>wincmd +<CR>')
amap('<Left>',      '<cmd>wincmd <<CR>')
amap('<Right>',     '<cmd>wincmd ><CR>')
amap('<space>=',    '<cmd>wincmd =<CR>')


-- Normal
nmap('<C-s>',       '<cmd>w<CR>')
nmap('<CR>',        '{-> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', {expr = true})
nmap('Q',           '<Nop>')
nmap('q:',          '<Nop>')
nmap('Y',           'y$')
-- Stands for yank inside line
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
