return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
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
			-- Live multigrep
			map("n", "<space>fa", function()
				custom_pickers.live_multigrep({ cwd = "~/Developer/aleph" })
			end, { desc = "Search aleph" })
			map("n", "<space>fw", custom_pickers.live_multigrep, { desc = "Search words" })
			map("n", "<space>dd", custom_pickers.projects, { desc = "Search projects" })
			map("n", "<space><space>", builtin.buffers, { desc = "Search buffers" })
			map("n", "<space>ff", builtin.find_files, { desc = "Search files" })
			map("n", "<space>fh", builtin.help_tags, { desc = "Search for help" })
			map("n", "<space>gs", builtin.git_status, { desc = "Search for modified files" })
			map("n", "<C-p>", custom_pickers.project_search, { desc = "Search git project" })

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
