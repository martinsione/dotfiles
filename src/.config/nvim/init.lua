-- Set explicitly: terminal (OSC 11) detection reports light through tmux on the dark devbox
if vim.uv.os_uname().sysname == "Darwin" then
  local output = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  vim.o.background = output:match("Dark") and "dark" or "light"
else
  vim.o.background = "dark"
end

vim.cmd.colorscheme("vercel")

require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
