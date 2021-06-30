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

function U.term_wrapper(command, argument)
  local term_style, buffercmd
  -- term_style = 'horizontal'
  if term_style == 'horizontal' then
    buffercmd = 'new' -- Horizontal
  else
    buffercmd = 'vnew' -- Vertical
  end
  vim.cmd(buffercmd)
  -- NOTE: Run command accepts 2 params
  -- 1: Default terminal command, between quotes
  -- 2: Optional: a string format argument with %
  -- Eg: term_wrapper('echo I am editing %s', vim.fn.expand("%"))
  vim.cmd('term ' .. string.format(command, argument))
  vim.cmd('setl nornu nonu nocul so=0 scl=no') -- Sets for terminal
  vim.cmd('startinsert')
end

-- Autocmds
function U.nvim_create_augroup(definitions) -- {{{1
  for group_name, definition in pairs(definitions) do
    vim.cmd('augroup ' .. group_name)
    vim.cmd('autocmd!')
    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
      vim.cmd(command)
    end
    vim.cmd('augroup END')
  end
end

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

function U.keymap.buf_nmap(lhs, rhs, opts) return make_map('n', lhs, rhs, opts, 'buffer') end

function U.keymap.nmap(lhs, rhs, opts) return make_map('n', lhs, rhs, opts) end

function U.keymap.imap(lhs, rhs, opts) return make_map('i', lhs, rhs, opts) end

function U.keymap.xmap(lhs, rhs, opts) return make_map('x', lhs, rhs, opts) end

function U.keymap.tmap(lhs, rhs, opts) return make_map('t', lhs, rhs, opts) end

function U.keymap.smap(lhs, rhs, opts) return make_map('s', lhs, rhs, opts) end

function U.keymap.cmap(lhs, rhs) return make_map('c', lhs, rhs, {silent = false, noremap = false}) end
