return function()
    local lspconfig = require('lspconfig')
    local lspinstall = require('lspinstall')
    local format_config = require('modules.config.format')

    local function nmap(key, cmd, opts)
        require('core.utils').keymap.buf_map('n', key, cmd, opts)
    end

    local function lua_nmap(key, cmd, opts)
        nmap(key, '<cmd>lua  ' .. cmd .. '<CR>', opts)
    end

    local function config_cpp()
        lua_nmap(
            '<space>co',
            'require("core.utils").term_wrapper("g++ %s && ./a.out", vim.fn.expand("%"))'
        )
        nmap('<space>cs', '<cmd>0r ~/.config/nvim/templates/cpp/skeleton.cpp<CR>')
    end

    local function config_typescript()
        lua_nmap(
            '<space>co',
            'require("core.utils").term_wrapper("node %s", vim.fn.expand("%"))'
        )
        require('nvim-lsp-ts-utils').setup({})
    end

    local function on_attach(client)
        lua_nmap('K', 'require("lspsaga.hover").render_hover_doc()')
        lua_nmap('gd', 'vim.lsp.buf.definition()')
        lua_nmap('gi', 'vim.lsp.buf.implementation()')
        lua_nmap('gr', 'vim.lsp.buf.references()')
        lua_nmap('ca', 'require("lspsaga.codeaction").code_action()')
        lua_nmap('<space>gh', 'require("lspsaga.signaturehelp").signature_help()')
        lua_nmap('<space>rn', 'require("lspsaga.rename").rename()')
        lua_nmap('[d', 'require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()')
        lua_nmap(']d', 'require"lspsaga.diagnostic".lsp_jump_diagnostic_next()')

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
            vim.cmd(
                [[au! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
            )
        end
    end

    -- Setup servers
    local servers = {
        efm = {
            init_options = { documentFormatting = true, codeAction = true },
            root_dir = lspconfig.util.root_pattern({ '.git/', '.' }),
            filetypes = vim.tbl_keys(format_config),
            settings = {
                languages = format_config,
            },
        },
        lua = {
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                    completion = { keywordSnippet = 'Both' },
                    runtime = {
                        version = 'LuaJIT',
                        path = vim.split(package.path, ';'),
                    },
                    workspace = {
                        library = vim.list_extend(
                            { [vim.fn.expand('$VIMRUNTIME/lua')] = true },
                            {}
                        ),
                    },
                },
            },
        },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { 'documentation', 'detail', 'additionalTextEdits' },
    }

    -- Setup servers
    lspinstall.setup()
    local installed = lspinstall.installed_servers()
    for _, server in pairs(installed) do
        local config = servers[server]
            or { root_dir = lspconfig.util.root_pattern({ '.git/', '.' }) }
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server].setup(config)
    end

    -- symbols for autocomplete
    vim.lsp.protocol.CompletionItemKind = {
        '   (Text) ',
        '   (Method)',
        '   (Function)',
        '   (Constructor)',
        ' ﴲ  (Field)',
        '[] (Variable)',
        '   (Class)',
        ' ﰮ  (Interface)',
        '   (Module)',
        ' 襁 (Property)',
        '   (Unit)',
        '   (Value)',
        ' 練 (Enum)',
        '   (Keyword)',
        '   (Snippet)',
        '   (Color)',
        '   (File)',
        '   (Reference)',
        '   (Folder)',
        '   (EnumMember)',
        ' ﲀ  (Constant)',
        ' ﳤ  (Struct)',
        '   (Event)',
        '   (Operator)',
        '   (TypeParameter)',
    }
end
