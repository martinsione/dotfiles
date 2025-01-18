return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "VeryLazy" },
		keys = {
			{ "]g", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Git Hunk" },
			{ "[g", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous Git Hunk" },
			f,
		},
		opts = {
			current_line_blame = true,
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			current_line_blame_opts = { delay = 300 },
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				window = {
					mappings = {
						["l"] = "open",
					},
				},
			},
			-- hijack_netrw_behavior = "open_current",
			window = { position = "right" },
		},
		dependencies = {
			{ "MunifTanjim/nui.nvim", lazy = true },
			{ "nvim-lua/plenary.nvim", lazy = true },
			{ "nvim-tree/nvim-web-devicons", lazy = true, enabled = vim.g.have_nerd_font },
		},
	},
}
