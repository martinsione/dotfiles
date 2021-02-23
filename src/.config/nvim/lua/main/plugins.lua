-- Auto install packer if missing: {{{
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim' if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
  execute 'PackerInstall'
end


vim.cmd[[au BufWritePost plugins.lua PackerCompile]] vim.cmd [[packadd packer.nvim]]
--- }}}

local packer = require('packer')
return packer.startup(function()
  local use = use

  use {'wbthomason/packer.nvim', opt = true}

  use {'nvim-treesitter/nvim-treesitter', config = function() require('plugin.treesitter') end }
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'tweekmonster/startuptime.vim'
  use 'neoclide/coc.nvim'

  -- Appearance
  use 'junegunn/goyo.vim'
  use {'kyazdani42/nvim-web-devicons',    config = function() require'nvim-web-devicons'.setup{} end}
  use 'tjdevries/cyclist.vim'

  -- Colors
  use 'Th3Whit3Wolf/onebuddy'
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use 'glepnir/zephyr-nvim'
  use 'tjdevries/colorbuddy.nvim'
  use 'tjdevries/gruvbuddy.nvim'
  use {'norcalli/nvim-colorizer.lua',     config = function() require('plugin.colorizer') end }

  -- Exploring files
  use 'kyazdani42/nvim-tree.lua'
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugin.telescope') end,
    requires = {
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-fzf-writer.nvim',
    },
  }

  -- Git
  -- use 'tpope/vim-fugitive'
  use {'lewis6991/gitsigns.nvim',         config = function() require('plugin.gitsigns') end }

  -- Lsp
  -- use 'neovim/nvim-lspconfig'
  -- use 'hrsh7th/nvim-compe'
  -- use { 'mattn/emmet-vim',                event = 'InsertEnter *', ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'} }

  -- Text manipulation
  -- use { 'prettier/vim-prettier', run = 'yarn install' }
  use {'windwp/nvim-autopairs',           config = function() require('nvim-autopairs').setup() end }
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'

  --
  use {'akinsho/nvim-bufferline.lua',     config = function() require'bufferline'.setup{options = {always_show_bufferline = false}} end }
  use {'glepnir/galaxyline.nvim',         config = function() require('plugin.galaxyline') end }

  -- Terminal
  use {'norcalli/nvim-terminal.lua',      config = function() require'terminal'.setup() end }
  use 'voldikss/vim-floaterm'

end)
