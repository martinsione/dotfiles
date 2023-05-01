return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  lazy = true,
  cmd = "Telescope",
  config = {
    defaults = {
      prompt_prefix = "❯ ",
      selection_caret = "❯ ",
      layout_config = { horizontal = { preview_width = 0.5 } },
      file_ignore_patterns = { "node_modules/.*" },
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
        n = { ["<C-c>"] = "close" },
      },
    },
  },
  keys = {
    --vim.keymap.set('n', '<space>fb', '<cmd>Telescope buffers theme=get_dropdown<CR>')
    {
      "<C-p>",
      "<cmd>Telescope find_files<CR>",
      desc = "Find Files (root dir)",
    },
    { "<leader>fb", "<cmd>Telescope buffers show_all_buffers=true<CR>", desc = "Buffers" },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<CR>",
      desc = "Help Pages",
    },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Recent" },
    { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
    {
      "<leader>fd",
      "<cmd>lua require'telescope.builtin'.git_files({ cwd = '$HOME/.dotfiles' })<CR>",
      desc = "Search dotfiles",
    },
    {
      "<leader>:",
      "<cmd>Telescope command_history<CR>",
      desc = "Command History",
    },
  },
}
