local npairs = require('nvim-autopairs')

vim.g.completion_confirm_key = ''
function utils.completion_confirm()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()['selected'] ~= -1 then
      return vim.fn['compe#confirm'](npairs.esc('<cr>'))
    else
      return npairs.esc('<CR>')
    end
  else
    return npairs.autopairs_cr()
  end
end

npairs.setup({})
