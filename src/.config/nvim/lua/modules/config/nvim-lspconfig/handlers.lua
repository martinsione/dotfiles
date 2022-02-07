local M = {}

M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  vim.diagnostic.config {
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

local function lua_nmap(key, cmd, opts)
  require('core.utils').keymap.buf_map('n', key, '<cmd>lua ' .. cmd .. '<CR>', opts)
end

function M.on_attach(client, bufnr)
  lua_nmap('K', 'vim.lsp.buf.hover()')
  lua_nmap('gd', 'vim.lsp.buf.definition()')
  lua_nmap('gD', 'vim.lsp.buf.declaration()')
  lua_nmap('gi', 'vim.lsp.buf.implementation()')
  lua_nmap('gr', 'vim.lsp.buf.references()')
  lua_nmap('<space>ca', 'vim.lsp.buf.code_action()')
  lua_nmap('<space>gh', 'vim.lsp.buf.signature_help()')
  lua_nmap('<space>rn', 'vim.lsp.buf.rename()')
  lua_nmap('[d', 'vim.lsp.diagnostic.goto_prev()')
  lua_nmap(']d', 'vim.lsp.diagnostic.goto_next()')

  local lsp_signature = safe_require 'lsp_signature'
  if lsp_signature then
    lsp_signature.on_attach()
  end

  if client.name ~= 'null-ls' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.name == 'tsserver' then
    local ts_utils = safe_require 'nvim-lsp-ts-utils'
    if ts_utils then
      ts_utils.setup {}
      ts_utils.setup_client(client)
    end
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_nvim_lsp = safe_require 'cmp_nvim_lsp'
if cmp_nvim_lsp then
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end
M.capabilities = capabilities

function M.enable_format_on_save()
  vim.cmd [[
    augroup format_on_save
      au!
      au BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 2000)
    augroup end
  ]]
end

function M.toggle_format_on_save()
  if vim.fn.exists '#format_on_save#BufWritePre' == 0 then
    M.enable_format_on_save()
    vim.notify 'Enabled format on save'
  else
    vim.cmd 'au! format_on_save'
    vim.notify 'Disabled format on save'
  end
end

vim.cmd [[command! LspToggleAutoFormat execute 'lua require("modules.config.nvim-lspconfig.handlers").toggle_format_on_save()']]

return M
