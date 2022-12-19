-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end



-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { "olimorris/onedarkpro.nvim" }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup()
    end
  }


  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      local map = require('nvim-tree.config').nvim_tree_callback
      require("nvim-tree").setup({
        ignore_ft_on_setup = { 'dashboard' }, -- will not open on setup if the filetype is in this list
        update_focused_file = {
          enable = true,
          update_cwd = false,
          ignore_list = {},
        },
        filters = {
          dotfiles = false,
          custom = { '.git' }, -- Files to hide
        },
        view = {
          width = 35,
          hide_root_folder = true,
          side = 'right',
          signcolumn = 'no',
          mappings = {
            custom_only = true, -- `custom_only = false` will merge list of mappings with defaults
            list = {
              { key = '<C-R>', cb = map 'refresh' },
              { key = 'a', cb = map 'create' },
              { key = 'd', cb = map 'remove' },
              { key = 'h', cb = map 'close_node' },
              { key = 'I', cb = map 'toggle_ignored' },
              { key = 'l', cb = map 'edit' },
              { key = 'r', cb = map 'rename' },
              { key = 's', cb = map 'split' },
              { key = 'v', cb = map 'vsplit' },
              { key = 'Y', cb = map 'copy_path' },
              { key = 'y', cb = map 'copy_name' },
            },
          },
        },
      })
    end
  }

  use { -- Treesiter
    'nvim-treesitter/nvim-treesitter',
    requires = { 'windwp/nvim-ts-autotag', 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function ()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        ignore_install = { "phpdoc" },
        highlight = {
          enable = true, -- false will disable the whole extension
          -- disable = { 'json' }, -- list of language that will be disabled
        },
        indent = { enable = true },
        autopairs = { enable = true },
        rainbow = { enable = true },
        autotag = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
      }
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function() 
      require('Comment').setup({
        pre_hook = function(ctx)
          local U = require 'Comment.utils'
          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
          end
          return require('ts_context_commentstring.internal').calculate_commentstring {
            key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
            location = location,
          }
        end,
      })
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'onedark',
          icons_enabled = false,
          component_separators = '|',
          section_separators = '',
        },
      }
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        buftype_exclude = { 'terminal' },
        filetype_exclude = { 'help', 'NvimTree', 'dashboard', 'packer', 'TelescopePrompt' },
        char = '▏',
        show_current_context = true,
        space_char_blankline = ' ',
        use_treesitter = true,
      }
    end
  }


  use { 
    'lewis6991/gitsigns.nvim', 
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { hl = 'GitSignsAdd', text = '▎' },
          change = { hl = 'GitSignsChange', text = '▎' },
          delete = { hl = 'GitSignsDelete', text = '契' },
          topdelete = { hl = 'GitSignsDelete', text = '契' },
          changedelete = { hl = 'GitSignsChange', text = '▎' },
        },
      }
    end
  }

  use {
    'neovim/nvim-lspconfig',
  }


  if is_bootstrap then
    require('packer').sync()
  end
end)
-- stylua: ignore end

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
