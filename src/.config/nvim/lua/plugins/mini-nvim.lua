return {
  {
    -- Auto pairs
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    -- Comments
    "echasnovski/mini.comment",
    event = "VeryLazy",
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy", lazy = true },
    },
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  {
    -- Surround
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Vsual modes
        delete = "ds", -- Delete surroundng
        replace = "cs", -- Replace surrounding
        find = "gsf", -- Find surrounding (to the right)
        -- find_left = "gsF", -- Find surrounding (to the left)
        -- highlight = "gsh", -- Highlight surrounding
        -- update_n_lines = "gsn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup(opts)
    end,
  },
}
