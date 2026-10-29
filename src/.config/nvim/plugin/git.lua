require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  current_line_blame_opts = { delay = 500 },
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
})
vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next Git Hunk" })
vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous Git Hunk" })
