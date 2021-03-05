
--{{{ Auto install packer:
 local execute = vim.api.nvim_command
 local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end
--}}}

execute 'au BufWritePost plugins.lua PackerCompile'
execute 'packadd packer.nvim'

local packer = require('packer')

return packer.startup(function()
  local use = use

  use {'wbthomason/packer.nvim', opt = true}

  use 'ThePrimeagen/vim-be-good'
  use 'tweekmonster/startuptime.vim'

  --{{{ Appearance
  use {'kyazdani42/nvim-web-devicons',    config = function() require'nvim-web-devicons'.setup{} end}
  -- use 'tjdevries/cyclist.vim'
  use {
    'itchyny/vim-cursorword',
    event = {'BufReadPre','BufNewFile'},
  }
  --}}}

  --{{{ Colors
  -- use {'npxbr/gruvbox.nvim', requires = {"rkt'jmp/lush.nvim"}}
  use 'ChristianChiarulli/nvcode-color-schemes.vim'
  use 'glepnir/zephyr-nvim'
  use {'norcalli/nvim-colorizer.lua',     config = function() require('plugin.colorizer') end }
  --}}}

  --{{{ Exploring files
  use {'tpope/vim-eunuch',                event = {'BufReadPre', 'BufNewFile'} }
  use {'kyazdani42/nvim-tree.lua',        config = function() require('plugin.nvim_tree') end }
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugin.telescope') end,
    requires = {
      {'nvim-lua/popup.nvim', opt = true},
      {'nvim-lua/plenary.nvim',opt = true},
      {'nvim-telescope/telescope-fzf-writer.nvim',opt = true},
      {'nvim-telescope/telescope-fzy-native.nvim',opt = true},
    },
  }
  --}}}

  --{{{ Git
  use {
    'lewis6991/gitsigns.nvim',
    event = {'BufReadPre','BufNewFile'},
    config = function() require('plugin.gitsigns') end
  }
  ---}}}

  --{{{ Lsp
  use {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = function () require('plugin.lsp') end
  }
  use {
    'hrsh7th/nvim-compe',
    event = 'InsertEnter',
  }

  use 'glepnir/lspsaga.nvim'
  use 'wbthomason/lsp-status.nvim'

  use {
    'mattn/emmet-vim',
    event = 'InsertEnter',
    ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'},
    config = function ()
      vim.g.user_emmet_complete_tag = 0
      vim.g.user_emmet_install_global = 0
      vim.g.user_emmet_install_command = 0
      vim.g.user_emmet_mode = 'i'
    end
  }
  --}}}

  --{{{ Status/Buffer line
  use {'akinsho/nvim-bufferline.lua',     config = function() require'bufferline'.setup{options = {always_show_bufferline = false}} end }
  use {'glepnir/galaxyline.nvim',         config = function() require('plugin.galaxyline') end }
  --}}}

--{{{ Syntax
  use {
    'nvim-treesitter/nvim-treesitter',
    -- In order to see bufpreview with ts
    event = 'BufRead',
    after = 'telescope.nvim',
    config = function()
      require'nvim-treesitter.configs'.setup { highlight = { enable = true }, ensure_installed = 'all' }
    end }
--}}}

--{{{ Text manipulation
  use {
    'prettier/vim-prettier',
    run = 'yarn install',
    ft = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' }
  }

  use {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function() require('nvim-autopairs').setup() end
  }

  use { 'tpope/vim-commentary',           event = {'BufReadPre', 'BufNewFile'} }
  use { 'tpope/vim-surround',             event = {'BufReadPre', 'BufNewFile'} }
--}}}

end)
