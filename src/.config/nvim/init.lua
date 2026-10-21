-- 'background' is detected from the terminal (OSC 11); the colorscheme re-applies when it changes
vim.cmd.colorscheme("vercel")

require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
