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

-- Mappings
imap('<CR>',        'compe#confirm("<CR>")', {expr = true})
-- Lsp
nmap('K',           '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
nmap('gd',          '<cmd>lua vim.lsp.buf.definition()<CR>')
nmap('gi',          '<cmd>lua vim.lsp.buf.implementation()<CR>')
nmap('gr',          '<cmd>lua vim.lsp.buf.references()<CR>')
nmap('<space>ca',   '<cmd>lua vim.lsp.buf.code_action()<CR>')
nmap('<space>gh',   '<cmd>lua vim.lsp.buf.signature_help()<CR>')
nmap('<space>rn',   '<cmd>lua require("lspsaga.rename").rename()<CR>')
