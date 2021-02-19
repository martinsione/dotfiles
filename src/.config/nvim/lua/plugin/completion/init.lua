local lspconfig = require('lspconfig')
local on_attach = require'compe'.on_attach
vim.o.completeopt = "menuone,noinsert,noselect"

lspconfig.tsserver.setup{
  root_dir = function() return vim.loop.cwd() end,
  on_attach=on_attach
}

lspconfig.cssls.setup{ on_attach = on_attach }
lspconfig.html.setup{ on_attach = on_attach }
lspconfig.jsonls.setup{ on_attach = on_attach }
lspconfig.vimls.setup({ on_attach = on_attach })

-- Completion setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

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
    treesitter = true;
  };
}

vim.cmd [[inoremap <silent><expr> <CR>      compe#confirm('<CR>')]]
