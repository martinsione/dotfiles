local nmap = function(lhs, rhs, opts)
  utils.keymap.buf_map('n', lhs, '<cmd>lua  ' .. rhs .. '<CR>', opts)
end

local function mappings()
  nmap('K', 'require("lspsaga.hover").render_hover_doc()')
  nmap('gd', 'vim.lsp.buf.definition()')
  nmap('gD', 'vim.lsp.buf.declaration()')
  nmap('gi', 'vim.lsp.buf.implementation()')
  nmap('gr', 'vim.lsp.buf.references()')
  nmap('ca', 'vim.lsp.buf.code_action()')
  nmap('<space>gh', 'vim.lsp.buf.signature_help()')
  nmap('<space>rn', 'require("lspsaga.rename").rename()')
end

return function(client)

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  mappings()

  if client.name ~= 'efm' then client.resolved_capabilities.document_formatting = false end

  if client.name == 'typescript' then require('nvim-lsp-ts-utils').setup {} end

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  end

  require('illuminate').on_attach(client)

end
