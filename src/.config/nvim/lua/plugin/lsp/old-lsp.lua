local lspconfig = require('lspconfig')
local on_attach = require('plugin.lsp.on_attach')
local languages = require('plugin.lsp.format')
local sumneko_root_path = utils.os.home .. '/.local/share/nvim/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. utils.os.name .. '/lua-language-server'

vim.cmd [[packadd lspsaga.nvim | packadd lspkind-nvim | packadd nvim-lsp-ts-utils]]
require('lspkind').init()

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

for server, config in pairs(servers) do
  config.on_attach = on_attach
  lspconfig[server].setup(config)
end
