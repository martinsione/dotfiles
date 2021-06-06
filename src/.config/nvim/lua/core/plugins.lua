local packer_path = utils.os.data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd 'packadd packer.nvim | au BufWritePost plugins.lua PackerCompile'

local packer = require('packer')
local plugin_path = utils.os.data .. '/site/pack/packer/opt/'

return packer.startup(function(use)
  packer.init({compile_path = utils.os.data .. '/site/plugin/packer_compiled.vim', opt_default = true})

  -- Plugin Manager
  use 'wbthomason/packer.nvim'
  -- Autopairs
  use 'windwp/nvim-autopairs'
  -- Bufferline
  use 'akinsho/nvim-bufferline.lua'
  -- Colorizer
  use 'norcalli/nvim-colorizer.lua'
  -- Colorschemes
  use {'ChristianChiarulli/nvcode-color-schemes.vim', 'glepnir/zephyr-nvim'}
  -- Comments
  use 'tpope/vim-commentary'
  -- Dashboard
  use 'glepnir/dashboard-nvim'
  -- File explorer
  use 'kyazdani42/nvim-tree.lua'
  -- Git
  use {'tpope/vim-fugitive', 'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  -- Indentline
  use 'lukas-reineke/indent-blankline.nvim'
  -- Lsp
  use {
    'neovim/nvim-lspconfig', 'kabouzeid/nvim-lspinstall', 'hrsh7th/nvim-compe', 'glepnir/lspsaga.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
  }
  -- Profiling
  use 'tweekmonster/startuptime.vim'
  -- Statusline
  use 'glepnir/galaxyline.nvim'
  -- Surround
  use 'tpope/vim-surround'
  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
  }
  -- Terminal
  use 'akinsho/nvim-toggleterm.lua'
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter', 'p00f/nvim-ts-rainbow', 'windwp/nvim-ts-autotag',
    'JoosepAlviste/nvim-ts-context-commentstring',
  }

  -- Autoinstall/compile  plugins
  if vim.fn.isdirectory(vim.fn.glob(plugin_path)) > 0 then packer.install() end
  if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then packer.compile() end
end)
