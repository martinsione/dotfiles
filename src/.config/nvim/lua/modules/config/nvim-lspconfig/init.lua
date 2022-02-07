return function()
  local lspconfig = safe_require 'lspconfig'
  if not lspconfig then
    return
  end

  local on_attach = require 'modules.config.nvim-lspconfig.on-attach'
  require('modules.config.nvim-lspconfig.ui').setup()

  local servers = {}

  local function get_config(server_name)
    local config = servers[server_name] or {}
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if package.loaded['cmp_nvim_lsp'] then
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    end
    config.on_attach = on_attach
    return config
  end

  require('nvim-lsp-installer').on_server_ready(function(server)
    server:setup(get_config(server.name))
    vim.cmd [[ do User LspAttachBuffers ]]
  end)
end
