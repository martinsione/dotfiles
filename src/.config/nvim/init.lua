if vim.fn.exists 'g:vscode' == 1 then
  require 'vscode'
else
  require 'modules'
  require 'core.options'
  require 'core.keymaps'
  require 'core.autocmd'
  require 'modules.config.colors'
end
