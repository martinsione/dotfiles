G = {}
local os_name = vim.loop.os_uname().sysname

function G:load_variables()
  self.os_name      = os_name
  self.is_mac       = os_name == 'Darwin'
  self.is_linux     = os_name == 'Linux'
  self.is_windows   = os_name == 'Windows'
  self.vim_path     = vim.fn.stdpath('config')
  self.cache_dir    = vim.fn.stdpath('cache')
  self.home         = os.getenv("HOME")
end

G:load_variables()

return G
