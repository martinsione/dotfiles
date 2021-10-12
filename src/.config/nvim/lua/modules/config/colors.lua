local g = vim.g
local colorscheme = 'darkplus'

g.gruvbox_contrast_dark = 'hard'
g.gruvbox_invert_selection = false
g.tokyonight_italic_functions = true
g.tokyonight_style = 'night'

pcall(function()
  vim.cmd('colorscheme ' .. colorscheme)
end)
