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
  screenshot = 'maim -i $(xdotool getactivewindow) ${XDG_PICTURES_HOME}/Screenshot-$(date "+%Y-%m-%d-%H%M%S").png',
  screenshot_full = 'maim ${XDG_PICTURES_HOME}/Screenshot-$(date "+%Y-%m-%d-%H%M%S").png',
}

M.autostart = {
  'xset r rate 300 50',
  'setxkbmap -option ctrl:nocaps',
  'xcompmgr',
  'unclutter',
  'lxsession',
  'redshift-gtk -l -34.603683:-58.381557',
  'nitrogen --restore',
}

return M
