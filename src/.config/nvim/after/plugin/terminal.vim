
function! s:small_terminal() abort
  new
  wincmd J
  call nvim_win_set_height(0, 10)
  set winfixheight
  term
endfunction

" nnoremap <silent> <leader>ts :call <SID>small_terminal()<CR>
