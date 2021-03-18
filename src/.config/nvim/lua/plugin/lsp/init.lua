local lspconfig = require('lspconfig')
local on_attach = require('plugin.lsp.on_attach')

-- Formatting
require('plugin.lsp.format')

if not packer_plugins['lspsaga.nvim'].loaded then
  vim.cmd [[packadd lspsaga.nvim]]
end

-- Sumneko...
local sumneko_root_path = G.home .. '/.local/share/nvim/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. G.os_name .. '/lua-language-server'

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
  settings = {
    Lua = {
      diagnostics = {enable = true, globals = {'vim', 'packer_plugins'}},
      runtime = {version = 'LuaJIT'},
      workspace = {library = vim.list_extend({[vim.fn.expand('$VIMRUNTIME/lua')] = true}, {})}
    }
  },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false, on_attach(client)
  end
}

local servers = {'bashls', 'cssls', 'jsonls', 'html', 'tsserver', 'vimls'}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false, on_attach(client)
    end
  }
end
