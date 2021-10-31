return function()
  local cmp = safe_require 'cmp'
  local luasnip = safe_require 'luasnip'
  local lspkind = safe_require 'lspkind'
  if not cmp or not luasnip or not lspkind then
    return
  end

  vim.opt.completeopt = 'menu,menuone,noselect'

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format {
        with_text = false,
        menu = {
          buffer = '[buf]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[api]',
          path = '[path]',
          luasnip = '[snip]',
        },
      },
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    },
    mapping = {
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end),
    },
    -- Sources order are actually their priority order
    sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'luasnip', keyword_length = 2 },
      { name = 'buffer', keyword_length = 5 },
      { name = 'path' },
      { name = 'emoji' },
    },
  }
end
