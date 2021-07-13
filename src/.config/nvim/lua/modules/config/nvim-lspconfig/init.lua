return function()
    local lspconfig = require('lspconfig')
    local lspinstall = require('lspinstall')
    local on_attach = require('modules.config.nvim-lspconfig.on-attach')
    local format_config = require('modules.config.nvim-lspconfig.format')

    -- symbols for completion
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

    local servers = {
        efm = {
            init_options = { documentFormatting = true, codeAction = true },
            root_dir = lspconfig.util.root_pattern({ '.git/', '.' }),
            filetypes = vim.tbl_keys(format_config),
            settings = { languages = format_config },
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
