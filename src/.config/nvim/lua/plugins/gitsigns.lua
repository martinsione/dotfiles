return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { hl = "GitSignsAdd", text = "▎" },
        change = { hl = "GitSignsChange", text = "▎" },
        delete = { hl = "GitSignsDelete", text = "契" },
        topdelete = { hl = "GitSignsDelete", text = "契" },
        changedelete = { hl = "GitSignsChange", text = "▎" },
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    })
  end,
  keys = {
    { "]g", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Git Hunk" },
    { "[g", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous Git Hunk" },
  },
}
