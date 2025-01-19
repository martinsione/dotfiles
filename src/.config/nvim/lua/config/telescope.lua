local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
	error("This script requires nvim-telescope/telescope.nvim")
end

local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local builtin = require("telescope.builtin")

local find_projects_command = function(opts)
	--[[ Example find command
	find ~/Developer -type d \( -name node_modules -o -name build -o -name dist \) -prune -o \( -name .git -prune -print \) | sed 's/\/\.git$//'
  --]]
	opts = opts or {}
	opts.cwd = opts.cwd or os.getenv("HOME") .. "/Developer"
	opts.ignore = opts.ignore or { "node_modules", "dist", "build" }

	local find_cmd = { "find", opts.cwd, "-mindepth", "1", "-maxdepth", opts.maxdepth or "5" }

	for _, ignore_dir in ipairs(opts.ignore) do
		table.insert(find_cmd, "-type")
		table.insert(find_cmd, "d")
		table.insert(find_cmd, "-name")
		table.insert(find_cmd, ignore_dir)
		table.insert(find_cmd, "-prune")
		table.insert(find_cmd, "-o")
	end

	table.insert(find_cmd, "-type")
	table.insert(find_cmd, "d")
	table.insert(find_cmd, "-name")
	table.insert(find_cmd, ".git")
	table.insert(find_cmd, "-prune")
	table.insert(find_cmd, "-print")

	return find_cmd
end

local M = {}

M.project_search = function()
	local is_git_repo = vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true"
	if is_git_repo then
		builtin.git_files()
	else
		builtin.find_files()
	end
end

M.live_multigrep = function(opts)
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
				{
					"--color=never",
					"--column",
					"--hidden", -- include dotfiles
					"--line-number",
					"--no-heading",
					"--smart-case",
					"--with-filename",
				},
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

M.projects = function(opts)
	pickers
		.new(opts, {
			prompt_title = "Projects",
			sorter = conf.generic_sorter(opts),
			finder = finders.new_oneshot_job(find_projects_command(opts), {
				entry_maker = function(line)
					local dir = line:gsub("/%.git$", "")
					return {
						display = vim.fn.fnamemodify(dir, ":~"), -- Show path relative to home
						ordinal = dir,
						value = dir,
					}
				end,
			}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()

					local cd_scope = { tab = "tcd", window = "lcd", global = "cd" }
					vim.fn.execute(cd_scope.tab .. " " .. selection.value, "silent")
					builtin.git_files({ cwd = selection.value })
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<space>ss", function()
	builtin.find_files({
		attach_mappings = function(prompt_bufnr)
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			actions.select_default:replace(function()
				local current_picker = action_state.get_current_picker(prompt_bufnr)
				local selections = current_picker:get_multi_selection()
				-- if no multi-selection, leverage current selection
				if vim.tbl_isempty(selections) then
					table.insert(selections, action_state.get_selected_entry())
				end
				local paths = vim.tbl_map(function(e)
					return e.path
				end, selections)
				actions.close(prompt_bufnr)
				builtin.live_grep({
					search_dirs = paths,
				})
			end)
			-- true: attach default mappings; false: don't attach default mappings
			return true
		end,
	})
end)

return M
