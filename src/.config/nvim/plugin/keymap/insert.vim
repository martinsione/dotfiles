" Tab completion
inoremap <silent> <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Jump up / down a line
inoremap <S-CR> <C-O>o
inoremap <C-CR> <C-O>O

" Window Navigation
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
