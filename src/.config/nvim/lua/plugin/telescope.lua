if not packer_plugins['plenary.nvim'].loaded then
  vim.cmd [[packadd plenary.nvim]]
  vim.cmd [[packadd popup.nvim]]
  vim.cmd [[packadd telescope-fzy-native.nvim]]
  vim.cmd [[packadd telescope-fzf-writer.nvim]]
  vim.cmd [[packadd telescope-media-files.nvim]]
end

if not pcall(require, 'telescope') then
  return
end

local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    layout_strategy = 'horizontal',
    -- layout_defaults = {
    --   horizontal = {width_padding = 0.1, height_padding = 0.1, preview_width = 0.6},
    --   vertical = {width_padding = 0.15, height_padding = 0.1, preview_height = 0.6}
    -- },
    prompt_prefix = '😎 ',
    prompt_position = 'bottom',
    sorting_strategy = 'descending',
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {['<C-j>'] = actions.move_selection_next, ['<C-k>'] = actions.move_selection_previous},
      n = {['<C-c>'] = actions.close}
    }
  },
  extensions = {
    fzy_native = {override_generic_sorter = false, override_file_sorter = true},
    media_files = {filetypes = {'png', 'jpg', 'jpeg', 'mp4', 'webm', 'pdf'}, find_cmd = 'fd'}
  }

}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('media_files')

local M = {}

function M.find_dotfiles()
  require('telescope.builtin').find_files {
    prompt_title = ' Dotfiles ',
    find_command = {'rg', '--files', '--hidden', '--ignore', '--sort=path'},
    cwd = '~/dotfiles'
  }
end

function M.find_all_files()
  require('telescope.builtin').find_files {find_command = {'rg', '--no-ignore', '--files'}}
end

return M
