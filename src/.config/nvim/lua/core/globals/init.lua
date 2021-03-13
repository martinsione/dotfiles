
function colorscheme(name)
  pcall(function() vim.cmd('colorscheme '..name) end)
end

require('core.globals.opt')
require('core.globals.bind')
