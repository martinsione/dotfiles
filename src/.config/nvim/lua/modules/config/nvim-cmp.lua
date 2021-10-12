return function()
  vim.opt.completeopt = 'menu,menuone,noselect'
  local cmp = require 'cmp'

  local check_back_space = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
  end

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  cmp.setup {
    preselect = 'item',
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },
    mapping = {
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t '<C-n>', 'n')
        elseif vim.fn.call('vsnip#available', { 1 }) == 1 then
          vim.fn.feedkeys(t '<Plug>(vsnip-expand-or-jump)', '')
        elseif check_back_space() then
          vim.fn.feedkeys(t '<Tab>', 'n')
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t '<C-p>', 'n')
        elseif vim.fn.call('vsnip#jumpable', { -1 }) == 1 then
          vim.fn.feedkeys(t '<Plug>(vsnip-jump-prev)', '')
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
    },
    sources = {
      { name = 'buffer' },
      { name = 'emoji' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'vsnip' },
    },
  }
end
