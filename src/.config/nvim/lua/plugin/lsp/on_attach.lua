local function buf_map(key, result)
  vim.api.nvim_buf_set_keymap(0, 'n', key, result, {noremap = true, silent = true})
end

local function map(key, result)
  return buf_map(key, '<cmd>lua ' .. result .. '<CR>')
end

return function(client)

  -- Mappings
  map('K', 'require("lspsaga.hover").render_hover_doc()')
  map('gd', 'vim.lsp.buf.definition()')
  map('gD', 'vim.lsp.buf.declaration()')
  map('gi', 'vim.lsp.buf.implementation()')
  map('gr', 'vim.lsp.buf.references()')
  map('ca', 'vim.lsp.buf.code_action()')
  map('<space>gh', 'vim.lsp.buf.signature_help()')
  map('<space>rn', 'require("lspsaga.rename").rename()')

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  end

end
