local M = {}

M = {
  modkey = 'Mod1',
}

M.programs = {
  browser = 'brave',
  editor_cmd = 'kitty -e nvim',
  file = 'nautilus',
  rofi = 'rofi -combi-modi window,drun -show combi -modi combi',
  terminal = 'kitty',
}

M.autostart = {
  'xset r rate 300 50',
  'setxkbmap -option ctrl:nocaps',
  'xcompmgr',
  'unclutter',
  'nitrogen --restore',
}

return M
