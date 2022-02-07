return function()
  local null_ls = safe_require 'null-ls'
  if not null_ls then
    return
  end

  local format = null_ls.builtins.formatting

  null_ls.setup {
    sources = {
      format.stylua,
    },

    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd [[
          augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
          augroup END
        ]]
      end
    end,
  }
end
