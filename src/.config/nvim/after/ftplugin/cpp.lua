local opts = { noremap = true, silent = true }
vim.api.nvim_buf_set_keymap(0, 'n', '<space>ts', '<cmd>0r ~/.config/nvim/after/skeleton/cpp<CR>', opts)
