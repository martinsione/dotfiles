return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
      },
      bind_to_cwd = false,
      follow_current_file = true,
      use_libuv_file_watcher = true,
    },
    window = {
      position = "right",
      width = 40,
      mappings = {
        ["h"] = "close_node",
        ["l"] = "open",
      },
    },
  },
  keys = {
    {
      "<C-n>",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = require("config.util").get_root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
}
