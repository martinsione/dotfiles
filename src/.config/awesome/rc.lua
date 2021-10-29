-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')
local awesome = _G.awesome
local client = _G.client
local root = _G.root
-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
-- Widget and layout library
local wibox = require('wibox')
-- Theme handling library
local beautiful = require('beautiful')
-- Notification library
local naughty = require('naughty')

-- Custom
local keymaps = require('modules.keymaps')

-- Error handling
if awesome.startup_errors then
  local msg = 'Oops, there were errors during startup!'
  naughty.notify({ preset = naughty.config.presets.critical, title = msg, text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal('debug::error', function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true
    local msg = 'Oops, an error happened!'
    naughty.notify({ preset = naughty.config.presets.critical, title = msg, text = tostring(err) })
    in_error = false
  end)
end

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  -- awful.layout.suit.floating,
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')
local mytextclock = wibox.widget.textclock()
awful.screen.connect_for_each_screen(function(s)
  awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = keymaps.taglist_buttons,
  })

  -- -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = keymaps.tasklist_buttons,
  })

  -- -- Create the wibox
  s.mywibox = awful.wibar({ position = 'top', screen = s })

  -- -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      mytextclock,
      s.mylayoutbox,
    },
  })
end)

-- Keymaps
root.buttons(keymaps.mouse)
root.keys(keymaps.globalkeys)

-- Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keymaps.clientkeys,
      buttons = keymaps.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- Add titlebars to normal clients and dialogs
  -- { rule_any = {type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },
  { rule = { class = 'browser' }, properties = { screen = 1, tag = '2' } },
}
-- }}}

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
  -- Set the windows at the slave,
  if not awesome.startup then
    awful.client.setslave(c)
  end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
  c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

client.connect_signal('focus', function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}

-- Autostart programs
local function run_once(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    require('awful').spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
  end
end

local autostart_programs = require('modules.config').autostart
run_once(autostart_programs)
