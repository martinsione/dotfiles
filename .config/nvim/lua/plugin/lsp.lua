local lspconfig = require('lspconfig')
local nvim_status = require('lsp-status')
local completion = require('completion')

lspconfig.tsserver.setup({
  cmd = {"typescript-language-server", "--stdio"},
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  on_attach = completion.on_attach
})

-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
--   on_attach = completion.on_attach
-- })
