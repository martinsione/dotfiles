au FileType * setlocal formatoptions-=cro     " Avoid newline continuation of comments
au BufWritePre * %s/\s\+$//e                  " Remove whitespace on save
