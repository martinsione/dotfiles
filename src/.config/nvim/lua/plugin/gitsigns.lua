require("gitsigns").setup {
    signs = {
        add = { hl = "GitSignsAdd", text = "▎" },
        change = { hl = "GitSignsChange", text = "▎" },
        delete = { hl = "GitSignsDelete", text = "契" },
        topdelete = { hl = "GitSignsDelete", text = "契" },
        changedelete = { hl = "GitSignsChange", text = "▎" },
    },
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ["n ]g"] = {
            expr = true,
            "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
        },
        ["n [g"] = {
            expr = true,
            "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
        },

        -- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        -- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        -- ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        -- ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        -- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

        -- Text objects
        -- ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        -- ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
    },
}
