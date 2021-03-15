G = {}
local os_name = vim.loop.os_uname().sysname

function G:load_variables()
  self.os_name      = os_name
  self.is_mac       = os_name == 'Darwin'
  self.is_linux     = os_name == 'Linux'
  self.is_windows   = os_name == 'Windows'
  self.home         = os.getenv("HOME")
end

local disable_builtin_plugins = function()
  vim.g.loaded_gzip              = 1
  vim.g.loaded_tar               = 1
  vim.g.loaded_tarPlugin         = 1
  vim.g.loaded_zip               = 1
  vim.g.loaded_zipPlugin         = 1
  vim.g.loaded_getscript         = 1
  vim.g.loaded_getscriptPlugin   = 1
  vim.g.loaded_vimball           = 1
  vim.g.loaded_vimballPlugin     = 1
  vim.g.loaded_matchit           = 1
  vim.g.loaded_matchparen        = 1
  vim.g.loaded_2html_plugin      = 1
  vim.g.loaded_logiPat           = 1
  vim.g.loaded_rrhelper          = 1
  vim.g.loaded_netrw             = 1
  vim.g.loaded_netrwPlugin       = 1
  vim.g.loaded_netrwSettings     = 1
  vim.g.loaded_netrwFileHandlers = 1
end

disable_builtin_plugins()
G:load_variables()
require('core.utils')
require('core.plugins')
require('core.options')
require('core.keymaps')
colorscheme('nvcode')
