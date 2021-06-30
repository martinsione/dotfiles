local buf_nmap = U.keymap.buf_nmap
local function lua_nmap(lhs, rhs, opts) buf_nmap(lhs, '<cmd>lua  ' .. rhs .. '<CR>', opts) end

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

local function config_cpp()
  lua_nmap('<space>co', 'U.term_wrapper("g++ %s && ./a.out", vim.fn.expand("%"))')
  buf_nmap('<space>cs', '<cmd>0r ~/.config/nvim/templates/cpp/skeleton.cpp<CR>')
end

local function config_typescript()
  lua_nmap('<space>co', 'U.term_wrapper("node %s", vim.fn.expand("%"))')
  require('nvim-lsp-ts-utils').setup {}
end

return function(client)
  mappings()

  if client.name == 'cpp' then config_cpp() end
  if client.name == 'typescript' then config_typescript() end

  -- So the only client with format capabilities is efm
  if client.name ~= 'efm' then client.resolved_capabilities.document_formatting = false end
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  end
end
