return function()
    local actions = require('telescope.actions')
    local sorters = require('telescope.sorters')

    require('telescope').setup({
        defaults = {
            prompt_prefix = '❯ ',
            selection_caret = '❯ ',
            layout_config = { horizontal = { preview_width = 0.5 } },
            file_sorter = sorters.get_fzy_sorter,
            file_ignore_patterns = { 'node_modules/.*', '%.env', 'git/.*' },
            mappings = {
                i = {
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                },
                n = { ['<C-c>'] = actions.close },
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = true,
                override_file_sorter = true,
            },
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        --  "ignore_case" / "respect_case" / "smart_case" (default)
            }
        },
    })


    pcall(require("telescope").load_extension, "fzy_native")
    pcall(require("telescope").load_extension, "fzf")

    local M = {}

    function M.find_dotfiles()
        require('telescope.builtin').find_files({
            prompt_title = ' Dotfiles ',
            find_command = { 'rg', '--files', '--hidden', '--sort=path' },
            cwd = '$HOME/.dotfiles',
        })
    end

    return M
end
