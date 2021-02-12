setlocal norelativenumber
setlocal nonumber
setlocal scrolloff=0
setlocal nocursorline
setlocal signcolumn="no"

inoremap <buffer> <C-h> <C-h>
inoremap <buffer> <C-j> <C-j>
inoremap <buffer> <C-k> <C-k>
inoremap <buffer> <C-l> <C-l>
tnoremap <buffer> <Esc> <C-\><C-n>
tnoremap <silent> <buffer> <C-W> <C-\><C-n>:bd!<CR>
nnoremap <silent> <buffer> <C-W> <C-\><C-n>:bd!<CR>
