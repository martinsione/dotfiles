U.nvim_create_augroup({
  ftplugin = {
    {'FileType', 'man', 'setl laststatus=0 noruler'}, {'FileType', 'NvimTree', 'setl scl=no'},
    {'FileType', 'vim,lua,css,javascript', 'setl sw=2'},
    {'TermOpen', 'term://*', 'setl nornu nonu nocul so=0 scl=no'},
  },
  on_save = {
    -- {'BufWritePre', '*', '%s/\s\+$//e'},            -- Remove whitespace on save
    -- {'BufWritePre', '*', '%s/\s\+$//e'},            -- Remove whitespace on save
    {'BufWritePost', '*.vim,*.lua', 'source %'},
  },
  general = {
    {'TextYankPost', '*', 'silent! lua vim.highlight.on_yank { timeout = 150 }'},
    {'FileType', '*', 'set fo-=cro'}, -- Avoid newline continuation of comments
  },
})

