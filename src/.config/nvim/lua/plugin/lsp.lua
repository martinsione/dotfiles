local lspconfig = require('lspconfig')
local completion = require'compe'.setup{
  enabled = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  allow_prefix_unmatch = false;
  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
  };
}

lspconfig.tsserver.setup{
  root_dir = function() return vim.loop.cwd() end,
  on_attach = completion
}

lspconfig.bashls.setup{
  filetypes = {"sh", "zsh", "bash"}
}

local servers = {
  'cssls', 'jsonls', 'html', 'vimls'
}

for _,server in ipairs(servers) do
  lspconfig[server].setup{ on_attach = completion }
end
