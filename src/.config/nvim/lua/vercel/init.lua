local M = {}

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.g.colors_name = "vercel"
  vim.o.termguicolors = true

  local palette = require("vercel.palette")
  local c = vim.o.background == "light" and palette.light or palette.dark

  for group, hl in pairs(require("vercel.highlights").get(c)) do
    vim.api.nvim_set_hl(0, group, hl)
  end

  -- Terminal colors
  vim.g.terminal_color_0 = c.black
  vim.g.terminal_color_1 = c.pink
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_3 = c.orange
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_5 = c.purple
  vim.g.terminal_color_6 = c.cyan
  vim.g.terminal_color_7 = c.fg_muted
  vim.g.terminal_color_8 = c.fg_dark
  vim.g.terminal_color_9 = c.pink
  vim.g.terminal_color_10 = c.green
  vim.g.terminal_color_11 = c.orange
  vim.g.terminal_color_12 = c.blue
  vim.g.terminal_color_13 = c.purple
  vim.g.terminal_color_14 = c.cyan
  vim.g.terminal_color_15 = c.fg
end

-- Re-apply when background changes
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "vercel" then
      M.load()
    end
  end,
})

return M
