" Expand current file
cnoremap %P <C-R>=expand('%:p')<CR>

command! PackerDelete :!rm  -rf ~/.local/share/nvim/site/pack/packer <CR>
