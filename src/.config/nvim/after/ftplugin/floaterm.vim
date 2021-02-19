inoremap <buffer> <C-h> <Nop>
inoremap <buffer> <C-j> <Nop>
inoremap <buffer> <C-k> <Nop>
inoremap <buffer> <C-l> <Nop>

tnoremap <buffer> <C-T>           <cmd>FloatermToggle<CR>
nnoremap <buffer> <Esc>    <Nop>
tnoremap <buffer> <Esc>    <Nop>

nnoremap <buffer> <silent> <C-j>  <cmd>FloatermPrev<CR>
tnoremap <buffer> <silent> <C-j>  <cmd>FloatermPrev<CR>

nnoremap <buffer> <silent> <C-k>  <cmd>FloatermNext<CR>
tnoremap <buffer> <silent> <C-k>  <cmd>FloatermNext<CR>

nnoremap <buffer> <silent> <C-n>  <cmd>FloatermNew<CR>
tnoremap <buffer> <silent> <C-n>  <cmd>FloatermNew<CR>

nnoremap <buffer> <silent> <C-W>  <cmd>FloatermKill<CR>
tnoremap <buffer> <silent> <C-W>  <cmd>FloatermKill<CR>
