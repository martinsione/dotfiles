local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local builtin = require("telescope.builtin")

-- Repos live at ~/Developer/{owner}/{repo} (plus a few at the top level), same glob as zsh's find_projects
local find_projects = function(opts)
  local root = vim.fn.expand(opts.cwd or "~/Developer")
  local git_dirs =
    vim.list_extend(vim.fn.globpath(root, "*/.git", false, true), vim.fn.globpath(root, "*/*/.git", false, true))
  return vim.tbl_map(vim.fs.dirname, git_dirs)
end

local M = {}

M.project_search = function()
  if vim.fs.root(0, ".git") then
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

      return vim
        .iter({
          args,
          {
            "--color=never",
            "--column",
            "--hidden",
            "--line-number",
            "--no-heading",
            "--smart-case",
            "--with-filename",
          },
        })
        :flatten()
        :totable()
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
      finder = finders.new_table({
        results = find_projects(opts or {}),
        entry_maker = function(line)
          return {
            display = vim.fn.fnamemodify(line, ":~"),
            ordinal = line,
            value = line,
          }
        end,
      }),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          vim.cmd.tcd({ selection.value, mods = { silent = true } })
          builtin.git_files({ cwd = selection.value })
        end)
        return true
      end,
    })
    :find()
end

return M
