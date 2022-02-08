local function conf(name)
  return require(string.format('modules.config.%s', name))
end

local plugins = {
  { -- Colorschemes
    'folke/tokyonight.nvim',
    'olimorris/onedarkpro.nvim',
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
  { -- Markdown
    'preservim/vim-markdown',
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
  { -- Zenmode
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {
        window = {
          width = 100, -- width of the Zen window
          height = 1, -- height of the Zen window
        },
        plugins = {
          gitsigns = { enabled = false }, -- disables git signs
        },
      }
    end,
  },
  { -- Copilot
    'github/copilot.vim',
    config = function()
      vim.cmd 'imap <silent><script><expr> <C-L> copilot#Accept()'
      vim.g.copilot_no_tab_map = true
    end,
  },
  { -- Lsp
    'neovim/nvim-lspconfig',
    config = conf 'lsp',
    requires = {
      'williamboman/nvim-lsp-installer',
      'jose-elias-alvarez/null-ls.nvim', -- Formatter
      'b0o/schemastore.nvim', -- JSON schema for jsonls
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

local M = {}

function M:setup()
  local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  local compile_path = vim.fn.stdpath 'data' .. '/site/plugin/packer_compiled.lua'
  local package_root = vim.fn.stdpath 'data' .. '/site/pack'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim'
  end

  local ok, packer = pcall(require, 'packer')
  if not ok then
    return
  end

  packer.init {
    compile_path = compile_path,
    package_root = package_root,
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  }

  return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end)
end

return M
