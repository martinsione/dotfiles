vim.cmd [[packadd nvim-ts-rainbow]]
require'nvim-treesitter.configs'.setup {
  highlight = {enable = true},
  ensure_installed = 'maintained',
  rainbow = {enable = true}
}
