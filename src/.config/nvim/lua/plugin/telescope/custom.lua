RELOAD = require('plenary.reload').reload_module
local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD('plenary')
    RELOAD('popup')
    RELOAD('telescope')
  end
end

reloader()

local M = {}

function M.edit_dotfiles()
  require('telescope.builtin').find_files {
    prompt_title = " Dotfiles ",
    file_ignore_patterns = { 'git/*' },
    find_command = {
      'rg',
      '--files',
      '--hidden'
    },
    cwd = "~/dotfiles",
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
