local M = {}

function P(cmd)
  print(vim.inspect(cmd))
end

function _G.is_git_dir()
  return os.execute 'git rev-parse --is-inside-work-tree >> /dev/null 2>&1'
end

function _G.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(string.format('Error requiring: %s', module), vim.log.levels.ERROR)
    return ok
  end
  return result
end

local is_transparent = true
function M.toggle_background()
  if is_transparent == true then
    vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
    is_transparent = false
  else
    vim.cmd [[ set background=dark ]]
    is_transparent = true
  end
end

-- Mappings
M.keymap = {}

local options = { noremap = true, silent = true }

function M.keymap.buf_map(mode, key, cmd, opts)
  vim.api.nvim_buf_set_keymap(0, mode, key, cmd, opts or options)
end

function M.keymap.map(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts or options)
end

return M
