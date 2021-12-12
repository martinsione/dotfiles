local awesome = _G.awesome
local client = _G.client
local gears = require('gears')
local awful = require('awful')

-- Custom
local M = {}
local modkey = require('modules.config').modkey
local programs = require('modules.config').programs

M.taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

M.tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal('request::activate', 'tasklist', { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

M.mouse = gears.table.join(
  awful.button({}, 3, function()
    mymainmenu:toggle()
  end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
)

M.globalkeys = gears.table.join(
  awful.key({}, 'Print', function()
    awful.spawn('flameshot gui')
  end),
  awful.key({ 'Shift' }, 'Print', function()
    awful.spawn('maim -i $(xdotool getactivewindow) $HOME/Pictures/Screenshot-$(date "+%Y-%m-%d-%H%M%S").png')
  end),
  awful.key({ modkey, 'Control' }, 'r', awesome.restart), -- Reload awesome
  awful.key({ modkey, 'Shift' }, 'q', awesome.quit), -- Quit awesome
  awful.key({ modkey }, 'Left', awful.tag.viewprev), -- view previous (tag)
  awful.key({ modkey }, 'Right', awful.tag.viewnext), -- view next (tag)
  awful.key({ modkey }, 'Escape', awful.tag.history.restore), -- go back (tag)
  -- Movement
  awful.key({ modkey }, 'j', function()
    awful.client.focus.byidx(1) -- focus next by index (client)
  end),
  awful.key({ modkey }, 'k', function()
    awful.client.focus.byidx(-1) -- focus previous by index (client)
  end),
  awful.key({ modkey, 'Shift' }, 'j', function()
    awful.client.swap.byidx(1) -- swap with next client by index (client)
  end),
  awful.key({ modkey, 'Shift' }, 'k', function()
    awful.client.swap.byidx(-1) -- swap with previous client by index (client)
  end),
  awful.key({ modkey, 'Control' }, 'l', function()
    awful.tag.incmwfact(0.05) -- increase master width factor (layout)
  end),
  awful.key({ modkey, 'Control' }, 'h', function()
    awful.tag.incmwfact(-0.05) -- decrease master width factor (layout)
  end),
  -- Standard program
  awful.key({ modkey }, 'Return', function()
    awful.spawn(programs.terminal) -- Open a terminal
  end),
  awful.key({ modkey }, 'p', function()
    awful.spawn(programs.rofi) -- Run rofi
  end),
  awful.key({ modkey }, 'w', function()
    awful.spawn(programs.browser) -- Open a browser
  end),
  awful.key({ modkey }, 'e', function()
    awful.spawn(programs.file) -- Open a file manager
  end)
)

M.clientkeys = gears.table.join(
  awful.key({ modkey }, 'q', function(c)
    c:kill() -- Kill window
  end),
  awful.key({ modkey }, 'f', function(c)
    c.fullscreen = not c.fullscreen -- Toggle fullscreen
    c:raise()
  end),
  awful.key({ modkey, 'Shift' }, 'space', awful.client.floating.toggle), -- Toggle floating mode
  awful.key({ modkey, 'Control' }, 'space', function(c)
    c:swap(awful.client.getmaster()) -- Move to master
  end),
  awful.key({ modkey }, 'n', function(c)
    c.minimized = true -- Minimize (client)
  end),
  awful.key({ modkey }, 'm', function(c)
    c.maximized = not c.maximized -- Maximize (client)
    c:raise()
  end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  M.globalkeys = gears.table.join(
    M.globalkeys,
    -- View tag only.
    awful.key({ modkey }, '#' .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end),
    -- Toggle tag display.
    awful.key({ modkey, 'Shift' }, '#' .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end),
    -- Move client to tag.
    awful.key({ modkey, 'Control' }, '#' .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end),
    -- Toggle tag on focused client.
    awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end)
  )
end

M.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.resize(c)
  end)
)

return M
