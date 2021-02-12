require('colorbuddy')

local c = require('colorbuddy.color').colors
local Group = require('colorbuddy.group').Group

Color.new('GitSignsAdd',    '#00ff00')
Color.new('GitSignsChange', '#ffff00')
Color.new('GitSignsDelete', '#ff0000')
Group.new('GitSignsAdd',    c.GitSignsAdd)
Group.new('GitSignsChange', c.GitSignsChange)
Group.new('GitSignsDelete', c.GitSignsDelete)

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr'},
    changedelete = {hl = 'GitSignsDelete', text = '~', numhl='GitSignsChangeNr'},
  },
  numhl = false,
  keymaps = {
    noremap = true,
    buffer = true,

    ['n <space>hd'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n <space>hu'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    -- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    -- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    -- ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    -- ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    -- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  }
}
