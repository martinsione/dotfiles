local nmap = utils.keymap.nmap
local imap = utils.keymap.imap
local tmap = utils.keymap.tmap
local cmap = utils.keymap.cmap
local xmap = utils.keymap.xmap

vim.g.mapleader = ' '
nmap('<leader>', '<Nop>')
xmap('<leader>', '<Nop>')

-- Normal
nmap('Q', '<Nop>')
nmap('q:', '<Nop>')
nmap('<C-c>', '<Esc>')
nmap('Y', 'y$')
nmap('yil', '0y$')
nmap('<CR>', '{-> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', {expr = true})
nmap('<C-s>', '<cmd>w<CR>')
-- Buffers
nmap('<Tab>', '<cmd>Telescope buffers<CR>')
nmap('<space>bd', '<cmd>bd<CR>')
-- Window
nmap('<C-h>', '<cmd>wincmd h<CR>')
nmap('<C-j>', '<cmd>wincmd j<CR>')
nmap('<C-k>', '<cmd>wincmd k<CR>')
nmap('<C-l>', '<cmd>wincmd l<CR>')
nmap('<Up>', '<cmd>wincmd -<CR>')
nmap('<Down>', '<cmd>wincmd +<CR>')
nmap('<Left>', '<cmd>wincmd <<CR>')
nmap('<Right>', '<cmd>wincmd ><CR>')
nmap('<space>=', '<cmd>wincmd =<CR>')

-- Insert
imap('<C-c>', '<Esc>')
imap('<S-CR>', '<Esc>o')
imap('<C-CR>', '<Esc>O')
imap('<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
imap('<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
imap('<CR>', 'v:lua.utils.completion_confirm()', {expr = true})

-- Visual
xmap('<', '<gv')
xmap('>', '>gv')
xmap('K', ':move \'<-2<CR>gv-gv')
xmap('J', ':move \'>+1<CR>gv-gv')

-- Terminal
tmap('<C-w>h', '<cmd>wincmd h<CR>')
tmap('<C-w>j', '<cmd>wincmd j<CR>')
tmap('<C-w>k', '<cmd>wincmd k<CR>')
tmap('<C-w>l', '<cmd>wincmd l<CR>')
tmap('<C-w><C-h>', '<cmd>wincmd h<CR>')
tmap('<C-w><C-j>', '<cmd>wincmd j<CR>')
tmap('<C-w><C-k>', '<cmd>wincmd k<CR>')
tmap('<C-w><C-l>', '<cmd>wincmd l<CR>')

-- Command
cmap('<C-a>', '<Home>')
cmap('<C-e>', '<End>')
cmap('<C-h>', '<Left>')
cmap('<C-j>', '<Down>')
cmap('<C-k>', '<Up>')
cmap('<C-l>', '<Right>')
cmap('<C-d>', '<Del>')
cmap('<C-f>', '<C-R>=expand("%:p")<CR>')

-- Git
nmap('<space>gs', '<cmd>G<CR>')
-- Telescope
if utils.os.is_git_dir == 0 then
  nmap('<C-p>', '<cmd>Telescope git_files<CR>')
else
  nmap('<C-p>', '<cmd>Telescope find_files<CR>')
end
nmap('<space>fb', '<cmd>Telescope buffers<CR>')
nmap('<space>fh', '<cmd>Telescope help_tags<CR>')
nmap('<space>fr', '<cmd>Telescope oldfiles<CR>')
nmap('<space>fw', '<cmd>Telescope live_grep<CR>')
nmap('<space>fd', '<cmd>lua require("plugin.telescope").find_dotfiles()<CR>')
nmap('<space>fa', '<cmd>lua require("plugin.telescope").find_all_files()<CR>')
-- Tree
nmap('<C-n>', '<cmd>NvimTreeToggle<CR>')
-- Toggle background
nmap('<space>bg', '<cmd>call Toggle_transparent_background()<CR>')
-- Vim surround ( noremap need to be false to work)
nmap('ds', '<Plug>Dsurround', {noremap = false})
nmap('cs', '<Plug>Csurround', {noremap = false})
nmap('cS', '<Plug>CSurround', {noremap = false})
nmap('s', '<Plug>Ysurround', {noremap = false})
nmap('S', '<Plug>YSurround', {noremap = false})
nmap('ss', '<Plug>Yssurround', {noremap = false})
nmap('SS', '<Plug>YSsurround', {noremap = false})
xmap('s', '<Plug>VSurround', {noremap = false})
xmap('S', '<Plug>VgSurround', {noremap = false})
-- Nvim miniyank
nmap('p', '<Plug>(miniyank-autoput)', {noremap = false})
nmap('P', '<Plug>(miniyank-autoPut)', {noremap = false})
nmap('<leader>p', '<Plug>(miniyank-startput)', {noremap = false})
nmap('<leader>P', '<Plug>(miniyank-startPut)', {noremap = false})
nmap(']a', '<Plug>(miniyank-cycle)', {noremap = false})
nmap('[a', '<Plug>(miniyank-cycleback)', {noremap = false})
nmap('<Leader>c', '<Plug>(miniyank-tochar)', {noremap = false})
nmap('<Leader>l', '<Plug>(miniyank-toline)', {noremap = false})
nmap('<Leader>b', '<Plug>(miniyank-toblock)', {noremap = false})

vim.cmd [[command! PackerDelete :silent !rm  -rf ~/.local/share/nvim/site <CR>]]
vim.cmd [[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]]
