local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local custom = {}

custom.live_multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local pieces = vim.split(prompt, "  ")
			local args = { "rg" }
			if pieces[1] then
				table.insert(args, "-e")
				table.insert(args, pieces[1])
			end

			if pieces[2] then
				table.insert(args, "-g")
				table.insert(args, pieces[2])
			end

			---@diagnostic disable-next-line: deprecated
			return vim.tbl_flatten({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Multi Grep",
			finder = finder,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end

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
				defaults = require("telescope.themes").get_ivy({
					extensions = { fzf = {} },
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
			local builtin = require("telescope.builtin")
			map("n", "<space>ff", builtin.find_files, { desc = "Search files" })
			map("n", "<space>fh", builtin.help_tags, { desc = "Search for help" })
			map("n", "<C-p>", function()
				builtin.git_files()
			end, { desc = "Search git project" })

			-- Neovim stuff
			map("n", "<space>fnc", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "Search neovim config" })

			map("n", "<space>fnp", function()
				builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
			end, { desc = "Search neovim plugins" })

			-- Live multigrep
			map("n", "<space>fw", custom.live_multigrep, { desc = "Search neovim plugins" })
		end,
	},
}
