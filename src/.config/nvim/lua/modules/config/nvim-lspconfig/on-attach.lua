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
    lua_nmap('K', 'require"lspsaga.hover".render_hover_doc()')
    lua_nmap('gd', 'vim.lsp.buf.definition()')
    lua_nmap('gi', 'vim.lsp.buf.implementation()')
    lua_nmap('gr', 'vim.lsp.buf.references()')
    lua_nmap('ca', 'require"lspsaga.codeaction".code_action()')
    lua_nmap('<space>gh', 'require"lspsaga.signaturehelp".signature_help()')
    lua_nmap('<space>rn', 'require"lspsaga.rename".rename()')
    lua_nmap('[d', 'require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()')
    lua_nmap(']d', 'require"lspsaga.diagnostic".lsp_jump_diagnostic_next()')

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
              au BufWritePost <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
            augroup END
        ]])
    end
end
