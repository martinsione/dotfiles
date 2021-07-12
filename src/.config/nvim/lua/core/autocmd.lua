U.nvim_create_augroup {
    ftplugin = {
        { "BufRead", "NvimTree", "setl scl=no" }, -- TODO: fix this
        { "FileType", "man", "setl laststatus=0 noruler" },
        { "FileType", "vim,css,javascript,sh,zsh", "setl sw=2" },
        { "TermOpen", "term://*", "setl nornu nonu nocul so=0 scl=no" },
    },
    on_save = {
        -- {'BufWritePre', '*', '%s/\s\+$//e'},            -- Remove whitespace on save
        -- {'BufWritePre', '*', '%s/\s\+$//e'},            -- Remove whitespace on save
        -- { "BufWritePost", "*.vim,*.lua", "source %" },
    },
    general = {
        {
            "TextYankPost",
            "*",
            "silent! lua vim.highlight.on_yank { timeout = 150 }",
        },
        -- { "FileType", "*", "setl formatoptions-=ro" }, -- Avoid newline continuation of comments
    },
}
