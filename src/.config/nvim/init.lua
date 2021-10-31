if vim.fn.exists 'g:vscode' == 1 then
  require 'vscode'
else
  require 'core.utils'
  require('modules'):init()
  require('modules'):load(require 'modules.plugins')
  require 'core.options'
  require 'core.keymaps'
  require 'core.autocmd'
  -- vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
  vim.cmd 'colorscheme tokyonight'
end
