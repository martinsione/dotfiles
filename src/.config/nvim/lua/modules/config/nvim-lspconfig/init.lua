return function()
  local lspconfig = safe_require 'lspconfig'
  if not lspconfig then
    return
  end

  require('modules.config.nvim-lspconfig.handlers').setup()
  require('modules.config.nvim-lspconfig.handlers').enable_format_on_save()
  require('modules.config.nvim-lspconfig.null-ls').setup()

  local servers = {
    sumneko_lua = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    },
  }

  require('nvim-lsp-installer').on_server_ready(function(server)
    local config = servers[server.name] or {}
    config.capabilities = require('modules.config.nvim-lspconfig.handlers').capabilities
    config.on_attach = require('modules.config.nvim-lspconfig.handlers').on_attach
    server:setup(config)
  end)
end
