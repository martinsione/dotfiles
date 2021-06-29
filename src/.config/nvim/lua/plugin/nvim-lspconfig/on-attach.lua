local buf_nmap = U.keymap.buf_nmap
local function lua_nmap(lhs, rhs, opts)
  buf_nmap(lhs, '<cmd>lua  ' .. rhs .. '<CR>', opts)
end

-- All of these are buffer mappings
local function mappings()
  lua_nmap('K', 'require("lspsaga.hover").render_hover_doc()')
  lua_nmap('gd', 'vim.lsp.buf.definition()')
  lua_nmap('gD', 'vim.lsp.buf.declaration()')
  lua_nmap('gi', 'vim.lsp.buf.implementation()')
  lua_nmap('gr', 'vim.lsp.buf.references()')
  lua_nmap('ca', 'vim.lsp.buf.code_action()')
  lua_nmap('<space>gh', 'vim.lsp.buf.signature_help()')
  lua_nmap('<space>rn', 'require("lspsaga.rename").rename()')
  lua_nmap('[d', 'require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()')
  lua_nmap(']d', 'require"lspsaga.diagnostic".lsp_jump_diagnostic_next()')
end

-- TODO: Implement this
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {'documentation', 'detail', 'additionalTextEdits'},
-- }

return function(client)

  -- vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  mappings()

  if client.name ~= 'efm' then client.resolved_capabilities.document_formatting = false end

  -- if client.name == 'typescript' then require('nvim-lsp-ts-utils').setup {} end

  if client.name == 'cpp' then
    lua_nmap('<space>co', 'U.term_wrapper("g++ %s && ./a.out", vim.fn.expand("%"))')
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  end

end
