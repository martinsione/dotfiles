
-- Helper Function {{{
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end -- Must replce single \ for \\ otherwise it is taken as a escape character
-- }}}

-- Leader
vim.g.mapleader   = " "

-- Normal: {{{

map('n', '<C-s>',       '<cmd>w<CR>')
map('n', '<CR>',        '{-> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', {expr = true})
map('n', 'Q',           '<Nop>')
map('n', 'Y',           'y$')

-- Buffers
map('n',  '<Tab>',      '<cmd>bnext<CR>')
map('n',  '<S-Tab>',    '<cmd>bprevious<CR>')
map('n',  '<space>bd',  '<cmd>bd<CR>')

-- Window Navigation
map('n',  '<C-h>',      '<C-\\><C-N><C-w>h')
map('n',  '<C-j>',      '<C-\\><C-N><C-w>j')
map('n',  '<C-k>',      '<C-\\><C-N><C-w>k')
map('n',  '<C-l>',      '<C-\\><C-N><C-w>l')

-- Window Resizing
map('n',  '<Up>',       '<C-w>-')
map('n',  '<Down>',     '<C-w>+')
map('n',  '<Left>',     '<C-w><')
map('n',  '<Right>',    '<C-w>>')
map('n',  '<space>=',   '<C-w>=')

-- Lsp
map('n',  'K',          '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
map('n',  'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n',  'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n',  'gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
map('n',  '<space>ca',  '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n',  '<space>gh',  '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n',  '<space>rn',  '<cmd>lua require("lspsaga.rename").rename()<CR>')

-- Telescope
map('n',  '<space>p',   '<Nop>')
map('n',  '<C-p>',     	'<cmd>lua require("telescope.builtin").find_files()<CR>')
map('n',  '<space>pr',	'<cmd>lua require("telescope.builtin").oldfiles()<CR>')
map('n',  '<space>pw',	'<cmd>lua require("telescope.builtin").live_grep()<CR>')
map('n',  '<space>pb',	'<cmd>lua require("telescope.builtin").buffers()<CR>')
map('n',  '<space>ph',	'<cmd>lua require("telescope.builtin").help_tags()<CR>')
map('n',  '<space>gf',	'<cmd>lua require("telescope.builtin").git_files()<CR>')
map('n',  '<space>gs',  '<cmd>lua require("telescope.builtin").git_status()<CR>')
map('n',  '<space>gc',  '<cmd>lua require("telescope.builtin").git_commits()<CR>')
map('n',  '<space>pd',	'<cmd>lua require("plugin.telescope").edit_dotfiles()<CR>')

-- Tree
map('n',  '<C-n>',      '<cmd>NvimTreeToggle<CR>')
map('n',  '<C-t>',      '<cmd>call TerminalToggle()<CR>')
map('n',  '<space>tt',  '<cmd>call Toggle_transparent_background()<CR>')
-- }}}

-- Insert: {{{

map('i', '<C-c>', '<esc>')

-- Tab completion
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

-- Jump up/down a line
map('i', '<S-CR>', '<C-O>o')
map('i', '<C-CR>', '<C-O>O')

-- Window Navigation
map('i',  '<C-h>',      '<C-\\><C-N><C-w>h')
map('i',  '<C-j>',      '<C-\\><C-N><C-w>j')
map('i',  '<C-k>',      '<C-\\><C-N><C-w>k')
map('i',  '<C-l>',      '<C-\\><C-N><C-w>l')
-- }}}

-- Visual: {{{

map('x',  '<',          '<gv')
map('x',  '>',          '>gv')
map('x',  'K',          ":move '<-2<CR>gv-gv")
map('x',  'J',          ":move '>+1<CR>gv-gv")
-- }}}

-- Terminal: {{{

map('t',  '<C-t>',       '<C-\\><C-N>:call TerminalToggle()<CR>')

-- Window Navigation
map('t',  '<C-w>h',      '<C-\\><C-N><C-w>h')
map('t',  '<C-w>j',      '<C-\\><C-N><C-w>j')
map('t',  '<C-w>k',      '<C-\\><C-N><C-w>k')
map('t',  '<C-w>l',      '<C-\\><C-N><C-w>l')
map('t',  '<C-w><C-h>',  '<C-\\><C-N><C-w>h')
map('t',  '<C-w><C-j>',  '<C-\\><C-N><C-w>j')
map('t',  '<C-w><C-k>',  '<C-\\><C-N><C-w>k')
map('t',  '<C-w><C-l>',  '<C-\\><C-N><C-w>l')
-- }}}

-- Command: {{{

-- Expand current file
vim.cmd[[cnoremap %P <C-R>=expand('%:p')<CR>]]

vim.cmd[[cnoremap <C-a> <Home>]]
vim.cmd[[cnoremap <C-e> <End>]]
vim.cmd[[cnoremap <C-h> <Left>]]
vim.cmd[[cnoremap <C-l> <Right>]]
vim.cmd[[cnoremap <C-d> <Del>]]

vim.cmd[[command! PackerDelete :silent !rm  -rf ~/.local/share/nvim/site/pack/packer <CR>]]
vim.cmd[[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]]
-- }}}
