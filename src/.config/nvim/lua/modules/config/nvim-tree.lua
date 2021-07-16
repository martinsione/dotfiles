return function()
    local tree_cb = require('nvim-tree.config').nvim_tree_callback

    vim.g.nvim_tree_side = 'right'
    vim.g.nvim_tree_width = 30
    vim.g.nvim_tree_ignore = {
        '.git',
        'node_modules',
        '.cache',
        '.next',
        '*.out',
    }
    vim.g.nvim_tree_auto_ignore_ft = { 'dashboard' }
    vim.g.nvim_tree_auto_open = 0
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_hide_dotfiles = 0
    vim.g.nvim_tree_indent_markers = 0
    vim.g.nvim_tree_bindings = {
        { key = 'h', cb = tree_cb('close_node') },
        { key = 'l', cb = tree_cb('edit') },
        { key = 'v', cb = tree_cb('vsplit') },
        { key = 's', cb = tree_cb('split') },
    }
end
