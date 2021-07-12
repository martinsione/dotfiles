return function()

    local lspconfig = require('lspconfig')
    local lspinstall = require('lspinstall')

    local function nmap(key, cmd, opts)
        require('core.utils').keymap.buf_map('n', key, cmd, opts)
    end

    local function lua_nmap(key, cmd, opts)
        nmap(key, '<cmd>lua  ' .. cmd .. '<CR>', opts)
    end

    -- All of these are buffer mappings
    local function mappings()
        lua_nmap('K', 'require("lspsaga.hover").render_hover_doc()')
        lua_nmap('gd', 'vim.lsp.buf.definition()')
        lua_nmap('gD', 'vim.lsp.buf.declaration()')
        lua_nmap('gi', 'vim.lsp.buf.implementation()')
        lua_nmap('gr', 'vim.lsp.buf.references()')
        lua_nmap('ca', 'vim.lsp.buf.code_action()')
        lua_nmap('<space>gh', 'vim.lsp.buf.signature_help()')
        lua_nmap('<space>rn', 'require("lspsaga.rename").rename()')
        lua_nmap('[d', 'require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()')
        lua_nmap(']d', 'require"lspsaga.diagnostic".lsp_jump_diagnostic_next()')
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
        mappings()

        if client.name == 'cpp' then
            config_cpp()
        end

        if client.name == 'typescript' then
            config_typescript()
        end
    end

    local servers = {
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

    local function setup_servers()
        lspinstall.setup()
        local installed = lspinstall.installed_servers()
        for _, server in pairs(installed) do
            local config = servers[server]
                or { root_dir = lspconfig.util.root_pattern({ '.git/', '.' }) }
            config.capabilities = capabilities
            config.on_attach = on_attach
            lspconfig[server].setup(config)
        end
    end

    setup_servers()

end
