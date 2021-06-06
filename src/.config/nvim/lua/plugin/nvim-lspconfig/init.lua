local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')
local languages = require('plugin.nvim-lspconfig.format')
local on_attach = require('plugin.nvim-lspconfig.on_attach')

local servers = {
  efm = {
    init_options = {documentFormatting = true, codeAction = true},
    root_dir = lspconfig.util.root_pattern({'.git/', '.'}),
    filetypes = vim.tbl_keys(languages),
    settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
  },
  lua = {
    settings = {
      Lua = {
        diagnostics = {globals = {'vim', 'packer_plugins'}},
        completion = {keywordSnippet = 'Both'},
        runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
        workspace = {library = vim.list_extend({[vim.fn.expand('$VIMRUNTIME/lua')] = true}, {})},
      },
    },
  },
}

local function setup_servers()
  lspinstall.setup()
  local installed = lspinstall.installed_servers()
  for _, server in pairs(installed) do
    local config = servers[server] or {root_dir = lspconfig.util.root_pattern({'.git/', '.'})}
    config.on_attach = on_attach
    lspconfig[server].setup(config)
  end
end

setup_servers()
