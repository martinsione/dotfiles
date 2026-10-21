local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local builtin = require("telescope.builtin")

local find_projects_command = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or os.getenv("HOME") .. "/Developer"
  opts.ignore = opts.ignore or { "node_modules", "dist", "build" }

  local find_cmd = { "find", vim.fn.expand(opts.cwd), "-mindepth", "1", "-maxdepth", tostring(opts.maxdepth or "5") }

  for _, ignore_dir in ipairs(opts.ignore) do
    vim.list_extend(find_cmd, { "-type", "d", "-name", ignore_dir, "-prune", "-o" })
  end
  vim.list_extend(find_cmd, { "-type", "d", "-name", ".git", "-prune", "-print" })

  local escaped_find_cmd = vim.tbl_map(vim.fn.shellescape, find_cmd)

  return {
    "sh",
    "-c",
    table.concat(escaped_find_cmd, " ")
      .. " | while IFS= read -r git_path; do "
      .. 'repo_dir=${git_path%/.git}; git -C "$repo_dir" rev-parse --show-toplevel 2>/dev/null; '
      .. "done | sort -u",
  }
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
      finder = finders.new_oneshot_job(find_projects_command(opts), {
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
