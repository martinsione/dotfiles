local colorscheme = 'gruvbox'

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection = false
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_style = 'night'

pcall(function()
    vim.cmd('colorscheme ' .. colorscheme)
end)
