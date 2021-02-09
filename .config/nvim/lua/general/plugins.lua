-- Auto install packer if missing
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]] vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
return packer.startup(function()
    local use = use

    use {'wbthomason/packer.nvim', opt = true}
    use 'AndrewRadev/splitjoin.vim'
    use 'Yggdroot/indentLine'
    use 'airblade/vim-gitgutter'
    use 'christianchiarulli/nvcode-color-schemes.vim'
    use 'christoomey/vim-tmux-navigator'
    use 'glepnir/dashboard-nvim'
    use 'junegunn/goyo.vim'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'tjdevries/cyclist.vim'
    use 'tweekmonster/startuptime.vim'
    use 'neoclide/coc.nvim'

    --
    use {'norcalli/nvim-terminal.lua',      config = function() require'terminal'.setup() end }

    -- Tpope's
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'

    use {'akinsho/nvim-bufferline.lua',     config = function() require'bufferline'.setup{} end }
    use {'glepnir/galaxyline.nvim',         config = function() require('plugin.galaxyline') end }
    use {'norcalli/nvim-colorizer.lua',     config = function() require('plugin.colorizer') end }
    use {'nvim-telescope/telescope.nvim',   config = function() require('plugin.telescope') end }
    use {'nvim-treesitter/nvim-treesitter', config = function() require('plugin.treesitter') end }

    use 'voldikss/vim-floaterm'
    -- Lsp
    -- use {'neovim/nvim-lspconfig',           config = function() require('plugin.lsp') end }
    -- use {'nvim-lua/completion-nvim' ,       config = function() require('plugin.completion') end }
    -- use 'nvim-lua/lsp_extensions.nvim'
    -- use 'nvim-lua/lsp-status.nvim'
    -- use 'tjdevries/astronauta.nvim'

    -- Lua
    use 'euclidianAce/BetterLua.vim'
    -- use 'tjdevries/nlua.nvim'

end)
