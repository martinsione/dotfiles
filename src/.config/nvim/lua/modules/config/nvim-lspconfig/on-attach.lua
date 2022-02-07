local function lua_nmap(key, cmd, opts)
  require('core.utils').keymap.buf_map('n', key, '<cmd>lua ' .. cmd .. '<CR>', opts)
end

return function(client)
  vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

  lua_nmap('K', 'vim.lsp.buf.hover()')
  lua_nmap('gd', 'vim.lsp.buf.definition()')
  lua_nmap('gD', 'vim.lsp.buf.declaration()')
  lua_nmap('gi', 'vim.lsp.buf.implementation()')
  lua_nmap('gr', 'vim.lsp.buf.references()')
  lua_nmap('<space>ca', 'vim.lsp.buf.code_action()')
  lua_nmap('<space>gh', 'vim.lsp.buf.signature_help()')
  lua_nmap('<space>rn', 'vim.lsp.buf.rename()')
  lua_nmap('<space>td', 'require"modules.config.nvim-lspconfig.ui".toggle_virtual_text()')
  lua_nmap('[d', 'vim.lsp.diagnostic.goto_prev()')
  lua_nmap(']d', 'vim.lsp.diagnostic.goto_next()')

  local lsp_signature = safe_require 'lsp_signature'
  if lsp_signature then
    lsp_signature.on_attach()
  end

  if client.name == 'tsserver' then
    local ts_utils = safe_require 'nvim-lsp-ts-utils'
    if ts_utils then
      ts_utils.setup {}
      ts_utils.setup_client(client)
    end
  end
end
