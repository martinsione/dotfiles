RELOAD = require('plenary.reload').reload_module
local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD('plenary')
    RELOAD('popup')
    RELOAD('telescope')
  end
end

reloader()

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')
require('telescope').setup {
  defaults = {
    prompt_prefix = ' >',

    winblend = 0,
    preview_cutoff = 120,

    layout_strategy = 'horizontal', layout_defaults = { horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      }
    },
    file_ignore_patterns = { "**/node_modules", "**.jpg", "**.jpeg", "**.png", "**.svg"},
    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    prompt_position = "top",
    color_devicons = true,
    borderchars = {
      { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    },

    file_sorter = sorters.get_fzy_sorter,

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },
}

local M = {}

--[[
lua require('plenary.reload').reload_module("my_user.tele")

nnoremap <leader>en <cmd>lua require('my_user.tele').edit_neovim()<CR>
--]]

function M.edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = "~ Nvim ~",
    shorten_path = true,
    cwd = "~/.config/nvim",
  }
end

function M.edit_zsh()
  require('telescope.builtin').find_files {
    prompt_title = "~ ZSH ~",
    shorten_path = true,
    cwd = "~/.config/zsh",
  }
end

function M.edit_dotfiles()
  require('telescope.builtin').find_files {
    prompt = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/dotfiles/src/.config/",
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
