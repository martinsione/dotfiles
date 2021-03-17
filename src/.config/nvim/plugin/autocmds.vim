augroup ftplugin
  au!
  au TermOpen term://* setlocal nornu nonu nocul so=0 scl=no
augroup end

augroup my_cmds
  au!
  au FileType * setlocal formatoptions-=cro     " Avoid newline continuation of comments
augroup end

augroup on_save
  au!
  au BufWritePre * %s/\s\+$//e                  " Remove whitespace on save
  au BufWritePost *.lua :luafile %
  au BufWritePost *.vim :source %
augroup end

augroup on_yank
  au!
  au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 150 }
augroup end
