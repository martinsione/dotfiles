setlocal norelativenumber
setlocal nonumber
setlocal scrolloff=0
setlocal nocursorline
setlocal signcolumn="no"
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap ,reload %load_ext autoreload<CR>%autoreload 2<CR>

nnoremap <silent> <buffer> <C-W> <C-\><C-n>:bd!<CR>
tnoremap <silent> <buffer> <C-W> <C-\><C-n>:bd!<CR>
tnoremap <buffer> <Esc> <C-\><C-n>
