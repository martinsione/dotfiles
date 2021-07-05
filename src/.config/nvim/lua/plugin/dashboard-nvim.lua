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
vim.g.dashboard_footer_icon = '🐬 '
vim.g.dashboard_preview_file_height = 12
vim.g.dashboard_preview_file_width = 80
vim.g.dashboard_disable_statusline = 1
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
  find_files = {
    description = {'  Find  Files                             SPC f p '},
    command = 'Telescope find_files',
  },
  find_history = {
    description = {'  Recently opened files                   SPC f r'},
    command = 'Telescope oldfiles',
  },
  find_word = {
    description = {'  Find  word                              SPC f w'},
    command = 'Telescope live_grep',
  },
  find_dotfiles = {
    description = {'  Open Personal dotfiles                  SPC f d'},
    command = 'lua require("plugin.telescope").find_dotfiles()',
  },
}
