local load_plugins = function()
  local plugin_require = utils.plugin.require
  -- Dependencies
  plugin_require('plenary.nvim')
  plugin_require('popup.nvim')
  -- Icons
  plugin_require('nvim-web-devicons')
  -- Autopairs
  plugin_require('nvim-autopairs')
  -- Bufferline
  plugin_require('nvim-bufferline.lua')
  -- Colorizer
  plugin_require('nvim-colorizer.lua')
  -- Comments
  plugin_require('vim-commentary')
  -- Dashboard
  plugin_require('dashboard-nvim')
  -- File explorer
  plugin_require('nvim-tree.lua')
  -- Git
  plugin_require('gitsigns.nvim')
  plugin_require('vim-fugitive')
  -- Indentline
  plugin_require('indent-blankline.nvim')
  -- Lsp
  plugin_require('nvim-lspinstall')
  plugin_require('nvim-lspconfig')
  plugin_require('nvim-compe')
  plugin_require('nvim-lsp-ts-utils')
  plugin_require('lspsaga.nvim')
  -- Profiling
  plugin_require('startuptime.vim')
  -- Statusline
  plugin_require('galaxyline.nvim')
  -- Surround
  plugin_require('vim-surround')
  -- Telescope
  plugin_require('telescope.nvim')
  plugin_require('telescope-fzy-native.nvim')
  -- Terminal
  plugin_require('nvim-toggleterm.lua')
  -- Treesitter
  plugin_require('nvim-treesitter')
  plugin_require('nvim-ts-rainbow')
  plugin_require('nvim-ts-autotag')
  -- plugin_require('nvim-ts-context-commentstring')
end

require('core.utils')
require('core.plugins')
load_plugins()
require('core.keymaps')
require('core.options')

utils.colorscheme('nvcode')
