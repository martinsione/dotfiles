local M = {}

-- Colors pre-blended (no alpha) against the respective backgrounds
-- since Neovim doesn't support alpha in highlight colors.

M.dark = {
  bg = "#0a0a0a",
  bg_dark = "#000000",
  bg_highlight = "#1a1a1a",
  bg_element = "#1f1f1f",
  bg_visual = "#182a3b",
  fg = "#ededed",
  fg_muted = "#a1a1a1",
  fg_dark = "#878787",
  border = "#2e2e2e",
  black = "#000000",

  blue = "#52a8ff",
  green = "#62c073",
  pink = "#f75f8f",
  purple = "#c472fb",
  orange = "#ff9907",
  cyan = "#1da9b0",

  error_bg = "#391b25",
  warn_bg = "#3b2709",
  info_bg = "#182a3b",
  hint_bg = "#282828",

  diff_add = "#1c2e1f",
  diff_delete = "#391b25",
  diff_change = "#3b2709",
  diff_text = "#4d3310",
}

M.light = {
  bg = "#ffffff",
  bg_dark = "#f5f5f5",
  bg_highlight = "#e5e5e5",
  bg_element = "#ebebeb",
  bg_visual = "#cce1f7",
  fg = "#171717",
  fg_muted = "#666666",
  fg_dark = "#a8a8a8",
  border = "#ebebeb",
  black = "#171717",

  blue = "#0068d6",
  green = "#297a3a",
  pink = "#bd2864",
  purple = "#7c00c7",
  orange = "#A35200",
  cyan = "#449999",

  error_bg = "#f2d4e0",
  warn_bg = "#eddccc",
  info_bg = "#cce1f7",
  hint_bg = "#e0e0e0",

  diff_add = "#d4edda",
  diff_delete = "#f2d4e0",
  diff_change = "#eddccc",
  diff_text = "#e0c9a8",
}

return M
