" Expand current file
cnoremap %P <C-R>=expand('%:p')<CR>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

cnoremap <C-d> <Del>

command! PackerDelete :silent !rm  -rf ~/.local/share/nvim/site/pack/packer <CR>

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
