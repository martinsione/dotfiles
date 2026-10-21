-- Elsewhere 'background' comes from the terminal (OSC 11); through tmux that needs a current
-- tmux server (3.8+) and freshly attached clients, or it reports a stale theme
if vim.uv.os_uname().sysname == "Darwin" then
  local output = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  vim.o.background = output:match("Dark") and "dark" or "light"
end

vim.cmd.colorscheme("vercel")

require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
