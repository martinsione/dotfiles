local eslint = {
  lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c: %m'},
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin = true,
}

local prettier = {formatCommand = 'npx prettier --stdin-filepath ${INPUT}', formatStdin = true}

local luaformatter = {formatCommand = 'lua-format -i', formatStdin = true}

return {
  css = {prettier},
  html = {prettier},
  javascript = {prettier, eslint},
  javascriptreact = {prettier, eslint},
  json = {prettier},
  lua = {luaformatter},
  markdown = {prettier},
  scss = {prettier},
  typescript = {prettier, eslint},
  typescriptreact = {prettier, eslint},
  yaml = {prettier},
}
