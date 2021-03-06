
function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function nmap(lhs, rhs, opts)
  return map('n', lhs, rhs, opts)
end

function imap(lhs, rhs, opts)
  return map('i', lhs, rhs, opts)
end

function xmap(lhs, rhs, opts)
  return map('x', lhs, rhs, opts)
end

function tmap(lhs, rhs, opts)
  return map('t', lhs, rhs, opts)
end

function cmap(lhs, rhs)
  -- { silent } need to be false to work
  return map('c', lhs, rhs, { silent = false })
end

