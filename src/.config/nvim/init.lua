local system = vim.uv.os_uname().sysname
if system == "Darwin" then
  local output = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  vim.o.background = (output and string.match(output, "Dark")) and "dark" or "light"
else
  vim.o.background = "dark"
end

vim.cmd.colorscheme("vercel")

require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
