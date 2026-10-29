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

local project_search = function()
  if vim.fs.root(0, ".git") then
    builtin.git_files()
  else
    builtin.find_files()
  end
end

local live_multigrep = function(opts)
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

local projects = function(opts)
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

map("n", "<space>fd", function()
  -- the dotfiles repo is wherever this config is symlinked from
  live_multigrep({ cwd = vim.fs.root(vim.fn.resolve(vim.fn.stdpath("config")), ".git") })
end, { desc = "Search dotfiles" })
map("n", "<space>fw", live_multigrep, { desc = "Search words" })
map("n", "<space>fp", projects, { desc = "Search projects" })
map("n", "<space><space>", builtin.buffers, { desc = "Search buffers" })
map("n", "<space>ff", builtin.find_files, { desc = "Search files" })
map("n", "<space>fh", builtin.help_tags, { desc = "Search for help" })
map("n", "<space>gs", builtin.git_status, { desc = "Search for modified files" })
map("n", "<C-p>", project_search, { desc = "Search git project" })

map("n", "<space>ss", function()
  builtin.find_files({
    attach_mappings = function(prompt_bufnr)
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
  builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt") })
end, { desc = "Search neovim plugins" })
