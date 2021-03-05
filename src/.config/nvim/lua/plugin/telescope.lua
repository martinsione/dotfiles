local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_defaults = {
      horizontal = {
        width_padding = 0.15,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.15,
        height_padding = 0.1,
        preview_height = 0.6,
      },
    },
    -- preview_cutoff = 120,
    prompt_prefix = '😎 ',
    prompt_position = 'bottom',
    sorting_strategy = 'descending',
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<C-c>"] = actions.close,
      },
    }
  },
  extensions = {
      fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
      }
  }
}

require('telescope').load_extension('fzy_native')

local M = {}

--{{{ Edit dotfiles
function M.edit_dotfiles()
  require('telescope.builtin').find_files {
    prompt_title = " Dotfiles ",
    find_command = {
      'rg',
      '--files',
      '--no-ignore',
      '--hidden',
      '-g',
      '!.git/'
    },
    cwd = "~/dotfiles",
  }
end
--}}}

--{{{ Edit Plugins
function M.edit_plugins()
  require('telescope.builtin').find_files {
    prompt_title = " Plugins ",
    find_command = {
      'rg',
      '--files',
      '--no-ignore',
      '--hidden',
      '-g',
      '!.git/'
    },
    cwd = "~/.local/share/nvim/site/pack/packer",
  }
end
--}}}


return M
