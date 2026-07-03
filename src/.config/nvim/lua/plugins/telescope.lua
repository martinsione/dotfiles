return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-tree/nvim-web-devicons", lazy = true, enabled = vim.g.have_nerd_font },
    },
    config = function()
      require("telescope").setup({
        extensions = { fzf = {} },
        pickers = {
          git_files = { show_untracked = true },
          live_grep = { additional_args = { "--hidden" } },
        },
        defaults = require("telescope.themes").get_ivy({
          mappings = {
            i = {
              ["<C-c>"] = false,
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
            n = {
              ["<C-c>"] = "close",
            },
          },
        }),
      })

      pcall(require("telescope").load_extension, "fzf")

      local map = vim.keymap.set
      local custom_pickers = require("config.telescope")
      local builtin = require("telescope.builtin")

      map("n", "<space>fd", function()
        custom_pickers.live_multigrep({ cwd = "~/Developer/martinsione/dotfiles" })
      end, { desc = "Search dotfiles" })
      map("n", "<space>fw", custom_pickers.live_multigrep, { desc = "Search words" })
      map("n", "<space>fp", custom_pickers.projects, { desc = "Search projects" })
      map("n", "<space><space>", builtin.buffers, { desc = "Search buffers" })
      map("n", "<space>ff", builtin.find_files, { desc = "Search files" })
      map("n", "<space>fh", builtin.help_tags, { desc = "Search for help" })
      map("n", "<space>gs", builtin.git_status, { desc = "Search for modified files" })
      map("n", "<C-p>", custom_pickers.project_search, { desc = "Search git project" })

      map("n", "<space>ss", function()
        builtin.find_files({
          attach_mappings = function(prompt_bufnr)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            actions.select_default:replace(function()
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              local selections = current_picker:get_multi_selection()
              if vim.tbl_isempty(selections) then
                table.insert(selections, action_state.get_selected_entry())
              end
              local paths = vim.tbl_map(function(e)
                return e.path
              end, selections)
              actions.close(prompt_bufnr)
              builtin.live_grep({ search_dirs = paths })
            end)
            return true
          end,
        })
      end, { desc = "Search in selected files" })

      -- Neovim stuff
      map("n", "<space>fnd", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Search neovim directory" })

      map("n", "<space>fnp", function()
        builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
      end, { desc = "Search neovim plugins" })
    end,
  },
}
