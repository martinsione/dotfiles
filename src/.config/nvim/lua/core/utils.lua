U = {}

-- Os
U.os = {
  home = os.getenv('HOME'),
  data = vim.fn.stdpath('data'),
  cache = vim.fn.stdpath('cache'),
  config = vim.fn.stdpath('config'),
  name = vim.loop.os_uname().sysname,
  is_git_dir = os.execute('git rev-parse --is-inside-work-tree >> /dev/null 2>&1'),
}

-- Keybindings
U.keymap = {}

local function make_map(mode, lhs, rhs, opts, scope)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  if scope == nil then
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
  end
end

function U.keymap.buf_nmap(lhs, rhs, opts)
  return make_map('n', lhs, rhs, opts, 'buffer')
end

function U.keymap.nmap(lhs, rhs, opts)
  return make_map('n', lhs, rhs, opts)
end

function U.keymap.imap(lhs, rhs, opts)
  return make_map('i', lhs, rhs, opts)
end

function U.keymap.xmap(lhs, rhs, opts)
  return make_map('x', lhs, rhs, opts)
end

function U.keymap.tmap(lhs, rhs, opts)
  return make_map('t', lhs, rhs, opts)
end

function U.keymap.cmap(lhs, rhs)
  return make_map('c', lhs, rhs, {silent = false, noremap = false})
end
