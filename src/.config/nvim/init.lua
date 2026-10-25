-- 'background' comes from the terminal (OSC 11) and follows its theme changes (DEC mode 2031);
-- through tmux that needs a current tmux server (3.8+) and freshly attached clients, or it
-- reports a stale theme. Don't set it here: that disables nvim's detection entirely
vim.cmd.colorscheme("vercel")

require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")
