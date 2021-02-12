augroup LuaHighlight
  au!
  au TextYankPost * silent! lua vim.highlight.on_yank {
        \ higroup = "Substitute",
        \ timeout = 100,
        \ on_macro = true
        \ }
augroup END
