vim.g.nvim_tree_side = 'right'
vim.g.nvim_tree_width = 35
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_bindings = {
  ["h"] = ":lua require'nvim-tree'.on_keypress('close_node')<CR>",
  ["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
  ["v"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
  ["s"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
}
vim.g.nvim_tree_icons = {
  default =  '',
  symlink =  '',
  git = {
   unstaged = "✚",
   staged =  "✚",
   unmerged =  "≠",
   renamed =  "≫",
   untracked = "",
  },
}
