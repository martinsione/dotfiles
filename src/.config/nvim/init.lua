require 'core.utils'

if vim.fn.exists 'g:vscode' == 1 then
  vim.opt.rtp:remove(get_data_dir() .. '/site')
  vim.opt.rtp:remove(get_data_dir() .. '/site/after')
  vim.cmd [[let &packpath = &runtimepath]]
  require 'vscode'
else
  require('modules'):init()
  require('modules'):load(require 'modules.plugins')
  require 'core.options'
  require 'core.keymaps'
  require 'core.autocmd'
  vim.cmd 'colorscheme darkplus'
end
