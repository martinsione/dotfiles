local opts = { noremap = true, silent = true }
vim.api.nvim_buf_set_keymap(0, 'n', 'j', 'gj', opts)
vim.api.nvim_buf_set_keymap(0, 'n', 'k', 'gk', opts)
