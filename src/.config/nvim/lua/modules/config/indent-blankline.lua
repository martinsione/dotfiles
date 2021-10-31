return function()
  local indent_blankline = safe_require 'indent_blankline'
  if not indent_blankline then
    return
  end

  indent_blankline.setup {
    buftype_exclude = { 'terminal' },
    char = '▏',
    filetype_exclude = { 'help', 'NvimTree', 'dashboard', 'packer', 'TelescopePrompt' },
    show_current_context = true,
    space_char_blankline = ' ',
    use_treesitter = true,
  }
  vim.g.indent_blankline_context_patterns = {
    'class',
    'return',
    'function',
    'method',
    '^if',
    '^while',
    'jsx_element',
    '^for',
    '^object',
    '^table',
    'block',
    'arguments',
    'if_statement',
    'else_clause',
    'jsx_element',
    'jsx_self_closing_element',
    'try_statement',
    'catch_clause',
    'import_statement',
    'operation_type',
  }
end
