local utils = require('core.utils')

local function nmap(key, cmd, opts)
    utils.keymap.buf_map('n', key, cmd, opts)
end

local function lua_nmap(key, cmd, opts)
    nmap(key, '<cmd>lua  ' .. cmd .. '<CR>', opts)
end

local function config_cpp()
    lua_nmap(
        '<F9>',
        'require("core.utils").term_wrapper("g++ %s && ./a.out", vim.fn.expand("%"))'
    )
    nmap('<space>cs', '<cmd>0r ~/.config/nvim/templates/cpp/skeleton.cpp<CR>')
end

local function config_typescript()
    lua_nmap(
        '<F9>',
        'require("core.utils").term_wrapper("node %s", vim.fn.expand("%"))'
    )
    require('nvim-lsp-ts-utils').setup({})
end

return function(client)
    vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

    lua_nmap('K', 'vim.lsp.buf.hover()')
    lua_nmap('gd', 'vim.lsp.buf.definition()')
    lua_nmap('gD', 'vim.lsp.buf.declaration()')
    lua_nmap('gi', 'vim.lsp.buf.implementation()')
    lua_nmap('gr', 'vim.lsp.buf.references()')
    lua_nmap('<space>ca', 'vim.lsp.buf.code_action()')
    lua_nmap('<space>gh', 'vim.lsp.buf.signature_help()')
    lua_nmap('<space>rn', 'vim.lsp.buf.rename()')
    lua_nmap('[d', 'vim.lsp.diagnostic.goto_prev()')
    lua_nmap(']d', 'vim.lsp.diagnostic.goto_next()')

    require('lsp_signature').on_attach()

    if client.name == 'cpp' then
        config_cpp()
    end

    if client.name == 'typescript' then
        config_typescript()
    end

    -- So that the only client with format capabilities is efm
    if client.name ~= 'efm' then
        client.resolved_capabilities.document_formatting = false
    end

    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup Format
              au! * <buffer>
              au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
            augroup END
        ]])
    end
end
