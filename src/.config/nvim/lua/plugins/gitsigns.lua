return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  },
  keys = {
    { "]g", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Git Hunk" },
    { "[g", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous Git Hunk" },
  },
}
