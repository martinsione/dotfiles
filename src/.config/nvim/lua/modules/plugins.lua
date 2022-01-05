local function conf(name)
  return require(string.format('modules.config.%s', name))
end

return {
  { -- Colorschemes
    'folke/tokyonight.nvim',
    { 'ellisonleao/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } },
    config = conf 'colors',
  },
  { -- Treesiter
    'nvim-treesitter/nvim-treesitter',
    config = conf 'nvim-treesitter',
    requires = {
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  { -- Finder
    'nvim-telescope/telescope.nvim',
    config = conf 'telescope',
    requires = { 'nvim-lua/plenary.nvim' },
  },
  { -- File tree
    'kyazdani42/nvim-tree.lua',
    config = conf 'nvim-tree',
  },
  { -- Icons
    'kyazdani42/nvim-web-devicons',
    config = conf 'nvim-web-devicons',
  },
  { -- Lsp
    'neovim/nvim-lspconfig',
    config = conf 'nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
    },
  },
  { -- Autocompletion plugin
    'hrsh7th/nvim-cmp',
    config = conf 'nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'onsails/lspkind-nvim', -- Enables icons on completions
      {
        'L3MON4D3/LuaSnip',
        requires = {
          'saadparwaiz1/cmp_luasnip',
          'rafamadriz/friendly-snippets',
        },
      },
    },
  },
  { -- Git related
    {
      'lewis6991/gitsigns.nvim',
      config = conf 'gitsigns',
      requires = { 'nvim-lua/plenary.nvim' },
    },
    { -- Like magit
      'TimUntersberger/neogit',
      config = conf 'neogit',
      requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    },
  },
  { -- Comments
    { 'tpope/vim-commentary' },
    { 'tpope/vim-surround', requires = { 'tpope/vim-repeat' } },
  },
  { -- Autopairs
    'windwp/nvim-autopairs',
    config = conf 'nvim-autopairs',
  },
  { -- Indent guides
    'lukas-reineke/indent-blankline.nvim',
    config = conf 'indent-blankline',
  },
  { -- Bufferline
    'akinsho/nvim-bufferline.lua',
    config = conf 'nvim-bufferline',
  },
  { -- Statusline
    'nvim-lualine/lualine.nvim',
    config = conf 'lualine',
  },
  { -- Colorizer
    'norcalli/nvim-colorizer.lua',
    config = conf 'nvim-colorizer',
  },
}
