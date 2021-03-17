let s:terminal_window = -1
let s:terminal_buffer = -1
let s:terminal_job_id = -1

function! TerminalOpen()
  if !bufexists(s:terminal_buffer)
    vnew
    term
    silent file Terminal\ 1
    let s:terminal_window = win_getid()
    let s:terminal_buffer = bufnr('%')
    set nobuflisted
  elseif !win_gotoid(s:terminal_window)
    vsplit
    buffer Terminal\ 1
    let s:terminal_window = win_getid()
  endif

  " hi Background guibg=#282828
  " setlocal winhighlight=Normal:Background
  " wincmd J
  " call nvim_win_set_height(0, 14)
  " set winfixheight

  hi Background guibg=#282828
  setlocal winhighlight=Normal:Background
  wincmd L
  exec "vertical resize ".(&columns * 2 / 5)

  norm i
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
  endif
endfunction
