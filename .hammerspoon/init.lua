-- Default options
hs.window.animationDuration = 0.05

-- Keyboard modifiers
hyper = {'ctrl', 'alt', 'cmd'}

-- Watchers
screenWatcher = nil
caffeinateWatcher = nil
appWatcher = nil
mxWatcher = nil

-- Spoon: MX
hs.loadSpoon('MX')
spoon.MX:bindHotkeys({toggle={hyper, 'c'}})
spoon.MX:start()

-- Available monitors
display_mbp = 'Color LCD'
display_external_1 = 'PL2492H'

-- Defines for screen watcher
lastNumberOfScreens = #hs.screen.allScreens()

-- Defines for caffeinate watcher
shouldUnmuteOnScreenWake = nil

-- Defines for window grid
hs.grid.GRIDWIDTH = 4
hs.grid.GRIDHEIGHT = 4
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

-- Defines for window maximize toggler
frameCache = {}

-- Window layouts
--   {'App name', 'Window name', 'Display Name', 'unitrect', 'framerect', 'fullframerect'},
internal_display = {
  {'Bitwarden',               nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Calendar',                nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Chrome',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Code',                    nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'DevDocs',                 nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Figma',                   nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Finder',                  nil,          display_mbp, hs.geometry.unitrect(2/10, 2/10, 6/10, 6/10), nil, nil},
  {'ForkLift',                nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'iTerm2',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'iTunes',                  'iTunes',     display_mbp, hs.layout.maximized, nil, nil},
  {'MacDown',                 nil,          display_mbp, hs.geometry.unitrect(1/10, 1/10, 8/10, 8/10), nil, nil},
  {'Mail',                    nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Messages',                nil,          display_mbp, hs.geometry.unitrect(2/10, 1/10, 6/10, 8/10), nil, nil},
  {'Reeder',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Safari',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Sketch',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Sourcetree',              nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Sublime Text',            nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'TIDAL',                   nil,          display_mbp, hs.layout.maximized, nil, nil},
}

dual_display = {
  {'Bitwarden',               nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Calendar',                nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Chrome',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Code',                    nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'DevDocs',                 nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Figma',                   nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Finder',                  nil,          display_mbp, hs.geometry.unitrect(2/10, 2/10, 6/10, 6/10), nil, nil},
  {'ForkLift',                nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'iTerm2',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'iTunes',                  'iTunes',     display_external_1, hs.layout.maximized, nil, nil},
  {'MacDown',                 nil,          display_mbp, hs.geometry.unitrect(1/10, 1/10, 8/10, 8/10), nil, nil},
  {'Mail',                    nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Messages',                nil,          display_external_1, hs.geometry.unitrect(2/10, 1/10, 6/10, 8/10), nil, nil},
  {'Reeder',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Safari',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Sketch',                  nil,          display_external_1, hs.layout.maximized, nil, nil},
  {'Sourcetree',              nil,          display_mbp, hs.layout.maximized, nil, nil},
  {'Sublime Text',            nil,          display_external_1, hs.layout.maximized, nil, nil},
  {'TIDAL',                   nil,          display_mbp, hs.layout.maximized, nil, nil},
}

-- Toggle an application between being the frontmost app, and being hidden
function toggle_application(_app)
  local app = hs.appfinder.appFromName(_app)
  if not app then
    hs.application.launchOrFocus(_app)
    return
  end

  local mainwin = app:mainWindow()
  if mainwin then
    if mainwin == hs.window.focusedWindow() then
      mainwin:application():hide()
    else
      mainwin:application():activate(true)
      mainwin:application():unhide()
      mainwin:focus()
    end
  end
end

-- Toggle a window between its normal size, and being maximized
function toggle_window_maximized()
  local win = hs.window.focusedWindow()
  if frameCache[win:id()] then
    win:setFrame(frameCache[win:id()])
    frameCache[win:id()] = nil
  else
    frameCache[win:id()] = win:frame()
    win:maximize()
  end
end

-- Connect/disconnect bluetooth keyboard and mouse
--   Uses https://formulae.brew.sh/formula/bluetoothconnector
--   Replace device MAC addresses
function toggle_input_devices()
  hs.execute("BluetoothConnector 00-00-00-00-00-00", true)
  hs.execute("BluetoothConnector 00-00-00-00-00-00", true)
end

-- Callback function for application events
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    if (appName == 'Finder') then
      -- Bring all Finder windows forward when one gets activated
      appObject:selectMenuItem({'Window', 'Bring All to Front'})
    end
  end
end

-- Callback function for changes in screen layout
function screensChangedCallback()
  print('screensChangedCallback')
  newNumberOfScreens = #hs.screen.allScreens()

  -- FIXME: This is awful if we swap primary screen to the external display. all the windows swap around, pointlessly.
  if lastNumberOfScreens ~= newNumberOfScreens then
    if newNumberOfScreens == 1 then
      hs.layout.apply(internal_display)
    elseif newNumberOfScreens == 2 then
      hs.layout.apply(dual_display)
    end
  end

  lastNumberOfScreens = newNumberOfScreens
end

-- Callback function for caffeinate events
function caffeinateCallback(eventType)
  if (eventType == hs.caffeinate.watcher.screensDidSleep) then
    print('screensDidSleep')
    if hs.itunes.isPlaying() then
      hs.itunes.pause()
    end
    local output = hs.audiodevice.defaultOutputDevice()
    shouldUnmuteOnScreenWake = not output:muted()
    output:setMuted(true)

  elseif (eventType == hs.caffeinate.watcher.screensDidWake) then
    print('screensDidWake')
    if shouldUnmuteOnScreenWake then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    end
  end
end

-- Hotkeys relating to hyper key
hyperfns = {}

-- Hotkeys to resize windows absolutely
hyperfns['t'] = toggle_window_maximized
hyperfns['f'] = function() hs.window.focusedWindow():maximize() end
hyperfns['r'] = function() hs.window.focusedWindow():toggleFullScreen() end
hyperfns['h'] = function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end
hyperfns['j'] = function() hs.layout.apply({{nil, hs.window.focusedWindow(), hs.screen.mainScreen(), hs.geometry.unitrect(0, 0.5, 1, 0.5), nil, nil}}) end
hyperfns['k'] = function() hs.layout.apply({{nil, hs.window.focusedWindow(), hs.screen.mainScreen(), hs.geometry.unitrect(0, 0, 1, 0.5), nil, nil}}) end
hyperfns['l'] = function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end

-- Hotkeys to trigger defined layouts
hyperfns['1'] = function() hs.layout.apply(internal_display) end
hyperfns['2'] = function() hs.layout.apply(dual_display) end

-- Hotkeys to interact with the window grid
hyperfns['g'] = hs.grid.show
hyperfns['Left'] = hs.grid.pushWindowLeft
hyperfns['Right'] = hs.grid.pushWindowRight
hyperfns['Up'] = hs.grid.pushWindowUp
hyperfns['Down'] = hs.grid.pushWindowDown

-- Application hotkeys
hyperfns['`'] = function() toggle_application('iTerm2') end
hyperfns['s'] = function() toggle_application('Safari') end

-- Hotkey to display window hints
hyperfns['a'] = hs.hints.windowHints

-- Hotkey to reload config
hyperfns['q'] = function() hs.reload() end
hs.alert.show('Config loaded')

-- Hotkey to connect/disconnect bluetooth input devices
hyperfns['b'] = function() toggle_input_devices() end

--- Bind all hotkeys
for _hotkey, _fn in pairs(hyperfns) do
  hs.hotkey.bind(hyper, _hotkey, _fn)
end

-- Create and start callbacks
appWatcher = hs.application.watcher.new(applicationWatcher):start()

-- Note: I rarely use my dual screen setup these days, so auto-switching is off
--       right now. Use the hotkeys to load the dual/primary screen layouts.
--screenWatcher = hs.screen.watcher.new(screensChangedCallback)
--screenWatcher:start()

caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
caffeinateWatcher:start()
