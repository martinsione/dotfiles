local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

local packer = require('packer')
local packer_compiled = fn.stdpath('data') .. '/site/plugin/packer_compiled.vim'

return packer.startup(function()
  local use = packer.use
  packer.init({compile_path = packer_compiled})
  packer.reset()

  use {'wbthomason/packer.nvim', opt = true}

  -- Auto-pairs
  use {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = [[require('plugin.nvim-autopairs')]]
  }

  -- Bufferline
  use {
    'akinsho/nvim-bufferline.lua',
    event = 'BufRead',
    config = [[require('plugin.nvim-bufferline')]]
  }

  -- Closetags
  use {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = [[require('nvim-ts-autotag').setup()]]
  }

  -- Colorizer
  use {'norcalli/nvim-colorizer.lua', event = 'BufRead', config = [[require('plugin.colorizer')]]}

  -- Colorscheme
  use {'ChristianChiarulli/nvcode-color-schemes.vim'}
  use {'glepnir/zephyr-nvim'}
  -- use {'morhetz/gruvbox'}
  use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}

  -- Cursor
  use {'RRethy/vim-illuminate', event = 'BufReadPre', config = [[require('plugin.vim-illuminate')]]}

  -- Dashboard
  use {'glepnir/dashboard-nvim', config = [[require('plugin.dashboard')]]}

  -- Editor config
  use {'editorconfig/editorconfig-vim'}

  -- Emmet
  use {
    'mattn/emmet-vim',
    event = 'InsertEnter',
    ft = {'html', 'css', 'javascript', 'javascriptreact', 'vue', 'typescript', 'typescriptreact'}
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    event = {'BufRead', 'BufNewFile'},
    config = [[require('plugin.gitsigns')]],
    requires = {{'nvim-lua/plenary.nvim', opt = true}}
  }

  -- Icons
  use {'kyazdani42/nvim-web-devicons', config = [[require('plugin.nvim-web-devicons')]]}

  -- Indent Guides
  use {'glepnir/indent-guides.nvim', event = 'BufRead'}

  -- Lsp
  use {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = [[require('plugin.lsp')]],
    requires = {
      {'hrsh7th/nvim-compe', event = 'InsertEnter', config = [[require('plugin.compe')]]},
      {'glepnir/lspsaga.nvim', opt = true}, {'onsails/lspkind-nvim', opt = true}
    }
  }

  -- Profiling
  use {'tweekmonster/startuptime.vim', cmd = 'StartupTime'}

  -- Snippets
  use {'hrsh7th/vim-vsnip'}
  use {'dsznajder/vscode-es7-javascript-react-snippets'}
  use {'xabikos/vscode-javascript'}

  -- Statusline
  use {'glepnir/galaxyline.nvim', config = [[require('plugin.galaxyline')]]}

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    -- cmd = 'Telescope',
    config = [[require('plugin.telescope')]],
    requires = {
      {'nvim-lua/popup.nvim', opt = true}, {'nvim-lua/plenary.nvim', opt = true},
      {'nvim-telescope/telescope-fzy-native.nvim', opt = true},
      {'nvim-telescope/telescope-fzf-writer.nvim', opt = true},
      {'nvim-telescope/telescope-media-files.nvim', opt = true}
    }
  }

  -- Terminal
  use {'akinsho/nvim-toggleterm.lua', config = [[require('plugin.term')]]}

  -- Tmux navigator
  use {'christoomey/vim-tmux-navigator'}

  -- Tpope
  use {'tpope/vim-commentary', event = {'BufReadPre', 'BufNewFile'}}
  use {'tpope/vim-surround', event = {'BufReadPre', 'BufNewFile'}}
  use {'tpope/vim-eunuch', event = {'BufReadPre', 'BufNewFile'}}
  use {'tpope/vim-fugitive'}
  use {'tpope/vim-rhubarb'}

  -- Tree
  use {'kyazdani42/nvim-tree.lua', cmd = 'NvimTreeToggle', config = [[require('plugin.nvim-tree')]]}

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    -- event = 'BufRead',
    run = ':TSUpdate',
    after = 'telescope.nvim',
    config = [[require('plugin.treesitter')]],
    requires = {{'p00f/nvim-ts-rainbow', opt = true}}
  }

end)
