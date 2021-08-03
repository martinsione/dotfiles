local M = {}

function M.symbols_override()
    -- Diagnostic signs
    local diagnostic_signs = {
        Error = '',
        Warning = '',
        Hint = '',
        Information = '',
    }
    for type, icon in pairs(diagnostic_signs) do
        local hl = 'LspDiagnosticsSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

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
end

function M.disable_virtual_text()
    -- Handlers
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = true,
            signs = true,
            update_in_insert = true,
        }
    )
end

return M
