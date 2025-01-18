return {
	{
		{
			"yetone/avante.nvim",
			event = "VeryLazy",
			lazy = false,
			version = false,
			opts = {
				provider = "copilot",
				auto_suggestions_provider = "copilot",
				mappings = {
					edit = "<leader>ae",
					submit = {
						insert = "<C-s>",
						normal = "<CR>",
					},
				},
			},
			build = "make",
			dependencies = {
				{ "MunifTanjim/nui.nvim", lazy = true },
				{ "hrsh7th/nvim-cmp", lazy = true },
				{ "nvim-lua/plenary.nvim", lazy = true },
				{ "nvim-tree/nvim-web-devicons", lazy = true },
				{ "stevearc/dressing.nvim", lazy = true },
				{
					"zbirenbaum/copilot.lua",
					cmd = "Copilot",
					event = "InsertEnter",
					config = function()
						require("copilot").setup({ enabled = true })
					end,
				},
				{
					-- support for image pasting
					"HakonHarnes/img-clip.nvim",
					event = "VeryLazy",
					opts = {
						-- recommended settings
						default = {
							embed_image_as_base64 = false,
							prompt_for_file_name = false,
							drag_and_drop = {
								insert_mode = true,
							},
							-- required for Windows users
							use_absolute_path = true,
						},
					},
				},
				{
					-- Make sure to set this up properly if you have lazy=true
					"MeanderingProgrammer/render-markdown.nvim",
					opts = {
						file_types = { "markdown", "Avante" },
					},
					ft = { "markdown", "Avante" },
				},
			},
		},
	},
}
