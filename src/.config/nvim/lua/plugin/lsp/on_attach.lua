local function map(key, result)
  local opts = {noremap = true, silent = true}
  vim.api.nvim_buf_set_keymap(0, 'n', key, '<cmd>lua  ' .. result .. '<CR>', opts)
end

local function mappings()
  map('K', 'require("lspsaga.hover").render_hover_doc()')
  map('gd', 'vim.lsp.buf.definition()')
  map('gD', 'vim.lsp.buf.declaration()')
  map('gi', 'vim.lsp.buf.implementation()')
  map('gr', 'vim.lsp.buf.references()')
  map('ca', 'vim.lsp.buf.code_action()')
  map('<space>gh', 'vim.lsp.buf.signature_help()')
  map('<space>rn', 'require("lspsaga.rename").rename()')
end

return function(client)

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  mappings()

  if client.name ~= 'efm' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  end

  require('illuminate').on_attach(client)

end
