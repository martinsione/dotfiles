return function()
    local gl = require('galaxyline')
    local gls = gl.section
    local condition = require('galaxyline.condition')
    gl.short_line_list = { 'NvimTree', 'packer', 'term://*', 'dashboard' }

    local colors = {}

    if vim.g.colors_name == 'gruvbox' then
        colors = {
            bg = '#303030',
            yellow = '#d79921',
            cyan = '#83a598',
            green = '#b8bb26',
            orange = '#d65d0e',
            purple = '#b16286',
            magenta = '#d3869b',
            grey = '#a89984',
            blue = '#076678',
            red = '#cc241d',
        }
    else
        colors = {
            bg = '#2E2E2E',
            yellow = '#D7BA7D',
            cyan = '#4EC9B0',
            green = '#608B4E',
            orange = '#FF8800',
            purple = '#C586C0',
            magenta = '#D16D9E',
            grey = '#858585',
            blue = '#569CD6',
            red = '#D16969',
        }
    end

    gls.left = {
        {
            ViMode = {
                provider = function()
                    -- auto change color according the vim mode
                    local mode_color = {
                        n = colors.blue,
                        i = colors.green,
                        v = colors.purple,
                        [''] = colors.purple,
                        V = colors.purple,
                        c = colors.magenta,
                        no = colors.blue,
                        s = colors.orange,
                        S = colors.orange,
                        [''] = colors.orange,
                        ic = colors.yellow,
                        R = colors.red,
                        Rv = colors.red,
                        cv = colors.blue,
                        ce = colors.blue,
                        r = colors.cyan,
                        rm = colors.cyan,
                        ['r?'] = colors.cyan,
                        ['!'] = colors.blue,
                        t = colors.blue,
                    }
                    vim.api.nvim_command(
                        'hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()]
                    )
                    return '▊ '
                end,
                highlight = { colors.bg, colors.bg, 'bold' },
            },
        },
        {
            GitIcon = {
                provider = function()
                    return ' '
                end,
                condition = condition.check_git_workspace,
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
                highlight = { colors.orange, colors.bg, 'bold' },
            },
        },
        {
            GitBranch = {
                provider = 'GitBranch',
                condition = condition.check_git_workspace,
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
                highlight = { colors.yellow, colors.bg, 'bold' },
            },
        },
        {
            DiffAdd = {
                provider = 'DiffAdd',
                -- condition = condition.hide_in_width,
                icon = '  ',
                highlight = { colors.green, colors.bg },
            },
        },
        {
            DiffModified = {
                provider = 'DiffModified',
                -- condition = condition.hide_in_width,
                icon = ' 柳',
                highlight = { colors.blue, colors.bg },
            },
        },
        {
            DiffRemove = {
                provider = 'DiffRemove',
                -- condition = condition.hide_in_width,
                icon = '  ',
                highlight = { colors.red, colors.bg },
            },
        },
    }

    gls.right = {
        {
            DiagnosticError = {
                provider = 'DiagnosticError',
                icon = '  ',
                highlight = { colors.red, colors.bg },
            },
        },
        {
            DiagnosticWarn = {
                provider = 'DiagnosticWarn',
                icon = '  ',
                highlight = { colors.orange, colors.bg },
            },
        },
        {
            DiagnosticHint = {
                provider = 'DiagnosticHint',
                icon = '  ',
                highlight = { colors.blue, colors.bg },
            },
        },
        {
            DiagnosticInfo = {
                provider = 'DiagnosticInfo',
                icon = '  ',
                highlight = { colors.blue, colors.bg },
            },
        },
        {
            LineInfo = {
                provider = 'LineColumn',
                separator = '  ',
                separator_highlight = { 'NONE', colors.bg },
                highlight = { colors.grey, colors.bg },
            },
        },
        {
            PerCent = {
                provider = 'LinePercent',
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
                highlight = { colors.grey, colors.bg, 'bold' },
            },
        },
    }

    gls.short_line_left = {
        {
            Separator = {
                provider = function()
                    return '▊'
                end,
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
                highlight = { colors.grey, colors.bg, 'bold' },
            },
        },
    }
end
