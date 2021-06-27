local packer_path = U.os.data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd 'packadd packer.nvim | au BufWritePost plugins.lua PackerCompile'
vim.opt.rtp = vim.opt.rtp + '~/.local/share/nvim/site/pack/packer/opt/*'

local packer = require('packer')
local plugin_path = U.os.data .. '/site/pack/packer/opt/'
local packer_compiled = U.os.data .. '/site/plugin/packer_compiled.vim'

return packer.startup(function(use)
  packer.init({compile_path = packer_compiled, opt_default = true})

  -- Plugin Manager
  use 'wbthomason/packer.nvim'
  -- Autopairs
  use {'windwp/nvim-autopairs', setup = [[require('plugin.nvim-autopairs')]]}
  -- Buffer Tabs
  use {'akinsho/nvim-bufferline.lua', setup = [[require('plugin.nvim-bufferline')]]}
  -- Colorizer
  use {'norcalli/nvim-colorizer.lua', setup = [[require('plugin.nvim-colorizer')]]}
  -- Colorschemes
  use {
    'ChristianChiarulli/nvcode-color-schemes.vim', 'glepnir/zephyr-nvim', 'folke/tokyonight.nvim',
  }
  -- Completion
  use {
    {'hrsh7th/nvim-compe', setup = [[require('plugin.nvim-compe')]], event = 'InsertEnter'},
    -- Snippets
    {'hrsh7th/vim-vsnip', event = 'InsertEnter', requires = {use 'rafamadriz/friendly-snippets'}},
  }
  -- Comments
  use 'tpope/vim-commentary'
  -- Dashboard
  use {'glepnir/dashboard-nvim', setup = [[require('plugin.dashboard-nvim')]]}
  -- File explorer
  use {'kyazdani42/nvim-tree.lua', setup = [[require('plugin.nvim-tree')]]}
  -- Git
  use 'tpope/vim-fugitive'
  use {'lewis6991/gitsigns.nvim', setup = [[require('plugin.gitsigns')]]}
  -- Icons
  use {'kyazdani42/nvim-web-devicons', setup = [[require('plugin.nvim-web-devicons')]]}
  -- Indentline
  use {
    'lukas-reineke/indent-blankline.nvim',
    branch = 'lua',
    setup = [[require('plugin.indent-blankline')]],
  }
  -- Lsp
  use {
    'neovim/nvim-lspconfig',
    setup = [[require('plugin.nvim-lspconfig')]],
    requires = {
      'kabouzeid/nvim-lspinstall', 'glepnir/lspsaga.nvim', 'jose-elias-alvarez/nvim-lsp-ts-utils',
    },
  }
  -- Profiling
  use 'tweekmonster/startuptime.vim'
  -- Statusline
  use {'glepnir/galaxyline.nvim', setup = [[require('plugin.galaxyline')]]}
  -- Surround
  use 'tpope/vim-surround'
  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    setup = [[require('plugin.telescope')]],
    requires = {
      'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim',
    },
  }
  -- Terminal
  use {'akinsho/nvim-toggleterm.lua', setup = [[require('plugin.nvim-toggleterm')]]}
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    setup = [[require('plugin.nvim-treesitter')]],
    requires = {
      'p00f/nvim-ts-rainbow', 'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  }
  -- Which Key
  use {'folke/which-key.nvim', setup = [[require('plugin.which-key')]]}

  -- Autoinstall/compile plugins
  if vim.fn.isdirectory(vim.fn.glob(plugin_path)) > 0 then packer.install() end
  if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then packer.compile() end
end)
