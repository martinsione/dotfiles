return function()
  vim.g.dashboard_footer_icon = '🐬 '
  vim.g.dashboard_preview_file_height = 12
  vim.g.dashboard_preview_file_width = 80
  vim.g.dashboard_disable_statusline = 1
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_section = {
    find_files = {
      description = { '  Git files                           SPC f p ' },
      command = 'silent! lua require"telescope.builtin".git_files()',
    },
    find_history = {
      description = { '  Recently opened files               SPC f r' },
      command = 'lua require"telescope.builtin".oldfiles()',
    },
    find_word = {
      description = { '  Find  word                          SPC f w' },
      command = 'lua require"telescope.builtin".live_grep()',
    },
    find_dotfiles = {
      description = { '  Open Personal dotfiles              SPC f d' },
      command = 'lua require"telescope.builtin".git_files({cwd = "$HOME/.dotfiles" })',
    },
  }

  vim.g.dashboard_custom_header = {
    '',
    '',
    '',
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    '',
  }
end
