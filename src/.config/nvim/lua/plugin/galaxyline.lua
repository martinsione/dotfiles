local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local gls = gl.section
gl.short_line_list = {'NvimTree', 'vista', 'dbui'}

local colors = {
  bg = '#413654',
  fg = '#cccccc',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[1] = {
  RainbowRed = {
    provider = function()
      return '▊  '
    end,
    highlight = {colors.blue, colors.bg}
  }
}

gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.magenta,
        i = colors.green,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.red,
        no = colors.magenta,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red
      }
      vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
      return '  '
    end,
    highlight = {colors.red, colors.bg, 'bold'}
  }
}

gls.left[5] = {
  GitIcon = {
    provider = function()
      return '   '
    end,
    -- provider = function() return '   ' end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.orange, colors.bg, 'bold'}
  }
}

gls.left[6] = {
  GitBranch = {
    provider = 'GitBranch',
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.orange, colors.bg, 'bold'}
  }
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[7] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    separator = '',
    separator_highlight = {colors.purple, colors.bg},
    -- icon = ' ',
    icon = ' ',
    highlight = {colors.green, colors.bg}
  }
}
gls.left[8] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    separator = '',
    -- icon = ' ',
    icon = ' ',
    highlight = {colors.yellow, colors.bg}
  }
}
gls.left[9] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    separator = '',
    -- icon = ' ',
    icon = ' ',
    highlight = {colors.red, colors.bg}
  }
}
gls.left[10] = {
  LeftEnd = {
    provider = function()
      return ' '
    end,
    separator = '',
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.purple, colors.bg}
  }
}
gls.left[11] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red, colors.bg}
  }
}
gls.left[11] = {
  Space = {
    provider = function()
      return ''
    end
  }
}
gls.left[12] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow, colors.bg}
  }
}
gls.left[13] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '   ',
    highlight = {colors.blue, colors.bg}
  }
}
gls.left[14] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '   ',
    highlight = {colors.orange, colors.bg}
  }
}

gls.right[3] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.darkblue, colors.bg},
    highlight = {colors.grey, colors.bg}
  }
}
gls.right[4] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' |',
    separator_highlight = {colors.darkblue, colors.bg},
    highlight = {colors.grey, colors.bg}
  }
}

gls.right[8] = {
  RainbowBlue = {
    provider = function()
      return '  ▊'
    end,
    highlight = {colors.blue, colors.bg}
  }
}

gls.short_line_left[1] = {
  LeftEnd = {
    provider = function()
      return ' '
    end,
    separator = ' ',
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.purple, colors.bg}
  }
}
