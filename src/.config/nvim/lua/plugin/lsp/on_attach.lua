local function map(key, result)
  vim.api.nvim_buf_set_keymap(0, 'n', key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
end

return function (client, bufnr)

  -- Mappings
  map('K',           'require("lspsaga.hover").render_hover_doc()')
  map('gd',          'vim.lsp.buf.definition()')
  map('gD',          'vim.lsp.buf.declaration()')
  map('gi',          'vim.lsp.buf.implementation()')
  map('gr',          'vim.lsp.buf.references()')
  map('ca',          'vim.lsp.buf.code_action()')
  map('<space>gh',   'vim.lsp.buf.signature_help()')
  map('<space>rn',   'require("lspsaga.rename").rename()')

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- if client.name == "tsserver" then
  --   client.resolved_capabilities.document_formatting = false
  -- end

end
