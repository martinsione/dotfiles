vim.cmd [[packadd lspsaga.nvim]]
local lspconfig = require('lspconfig')

local sumneko_root_path = G.home.."/.local/share/nvim/lsp/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/"..G.os_name.."/lua-language-server"

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {"vim","packer_plugins"}
      },
      runtime = {version = "LuaJIT"},
      workspace = {
        library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
      },
    },
  }
}

lspconfig.bashls.setup{
  filetypes = {"sh", "zsh", "bash"}
}

local servers = {
  'cssls',
  'jsonls',
  'html',
  'tsserver',
  'vimls'
}

for _,server in ipairs(servers) do
  lspconfig[server].setup{}
end


-- Mappings
nmap('K',           '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
nmap('gd',          '<cmd>lua vim.lsp.buf.definition()<CR>')
nmap('gD',          '<cmd>lua vim.lsp.buf.declaration()<CR>')
nmap('gi',          '<cmd>lua vim.lsp.buf.implementation()<CR>')
nmap('gr',          '<cmd>lua vim.lsp.buf.references()<CR>')
nmap('ca',          '<cmd>lua vim.lsp.buf.code_action()<CR>')
nmap('<space>gh',   '<cmd>lua vim.lsp.buf.signature_help()<CR>')
nmap('<space>rn',   '<cmd>lua require("lspsaga.rename").rename()<CR>')
