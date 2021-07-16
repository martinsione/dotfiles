return function()
    require('nvim-treesitter.configs').setup({
        highlight = {
            enable = true,
            disable = { 'json' },
        },
        ensure_installed = 'maintained',
        indent = { enable = true },
        autopairs = { enable = true },
        rainbow = { enable = true },
        autotag = { enable = true },
        context_commentstring = { enable = true },
    })
end
