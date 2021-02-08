setlocal formatoptions-=o
au BufWritePost *.lua :luafile %
