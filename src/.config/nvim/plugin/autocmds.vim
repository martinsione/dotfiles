augroup vimrc
  au!
augroup end

augroup ftplugin
  au!
  au FileType man setl laststatus=0 noruler
  au FileType NvimTree setl scl=no
  au FileType vim,lua,css,javascript setl sw=2 ts=2
  au TermOpen term://* setl nornu nonu nocul so=0 scl=no
augroup end

augroup my_cmds
  au!
  au FileType * setl formatoptions-=cro     " Avoid newline continuation of comments
augroup end

augroup on_save
  au!
  au BufWritePre * %s/\s\+$//e                  " Remove whitespace on save
  au BufWritePre * %s/\n\+\%$//e                " remove trailing newline
  au BufWritePost *.vim,*.lua :source %
augroup end

augroup on_yank
  au!
  au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 150 }
augroup end
