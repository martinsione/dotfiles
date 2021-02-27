let s:terminal_window = -1
let s:terminal_buffer = -1
let s:terminal_job_id = -1

function! TerminalOpen()
  if !bufexists(s:terminal_buffer)
    new
    term
    silent file Terminal\ 1
    let s:terminal_window = win_getid()
    let s:terminal_buffer = bufnr('%')
    set nobuflisted
  elseif !win_gotoid(s:terminal_window)
    split
    buffer Terminal\ 1
    let s:terminal_window = win_getid()
  endif

  wincmd J
  call nvim_win_set_height(0, 14)
endfunction

function! TerminalClose()
  if win_gotoid(s:terminal_window)
    hide
  endif
endfunction

function! TerminalToggle()
 if win_gotoid(s:terminal_window)
    call TerminalClose()
  else
    call TerminalOpen()
    silent au BufEnter <buffer> startinsert!
  endif
endfunction
