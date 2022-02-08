return function()
  local lspconfig = safe_require 'lspconfig'
  if not lspconfig then
    return
  end

  require('modules.config.lsp.handlers').setup()
  require('modules.config.lsp.handlers').enable_format_on_save()
  require('modules.config.lsp.null-ls').setup()

  local servers = {
    -- https://github.com/pedro757/emmet
    -- npm i -g ls_emmet (In order to override the default emmet-ls)
    emmet_ls = {
      cmd = { 'ls_emmet', '--stdio' },
      filetypes = { 'html', 'css', 'scss', 'sass', 'javascript', 'javascriptreact', 'typescriptreact' },
    },
    jsonls = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      },
    },
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
    config.capabilities = require('modules.config.lsp.handlers').capabilities
    config.on_attach = require('modules.config.lsp.handlers').on_attach
    server:setup(config)
  end)
end
