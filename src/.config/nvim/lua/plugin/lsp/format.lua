local lspconfig = require('lspconfig')
local on_attach = require('plugin.lsp.on_attach')

local eslint = {
  lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c: %m'},
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin = true
}

local prettier = {
  formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}',
  formatStdin = true
}

local luaformatter = {formatCommand = 'lua-format -i', formatStdin = true}

local languages = {
  typescript = {prettier, eslint},
  javascript = {prettier, eslint},
  typescriptreact = {prettier, eslint},
  javascriptreact = {prettier, eslint},
  yaml = {prettier},
  json = {prettier},
  html = {prettier},
  scss = {prettier},
  css = {prettier},
  markdown = {prettier},
  lua = {luaformatter}
}

return lspconfig.efm.setup {
  init_options = {documentFormatting = true, codeAction = true},
  root_dir = lspconfig.util.root_pattern('.git/'),
  filetypes = vim.tbl_keys(languages),
  settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
  on_attach = on_attach
}
