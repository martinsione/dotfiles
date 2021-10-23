local o = vim.opt
local map = require('core.utils').keymap.map

vim.opt.rtp:remove(vim.fn.stdpath 'data' .. '/site')
vim.opt.rtp:remove(vim.fn.stdpath 'data' .. '/site/after')
vim.cmd [[let &packpath = &runtimepath]]
-- vim.cmd [[silent! packadd vim-surround]]
o.backup = false
o.writebackup = false
o.swapfile = false
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.virtualedit = 'block'
o.clipboard = 'unnamedplus'
o.iskeyword = o.iskeyword + '-'

vim.g.mapleader = ' '
map('n', '<leader>', '<Nop>')
map('x', '<leader>', '<Nop>')

map('n', 'Q', '<Nop>')
map('n', 'q:', '<Nop>')
map('n', '<C-c>', '<Esc>')
map('n', 'Y', 'y$')
map('n', '<CR>', '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })
map('n', 'x', '"_x')
map('n', 'X', '"_X')

map('x', '<', '<gv')
map('x', '>', '>gv')
map('x', 'K', ":move '<-2<CR>gv-gv")
map('x', 'J', ":move '>+1<CR>gv-gv")

-- Better navigation
map('n', '<C-j>', '<cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>')
map('n', '<C-k>', '<cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>')
map('n', '<C-h>', '<cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
map('n', '<C-l>', '<cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>')

-- map('n', 'K', '<cmd>call VSCodeNotify("editor.action.showHover")<CR>')
-- map('n', '<space>gr', '<cmd>call VSCodeNotify("editor.action.goToReferences")<CR>')
-- map('n', '<space>qf', '<cmd>call VSCodeNotify("editor.action.quickFix")<CR>')
-- map('n', '<space>gd', '<cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>')
-- map('n', '<C-w>gd', '<cmd>call VSCodeNotify("editor.action.revealDefinitionAside")<CR>')

-- Buffers
map('n', '<space>bd', '<cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>')
map('n', '<space>bu', '<cmd>call VSCodeNotify("workbench.action.reopenClosedEditor")<CR>')
map('n', '<TAB>', '<cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>')
map('n', '<S-TAB>', '<cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>')

-- Commentary
map('x', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
map('n', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
map('o', 'gc', '<Plug>VSCodeCommentary', { noremap = false })
map('n', 'gcc', '<Plug>VSCodeCommentaryLine', { noremap = false })

-- General
map('n', '<space>.', '<cmd>call VSCodeNotify("workbench.action.openSettingsJson")<CR>')
map('n', '<space>;', '<cmd>call VSCodeNotify("workbench.action.showCommands")<CR>')
map('n', '<space>z', '<cmd>call VSCodeNotify("workbench.action.toggleZenMode")<CR>')

-- Show
map('n', '<space>sd', '<cmd>call VSCodeNotify("workbench.debug.action.toggleRepl")<CR>')
map('n', '<space>se', '<cmd>call VSCodeNotify("workbench.view.explorer")<CR>')
map('n', '<space>sg', '<cmd>call VSCodeNotify("workbench.view.scm")<CR>')

-- Open
map('n', '<space>od', '<cmd>call VSCodeNotify("workbench.action.files.openFolder")<CR>')
map('n', '<space>or', '<cmd>call VSCodeNotify("workbench.action.openRecent")<CR>')

vim.cmd [[
  augroup highlight_yank
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 150 }
  augroup END
]]
