local M = {}

M.setup = function()
  local null_ls = safe_require 'null-ls'
  if not null_ls then
    return
  end

  local format = null_ls.builtins.formatting
  local diagnostic = null_ls.builtins.diagnostics

  null_ls.setup {
    sources = {
      diagnostic.eslint,
      format.prettierd,
      format.stylua,
    },
  }
end

return M
