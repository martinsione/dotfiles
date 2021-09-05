return function()
    local cmp = require('cmp')
    cmp.setup({
        preselect = 'item',

        snippet = {
            expand = function(args)
                vim.fn['vsnip#anonymous'](args.body)
            end,
        },
        mapping = {
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
        },
        sources = {
            { name = 'buffer' },
            { name = 'emoji' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'vsnip' },
        },
    })

    require('nvim-autopairs.completion.cmp').setup({
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` after select function or method item
        auto_select = true, -- automatically select the first item
    })
end
