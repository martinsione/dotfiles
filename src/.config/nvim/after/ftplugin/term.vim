setlocal norelativenumber
setlocal nonumber
setlocal scrolloff=0
setlocal nocursorline
setlocal signcolumn="no"

inoremap <buffer> <C-j> <Nop>
inoremap <buffer> <C-k> <Nop>
nnoremap <buffer> <Esc> <Nop>
tnoremap <buffer> <Esc> <Nop>
tnoremap <silent> <buffer> <C-W> <C-\><C-n>:bd!<CR>
nnoremap <silent> <buffer> <C-W> <C-\><C-n>:bd!<CR>
