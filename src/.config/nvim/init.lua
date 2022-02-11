if vim.fn.exists 'g:vscode' == 1 then
  require 'vscode'
else
  require 'core.utils'
  require 'modules'
  require 'core.options'
  require 'core.keymaps'
  require 'core.autocmd'
  -- vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
  vim.cmd 'silent! colorscheme onedarkpro'
end
