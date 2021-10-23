local runtime_dir = os.getenv 'HOME' .. '/.local/share/minivim'
vim.opt.rtp:remove(vim.fn.stdpath 'data' .. '/site')
vim.opt.rtp:remove(vim.fn.stdpath 'data' .. '/site/after')
vim.opt.rtp:prepend(runtime_dir .. '/site')
vim.opt.rtp:append(runtime_dir .. '/site/after')
vim.cmd [[let &packpath = &runtimepath]]

local packer_config = {
  install_path = runtime_dir .. '/site/pack/packer/start/packer.nvim',
  package_root = runtime_dir .. '/site/pack',
  compile_path = runtime_dir .. '/site/plugin/packer_compiled.lua',
}

local plugins = {
  { 'folke/tokyonight.nvim' },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'maintained',
        highlight = { enable = true },
      }
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } },
  -- { 'neovim/nvim-lspconfig', requires = { 'williamboman/nvim-lsp-installer' } },
}

require('modules'):init(packer_config)
require('modules'):load(plugins)
require 'core.options'
require 'core.keymaps'
require 'core.autocmd'
vim.cmd [[colo tokyonight]]

vim.cmd [[
  augroup CompileOnSave
    autocmd!
    autocmd BufWritePost min.lua source <afile> | PackerCompile
  augroup end
]]
