vim.g.nvim_tree_side = 'right'
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache', '.next', '*.out'}
vim.g.nvim_tree_auto_ignore_ft = {'dashboard'}
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_bindings = {
  {key = 'h', cb = ':lua require"nvim-tree".on_keypress("close_node")<CR>'},
  {key = 'l', cb = ':lua require"nvim-tree".on_keypress("edit")<CR>'},
  {key = 'v', cb = ':lua require"nvim-tree".on_keypress("vsplit")<CR>'},
  {key = 's', cb = ':lua require"nvim-tree".on_keypress("split")<CR>'},
}
