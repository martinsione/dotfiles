local autopairs = require('nvim-autopairs')

-- Tab completion confirm
if pcall(function()
  vim.cmd [[packadd nvim-autopairs]]
end) then
  vim.g.completion_confirm_key = ''
  function utils.completion_confirm()
    if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info()['selected'] ~= -1 then
        vim.fn['compe#confirm']()
        return autopairs.esc('<c-y>')
      else
        vim.defer_fn(function()
          vim.fn['compe#confirm']('<cr>')
        end, 20)
        return autopairs.esc('<c-n>')
      end
    else
      return autopairs.check_break_line_char()
    end
  end
end

autopairs.setup({})
