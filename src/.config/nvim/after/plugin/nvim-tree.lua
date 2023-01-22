local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

nvim_tree.setup({
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = false,
            },
        },
    },
    view = {
        width = 50,
        hide_root_folder = true,
        side = 'right',
        signcolumn = 'yes',
        mappings = {
            custom_only = true, -- `custom_only = false` will merge list of mappings with defaults
            list = {
                { key = '<C-R>', action = 'refresh' },
                { key = 'a', action = 'create' },
                { key = 'd', action = 'remove' },
                { key = 'h', action = 'close_node' },
                { key = 'I', action = 'toggle_ignored' },
                { key = 'l', action = 'edit' },
                { key = 'r', action = 'rename' },
                { key = 's', action = 'split' },
                { key = 'v', action = 'vsplit' },
                { key = 'Y', action = 'copy_path' },
                { key = 'y', action = 'copy_name' },
            },
        },
    },
})

vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
