return function()
  local lspconfig = require 'lspconfig'
  local lspinstall = require 'lspinstall'
  local on_attach = require 'modules.config.nvim-lspconfig.on-attach'
  local format_config = require 'modules.config.nvim-lspconfig.format'
  require('modules.config.nvim-lspconfig.ui').symbols_override()
  require('modules.config.nvim-lspconfig.ui').disable_virtual_text()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
  }

  local servers = {
    efm = {
      init_options = { documentFormatting = true, codeAction = true },
      root_dir = lspconfig.util.root_pattern { '.git/', '.' },
      filetypes = vim.tbl_keys(format_config),
      settings = { languages = format_config },
    },
    lua = {
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          completion = { keywordSnippet = 'Both' },
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          workspace = {
            library = vim.list_extend({ [vim.fn.expand '$VIMRUNTIME/lua'] = true }, {}),
          },
        },
      },
    },
  }

  -- Setup servers
  local function setup_servers()
    lspinstall.setup()
    local installed = lspinstall.installed_servers()
    for _, server in pairs(installed) do
      local config = servers[server] or { root_dir = lspconfig.util.root_pattern { '.git/', '.' } }
      config.capabilities = capabilities
      config.on_attach = on_attach
      lspconfig[server].setup(config)
    end
  end

  setup_servers()
end
