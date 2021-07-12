local colorscheme = 'tokyonight'

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection = false
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_style = 'night'

pcall(vim.cmd('colorscheme ' .. colorscheme))
-- vim.cmd('try | colorscheme ' .. colorscheme .. ' | catch | endtry')