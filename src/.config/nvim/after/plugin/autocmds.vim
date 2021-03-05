augroup my_auto_cmds
  au!
  au FileType * setlocal formatoptions-=cro     " Avoid newline continuation of comments
  au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 100 }
augroup end

augroup text_format_cmds
 au!
  au BufWritePre * %s/\s\+$//e                  " Remove whitespace on save
  au BufWritePre *.js :Prettier                 " Format with prettier on save
augroup end

augroup filetype_cmds
  au!
  au BufWritePost *.lua :luafile %
  au BufWritePost *.vim :source %
augroup end
