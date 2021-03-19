-- Add packages
if not packer_plugins['lspsaga.nvim'].loaded then
  vim.cmd [[packadd lspsaga.nvim]]
end
if not packer_plugins['lspkind-nvim'].loaded then
  vim.cmd [[packadd lspkind-nvim]]
end
require('lspkind').init({})

-- Lsp
local lspconfig = require('lspconfig')
local on_attach = require('plugin.lsp.on_attach')
local languages = require('plugin.lsp.format')

local sumneko_root_path = G.home .. '/.local/share/nvim/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. G.os_name .. '/lua-language-server'

local servers = {
  bashls = {},
  cssls = {},
  jsonls = {},
  html = {},
  tsserver = {},
  vimls = {},
  sumneko_lua = {
    cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
    settings = {
      Lua = {
        diagnostics = {enable = true, globals = {'vim', 'packer_plugins'}},
        runtime = {version = 'LuaJIT'},
        workspace = {library = vim.list_extend({[vim.fn.expand('$VIMRUNTIME/lua')] = true}, {})}
      }
    }
  },
  efm = {
    init_options = {documentFormatting = true, codeAction = true},
    root_dir = lspconfig.util.root_pattern({'.git/', 'vim.fn.getcwd()'}),
    filetypes = vim.tbl_keys(languages),
    settings = {languages = languages, log_level = 1, log_file = '~/efm.log'}
  }
}

for ls, config in pairs(servers) do
  config.on_attach = function(client)
    if client.name ~= 'efm' then
      client.resolved_capabilities.document_formatting = false
    end
    on_attach(client)
  end
  lspconfig[ls].setup(config)
end
