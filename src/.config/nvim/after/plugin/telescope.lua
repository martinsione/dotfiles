local ok, telescope = pcall(require, 'telescope')
if not ok then
    return
end

telescope.setup {
    defaults = {
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
        layout_config = { horizontal = { preview_width = 0.5 } },
        file_ignore_patterns = { 'node_modules/.*' },
        mappings = {
            i = {
                ['<C-j>'] = "move_selection_next",
                ['<C-k>'] = "move_selection_previous"
            },
            n = { ['<C-c>'] = "close" },
        },
    },
}

-- local is_git_dir = os.execute 'git rev-parse --is-inside-work-tree >> /dev/null 2>&1'
-- if is_git_dir == 0 then
--     vim.keymap.set('n', '<C-p>', '<cmd>lua require"telescope.builtin".git_files()<CR>')
-- else
--     vim.keymap.set('n', '<C-p>', '<cmd>lua require"telescope.builtin".find_files()<CR>')
-- end
vim.keymap.set('n', '<C-p>', '<cmd>lua require"telescope.builtin".find_files()<CR>')
vim.keymap.set('n', '<space>fb', '<cmd>Telescope buffers theme=get_dropdown<CR>')
vim.keymap.set('n', '<space>fh', '<cmd>lua require"telescope.builtin".help_tags()<CR>')
vim.keymap.set('n', '<space>fo', '<cmd>lua require"telescope.builtin".oldfiles()<CR>')
vim.keymap.set('n', '<space>fw', '<cmd>lua require"telescope.builtin".live_grep()<CR>')
vim.keymap.set('n', '<space>fd', '<cmd>lua require"telescope.builtin".git_files({cwd = "$HOME/.dotfiles" })<CR>')
