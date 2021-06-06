_G.utils = {}

-- Os
utils.os = {
  home = os.getenv('HOME'),
  data = vim.fn.stdpath('data'),
  cache = vim.fn.stdpath('cache'),
  config = vim.fn.stdpath('config'),
  name = vim.loop.os_uname().sysname,
  is_git_dir = os.execute('git rev-parse --is-inside-work-tree >> /dev/null 2>&1'),
}

utils.plugin = {}

function utils.plugin.require(plugin)
  local fmt = string.format
  local plugin_name = utils.os.data .. '/site/pack/packer/opt/' .. plugin .. '/'
  local ok, err, code = os.rename(plugin_name, plugin_name)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  if ok then
    vim.cmd('packadd ' .. plugin)
    -- Regex to remove after a dot | f stands for fuckin dot
    local fdot = string.gsub(plugin, '%.[^.]*$', '')
    -- Require plugin config if exists
    pcall(function()
      require(fmt('plugin.%s', fdot))
    end)
  end
  return ok, err, code
end

-- Colorscheme
function utils.colorscheme(name)
  pcall(function()
    vim.cmd('colorscheme ' .. name)
  end)
end

-- Keybindings
utils.keymap = {}

local function make_map(mode, lhs, rhs, opts, scope)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  if scope == nil then
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
  end
end

function utils.keymap.buf_map(mode, lhs, rhs, opts)
  return make_map(mode, lhs, rhs, opts, 'buffer')
end

function utils.keymap.nmap(lhs, rhs, opts)
  return make_map('n', lhs, rhs, opts)
end

function utils.keymap.imap(lhs, rhs, opts)
  return make_map('i', lhs, rhs, opts)
end

function utils.keymap.xmap(lhs, rhs, opts)
  return make_map('x', lhs, rhs, opts)
end

function utils.keymap.tmap(lhs, rhs, opts)
  return make_map('t', lhs, rhs, opts)
end

function utils.keymap.cmap(lhs, rhs)
  return make_map('c', lhs, rhs, {silent = false, noremap = false})
end
