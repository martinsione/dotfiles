local data = require('core.utils').os.data
local packer_path = data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  print 'Downloading plugin manager...'
  vim.cmd('sil! !git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd 'packadd packer.nvim'
vim.opt.rtp:append(data .. '/site/pack/packer/opt/*')

local function conf(name)
  return require(string.format('modules.config.%s', name))
end

local packer = require 'packer'
return packer.startup(function(use)
  packer.init {
    compile_path = data .. '/site/plugin/packer_compiled.lua',
    opt_default = true,
    profile = { enable = true },
  }

  -- Plugin manager
  use { 'wbthomason/packer.nvim', opt = true }

  -----[[------------]]-----
  ---     UI Related     ---
  -----]]------------[[-----
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    setup = conf 'nvim-treesitter',
    requires = {
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  }

  -- Start Screen
  use {
    'glepnir/dashboard-nvim',
    setup = conf 'dashboard-nvim',
  }

  -- Colorschemes
  use { 'npxbr/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } }
  use { 'folke/tokyonight.nvim' }
  use { 'LunarVim/Colorschemes' }

  -- Colorizer
  use {
    'norcalli/nvim-colorizer.lua',
    setup = conf 'nvim-colorizer',
  }

  -- Icons
  use {
    'kyazdani42/nvim-web-devicons',
    setup = conf 'nvim-web-devicons',
  }

  -- File tree
  use {
    'kyazdani42/nvim-tree.lua',
    setup = conf 'nvim-tree',
  }

  -- Statusline
  use {
    'glepnir/galaxyline.nvim',
    setup = conf 'galaxyline',
  }

  -- Tabline
  use {
    'akinsho/nvim-bufferline.lua',
    setup = conf 'nvim-bufferline',
  }

  -- Indent Lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    setup = conf 'indent-blankline',
  }

  -----[[--------------]]-----
  ---     IDE features     ---
  -----]]--------------[[-----
  -- Autopairs
  use {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    setup = conf 'nvim-autopairs',
  }

  -- Commenting
  use { 'tpope/vim-commentary' }

  -- Should be in vim core...
  use { 'tpope/vim-surround', requires = { 'tpope/vim-repeat' } }

  -- Fuzzy finding / Ctrl + p
  use {
    'nvim-telescope/telescope.nvim',
    setup = conf 'telescope',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  -- -- TODO: setup nvim-dap
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
    setup = conf 'gitsigns',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
    'TimUntersberger/neogit',
    setup = conf 'neogit',
    requires = { { 'sindrets/diffview.nvim' }, { 'nvim-lua/plenary.nvim' } },
  }

  -----[[------------]]-----
  ---     Completion     ---
  -----]]------------[[-----
  -- Built-in lsp
  use {
    'neovim/nvim-lspconfig',
    setup = conf 'nvim-lspconfig',
    requires = {
      { 'kabouzeid/nvim-lspinstall' },
      { 'ray-x/lsp_signature.nvim' },
      { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
    },
  }

  -- Completion plugin
  use {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    setup = conf 'nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      { 'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets' } },
    },
  }
end)
