require('modules')
require('core.options')
require('core.keymaps')
require('core.autocmd')
require('core.colors')

if vim.api.nvim_buf_get_name(0):len() == 0 then
    vim.cmd('silent! Dashboard')
end
