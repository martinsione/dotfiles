require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
    ensure_installed = "maintained",
    indent = { enable = true },
    autopairs = { enable = true },
    rainbow = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true },
}
