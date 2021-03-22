let s:terminal_window = -1
let s:terminal_buffer = -1
let s:terminal_job_id = -1

function! TerminalOpen(direction)
  if !bufexists(s:terminal_buffer)
    vnew
    term
    silent file Terminal
    let s:terminal_window = win_getid()
    let s:terminal_buffer = bufnr('%')
    set nobuflisted
  elseif !win_gotoid(s:terminal_window)
    vsplit
    buffer Terminal
    let s:terminal_window = win_getid()
  endif

  let direction = a:direction
  if direction == 'horizontal'
    wincmd J
    call nvim_win_set_height(0, 14)
    set winfixheight
  else
    wincmd L
    call nvim_win_set_width(0, 80)
    set winfixwidth
  endif

  hi Background guibg=#161616
  setlocal winhighlight=Normal:Background
  norm i
endfunction

function! TerminalClose()
  if win_gotoid(s:terminal_window)
    hide
  endif
endfunction

function! TerminalToggle(direction)
  if win_gotoid(s:terminal_window)
    call TerminalClose()
  else
    let direction = a:direction
    call TerminalOpen(direction)
  endif
endfunction
