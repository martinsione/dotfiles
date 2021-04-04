local packer_path = utils.os.data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd 'packadd packer.nvim | au BufWritePost plugins.lua PackerCompile'

local packer = require('packer')
local packer_compiled = utils.os.data .. '/site/plugin/packer_compiled.vim'
local plugins_path = utils.os.data .. '/site/pack/packer/'

return packer.startup(function(use)
  packer.init({compile_path = packer_compiled})

  use {'wbthomason/packer.nvim', opt = true}

  -- Auto-pairs
  use {'windwp/nvim-autopairs', event = 'InsertEnter', config = [[require('nvim-autopairs').setup()]]}

  -- Bufferline
  use {'akinsho/nvim-bufferline.lua', event = 'BufRead', config = [[require('plugin.nvim-bufferline')]]}

  -- Clipboard
  use {'bfredl/nvim-miniyank'}

  -- Colorizer
  use {'norcalli/nvim-colorizer.lua', event = 'BufRead', config = [[require('plugin.colorizer')]]}

  -- Colorscheme
  use {'ChristianChiarulli/nvcode-color-schemes.vim'}
  use {'glepnir/zephyr-nvim'}
  use {'Mofiqul/vim-code-dark'}
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
    ft = {'html', 'css', 'javascript', 'javascriptreact', 'vue', 'typescript', 'typescriptreact'},
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    event = {'BufRead', 'BufNewFile'},
    config = [[require('plugin.gitsigns')]],
    requires = {{'nvim-lua/plenary.nvim', opt = true}},
  }

  -- Icons
  use {'kyazdani42/nvim-web-devicons', config = [[require('plugin.nvim-web-devicons')]]}

  -- Indent line
  use {
    'lukas-reineke/indent-blankline.nvim',
    branch = 'lua',
    event = {'BufRead'},
    config = [[require('plugin.indentline')]],
  }

  -- Lsp
  use {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = [[require('plugin.lsp')]],
    requires = {
      {'kabouzeid/nvim-lspinstall'},
      {'hrsh7th/nvim-compe', event = 'InsertEnter', config = [[require('plugin.compe')]]},
      {'glepnir/lspsaga.nvim', opt = true}, {'onsails/lspkind-nvim', opt = true},
      {'jose-elias-alvarez/nvim-lsp-ts-utils', opt = true},
    },
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
    cmd = 'Telescope',
    config = [[require('plugin.telescope')]],
    requires = {
      {'nvim-lua/popup.nvim', opt = true}, {'nvim-lua/plenary.nvim', opt = true},
      {'nvim-telescope/telescope-fzy-native.nvim', opt = true},
      {'nvim-telescope/telescope-fzf-writer.nvim', opt = true},
      {'nvim-telescope/telescope-media-files.nvim', opt = true},
    },
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
    event = 'BufRead',
    run = ':TSUpdate',
    after = 'telescope.nvim',
    config = [[require('plugin.treesitter')]],
    requires = {
      {'p00f/nvim-ts-rainbow', opt = true}, {'windwp/nvim-ts-autotag', event = 'InsertEnter'},
      {'JoosepAlviste/nvim-ts-context-commentstring', opt = true},
    },
  }

  -- Autoinstall/compile  plugins
  if vim.fn.isdirectory(vim.fn.glob(plugins_path)) > 0 then packer.install() end
  if vim.fn.empty(vim.fn.glob(packer_compiled)) > 0 then packer.compile() end
end)
