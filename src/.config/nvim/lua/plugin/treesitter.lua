vim.cmd [[packadd nvim-ts-rainbow | packadd nvim-ts-context-commentstring]]
require'nvim-treesitter.configs'.setup {
  highlight = {enable = true},
  ensure_installed = 'maintained',
  rainbow = {enable = true},
  autotag = {enable = true},
  context_commentstring = {enable = true}
}
