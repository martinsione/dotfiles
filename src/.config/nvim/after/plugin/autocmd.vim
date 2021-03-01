augroup my_auto_cmds
  au FileType * setlocal formatoptions-=cro     " Avoid newline continuation of comments
  au BufWritePre * %s/\s\+$//e                  " Remove whitespace on save
  au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 100 }
augroup end

augroup filetype_cmds
  au BufWritePost *.lua :luafile %
  au BufWritePost *.vim :source %
augroup end
