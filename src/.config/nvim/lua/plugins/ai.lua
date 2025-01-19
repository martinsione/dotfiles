return {
	{
		{
			"zbirenbaum/copilot.lua",
			lazy = true,
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = {
						enabled = true,
						auto_trigger = true,
						debounce = 75,
						keymap = { dismiss = "<C-]>" },
					},
					copilot_node_command = "node", -- Node.js version must be > 16.x
					server_opts_overrides = {},
					filetypes = { ["."] = false },
				})

				local suggestion = require("copilot.suggestion")
				vim.keymap.set("i", "<Tab>", function()
					if suggestion.is_visible() then
						suggestion.accept()
					else
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
					end
				end, { silent = true })
			end,
		},
		{
			"yetone/avante.nvim",
			event = "VeryLazy",
			opts = {
				provider = "copilot",
				auto_suggestions_provider = "copilot",
				mappings = {
					edit = "<leader>ae",
					submit = { insert = "<C-s>", normal = "<CR>" },
				},
			},
			build = "make",
			dependencies = {
				{ "MunifTanjim/nui.nvim", lazy = true },
				{ "nvim-lua/plenary.nvim", lazy = true },
				{ "stevearc/dressing.nvim", lazy = true },
			},
		},
	},
}
