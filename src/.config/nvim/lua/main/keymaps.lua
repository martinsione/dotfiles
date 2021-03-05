
-- Helper Function {{{
-- Must replace single \ for \\ otherwise it is taken as an escape character
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
  return map('n', lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
  return map('i', lhs, rhs, opts)
end

local function xmap(lhs, rhs, opts)
  return map('x', lhs, rhs, opts)
end

local function tmap(lhs, rhs, opts)
  return map('t', lhs, rhs, opts)
end

local function cmap(lhs, rhs)
  -- { silent } need to be false to work
  return map('c', lhs, rhs, { silent = false })
end
-- }}}

vim.g.mapleader = ' '
nmap('<leader>',  '')
xmap('<leader>',  '')


-- Normal
nmap('<C-s>',       '<cmd>w<CR>')
nmap('<CR>',        '{-> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', {expr = true})
nmap('Q',           '<Nop>')
nmap('Y',           'y$')
-- Stands for yank inside line
nmap('yil',         '0yg_')
-- Buffers
nmap('<Tab>',       '<cmd>bnext<CR>')
nmap('<S-Tab>',     '<cmd>bprevious<CR>')
nmap('<space>bd',   '<cmd>bd<CR>')
-- Window Navigation
nmap('<C-h>',       '<C-\\><C-N><C-w>h')
nmap('<C-j>',       '<C-\\><C-N><C-w>j')
nmap('<C-k>',       '<C-\\><C-N><C-w>k')
nmap('<C-l>',       '<C-\\><C-N><C-w>l')
-- Window Resizing
nmap('<Up>',        '<C-w>-')
nmap('<Down>',      '<C-w>+')
nmap('<Left>',      '<C-w><')
nmap('<Right>',     '<C-w>>')
nmap('<space>=',    '<C-w>=')
-- Lsp
nmap('K',           '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
nmap('gd',          '<cmd>lua vim.lsp.buf.definition()<CR>')
nmap('gi',          '<cmd>lua vim.lsp.buf.implementation()<CR>')
nmap('gr',          '<cmd>lua vim.lsp.buf.references()<CR>')
nmap('<space>ca',   '<cmd>lua vim.lsp.buf.code_action()<CR>')
nmap('<space>gh',   '<cmd>lua vim.lsp.buf.signature_help()<CR>')
nmap('<space>rn',   '<cmd>lua require("lspsaga.rename").rename()<CR>')
-- Telescope
nmap('<C-p>',       '<cmd>lua require("telescope.builtin").find_files()<CR>')
nmap('<space>pr',	  '<cmd>lua require("telescope.builtin").oldfiles()<CR>')
nmap('<space>pw',	  '<cmd>lua require("telescope.builtin").live_grep()<CR>')
nmap('<space>pb',	  '<cmd>lua require("telescope.builtin").buffers()<CR>')
nmap('<space>ph',	  '<cmd>lua require("telescope.builtin").help_tags()<CR>')
nmap('<space>pf',	  '<cmd>lua require("telescope.builtin").git_files()<CR>')
nmap('<space>ps',   '<cmd>lua require("telescope.builtin").git_status()<CR>')
nmap('<space>pc',   '<cmd>lua require("telescope.builtin").git_commits()<CR>')
nmap('<space>pd',	  '<cmd>lua require("plugin.telescope").edit_dotfiles()<CR>')
nmap('<space>pa',	  '<cmd>lua require("plugin.telescope").search_all_files()<CR>')
nmap('<space>pp',	  '<cmd>lua require("plugin.telescope").edit_plugins()<CR>')
-- Tree
nmap('<C-n>',       '<cmd>NvimTreeToggle<CR>')
-- Custom functions
nmap('<C-t>',       '<cmd>call TerminalToggle()<CR>')
nmap('<space>tt',   '<cmd>call Toggle_transparent_background()<CR>')


-- Insert
imap('<C-c>',       '<esc>')
-- Tab completion
imap('<S-Tab>',     'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
imap('<Tab>',       'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
imap('<CR>',        'compe#confirm("<CR>")', {expr = true})
-- Jump up/down a line
imap('<S-CR>',      '<C-O>o')
imap('<C-CR>',      '<C-O>O')
-- Window Navigation
imap('<C-h>',       '<C-\\><C-N><C-w>h')
imap('<C-j>',       '<C-\\><C-N><C-w>j')
imap('<C-k>',       '<C-\\><C-N><C-w>k')
imap('<C-l>',       '<C-\\><C-N><C-w>l')


-- Visual
xmap('<',           '<gv')
xmap('>',           '>gv')
xmap('K',           ":move '<-2<CR>gv-gv")
xmap('J',           ":move '>+1<CR>gv-gv")


-- Togle term
tmap('<C-t>',       '<C-\\><C-N>:call TerminalToggle()<CR>')
-- Window Navigation
tmap('<C-w>h',      '<C-\\><C-N><C-w>h')
tmap('<C-w>j',      '<C-\\><C-N><C-w>j')
tmap('<C-w>k',      '<C-\\><C-N><C-w>k')
tmap('<C-w>l',      '<C-\\><C-N><C-w>l')
tmap('<C-w><C-h>',  '<C-\\><C-N><C-w>h')
tmap('<C-w><C-j>',  '<C-\\><C-N><C-w>j')
tmap('<C-w><C-k>',  '<C-\\><C-N><C-w>k')
tmap('<C-w><C-l>',  '<C-\\><C-N><C-w>l')


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
cmap('%P',          '<C-R>=expand("%:p")<CR>')

vim.cmd[[command! PackerDelete :silent !rm  -rf ~/.local/share/nvim/site/pack/packer <CR>]]
vim.cmd[[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]]
