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

" " Background colors for active vs inactive windows
" hi ActiveWindow guibg=#17252c
" hi InactiveWindow guibg=#0D1B22

" " Call method on window enter
" augroup WindowManagement
"   autocmd!
"   autocmd BufLeave * TSBufToggle highlight
"   autocmd BufLeave * set syntax=off
"   autocmd BufEnter * set syntax=on
"   autocmd WinEnter * call Handle_Win_Enter()
" augroup END

" " Change highlight group of active/inactive windows
" function! Handle_Win_Enter()
"   setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
" endfunction
