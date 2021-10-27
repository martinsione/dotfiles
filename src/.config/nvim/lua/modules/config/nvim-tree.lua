return function()
  local ok, nvim_tree = safe_require 'nvim-tree'
  if not ok then
    return
  end

  local map = require('nvim-tree.config').nvim_tree_callback
  vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', '.next', '*.out' }

  nvim_tree.setup {
    ignore_ft_on_setup = { 'dashboard' }, -- will not open on setup if the filetype is in this list
    -- -- TODO: Fix "update_focused_file"
    -- update_focused_file = { enable = true },
    view = {
      width = 35,
      side = 'right',
      hide_root_folder = true,
      mappings = {
        custom_only = true, -- `custom_only = false` will merge list of mappings with defaults
        list = {
          { key = '<C-R>', cb = map 'refresh' },
          { key = 'a', cb = map 'create' },
          { key = 'd', cb = map 'remove' },
          { key = 'h', cb = map 'close_node' },
          { key = 'I', cb = map 'toggle_ignored' },
          { key = 'l', cb = map 'edit' },
          { key = 'r', cb = map 'rename' },
          { key = 's', cb = map 'split' },
          { key = 'v', cb = map 'vsplit' },
          { key = 'Y', cb = map 'copy_path' },
          { key = 'y', cb = map 'copy_name' },
        },
      },
    },
  }
end
