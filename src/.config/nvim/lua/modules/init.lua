local utils = require 'core.utils'
local packer_repo = 'https://github.com/wbthomason/packer.nvim'
local packer_path = utils.os.data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  print 'Downloading plugin manager...'
  vim.cmd('silent! !git clone ' .. packer_repo .. ' ' .. packer_path)
end
vim.cmd 'packadd packer.nvim'
vim.opt.rtp:append(utils.os.data .. '/site/pack/packer/opt/*')

local packer = require 'packer'
return packer.startup(function(use)
  packer.init {
    compile_path = utils.os.data .. '/site/lua/packer_compiled.lua',
    opt_default = true,
    profile = { enable = true },
  }

  -- Plugin manager
  use { 'wbthomason/packer.nvim' }

  -----[[------------]]-----
  ---     UI Related     ---
  -----]]------------[[-----
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    setup = require 'modules.config.nvim-treesitter',
    requires = {
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  }

  -- Start Screen
  use {
    'glepnir/dashboard-nvim',
    setup = require 'modules.config.dashboard-nvim',
  }

  -- Colorschemes
  use { 'npxbr/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } }
  use { 'folke/tokyonight.nvim' }
  use { 'LunarVim/Colorschemes' }

  -- Icons
  use {
    'kyazdani42/nvim-web-devicons',
    setup = require 'modules.config.nvim-web-devicons',
  }

  -- File tree
  use {
    'kyazdani42/nvim-tree.lua',
    setup = require 'modules.config.nvim-tree',
  }

  -- Statusline
  use {
    'glepnir/galaxyline.nvim',
    setup = require 'modules.config.galaxyline',
  }

  -- Tabline
  use {
    'akinsho/nvim-bufferline.lua',
    setup = require 'modules.config.nvim-bufferline',
  }

  -- Indent Lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    setup = require 'modules.config.indent-blankline',
  }

  -----[[--------------]]-----
  ---     IDE features     ---
  -----]]--------------[[-----
  -- Autopairs
  use {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    setup = require 'modules.config.nvim-autopairs',
  }

  -- Commenting
  use { 'tpope/vim-commentary' }

  -- Should be in vim core...
  use { 'tpope/vim-surround', requires = { 'tpope/vim-repeat' } }

  -- Fuzzy finding / Ctrl + p
  use {
    'nvim-telescope/telescope.nvim',
    setup = require 'modules.config.telescope',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  -- -- TODO: Configure nvim-dap
  -- -- Debug
  -- use({
  --     'mfussenegger/nvim-dap',
  --     setup = require('nvim-dap'),
  --     requires = {
  --         { 'rcarriga/nvim-dap-ui' },
  --     },
  -- })

  -----[[-------------]]-----
  ---     GIT RELATED     ---
  -----]]-------------[[-----
  use {
    'lewis6991/gitsigns.nvim',
    setup = require 'modules.config.gitsigns',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'TimUntersberger/neogit',
    setup = require 'modules.config.neogit',
    requires = {
      { 'sindrets/diffview.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
  }

  -----[[------------]]-----
  ---     Completion     ---
  -----]]------------[[-----
  -- Built-in lsp
  use {
    'neovim/nvim-lspconfig',
    setup = require 'modules.config.nvim-lspconfig',
    requires = {
      { 'kabouzeid/nvim-lspinstall' },
      { 'ray-x/lsp_signature.nvim' },
      { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
    },
  }

  -- Completion plugin
  use {
    'hrsh7th/nvim-cmp',
    setup = require 'modules.config.nvim-cmp',
    event = 'InsertEnter',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      { 'hrsh7th/vim-vsnip', requires = { 'rafamadriz/friendly-snippets' } },
    },
  }

  -----[[-------------]]-----
  ---     Web dev         ---
  -----]]-------------[[-----
  use {
    'norcalli/nvim-colorizer.lua',
    setup = require 'modules.config.nvim-colorizer',
  }

  packer.install()
  packer.compile()
end)
