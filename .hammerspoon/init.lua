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
display_external_1 = 'DELL U2718Q'

-- Defines for screen watcher
lastNumberOfScreens = #hs.screen.allScreens()

-- Defines for caffeinate watcher
shouldUnmuteOnScreenWake = nil

-- Defines for window grid
hs.grid.GRIDHEIGHT = 4
hs.grid.GRIDWIDTH = 4
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

-- Window positions
positions = {
  full = hs.layout.maximized,
  fullHeightLarge = hs.geometry.rect(2/16, 0, 12/16, 1),

  top50 = hs.geometry.rect(0, 0, 1, 1/2),
  top50Left50 = hs.geometry.rect(0, 0, 1/2, 1/2),
  top50Right50 = hs.geometry.rect(1/2, 0, 1/2, 1/2),

  bottom50 = hs.geometry.rect(0, 1/2, 1, 1/2),
  bottom50Left50 = hs.geometry.rect(0, 1/2, 1/2, 1/2),
  bottom50Right50 = hs.geometry.rect(1/2, 1/2, 1/1, 1/2),

  centeredXsmall = hs.geometry.rect(2/10, 1/10, 6/10, 8/10),
  centeredSmall = hs.geometry.rect(1/10, 1/10, 8/10, 8/10),
  centeredMedium = hs.geometry.rect(3/16, 1/16, 10/16, 14/16),
  centeredLarge = hs.geometry.rect(2/16, 1/16, 12/16, 14/16),

  appFinderSmall = hs.geometry.rect(2/10, 2/10, 6/10, 6/10),
  appFinderLarge = hs.geometry.rect(7/24, 6/24, 10/24, 12/24),
  appMessagesLarge = hs.geometry.rect(0, 0, 7/16, 12/16),
}

-- Defines for window maximize toggler
frameCache = {}

-- Window layouts
--   {'App name', 'Window name', 'Display Name', 'rect', 'framerect', 'fullframerect'},
internal_display = {
  {'Bitwarden',               nil,          display_mbp, positions.full, nil, nil},
  {'Calendar',                nil,          display_mbp, positions.full, nil, nil},
  {'Code',                    nil,          display_mbp, positions.full, nil, nil},
  {'DevDocs',                 nil,          display_mbp, positions.full, nil, nil},
  {'Figma',                   nil,          display_mbp, positions.full, nil, nil},
  {'Finder',                  nil,          display_mbp, positions.appFinderSmall, nil, nil},
  {'Fork',                    nil,          display_mbp, positions.full, nil, nil},
  {'ForkLift',                nil,          display_mbp, positions.full, nil, nil},
  {'Google Chrome',           nil,          display_mbp, positions.full, nil, nil},
  {'iTerm2',                  nil,          display_mbp, positions.full, nil, nil},
  {'iTunes',                  'iTunes',     display_mbp, positions.full, nil, nil},
  {'MacDown',                 nil,          display_mbp, positions.centeredSmall, nil, nil},
  {'Mail',                    nil,          display_mbp, positions.full, nil, nil},
  {'Messages',                nil,          display_mbp, positions.centeredXsmall, nil, nil},
  {'Obsidian',                nil,          display_mbp, positions.full, nil, nil},
  {'Paw',                     nil,          display_mbp, positions.full, nil, nil},
  {'Reeder',                  nil,          display_mbp, positions.full, nil, nil},
  {'Safari',                  nil,          display_mbp, positions.full, nil, nil},
  {'Sketch',                  nil,          display_mbp, positions.full, nil, nil},
  {'Sublime Text',            nil,          display_mbp, positions.full, nil, nil},
  {'TIDAL',                   nil,          display_mbp, positions.full, nil, nil},
}

dual_display = {
  {'Bitwarden',               nil,          display_external_1, positions.centeredMedium, nil, nil},
  {'Calendar',                nil,          display_external_1, positions.centeredMedium, nil, nil},
  {'Code',                    nil,          display_external_1, positions.full, nil, nil},
  {'DevDocs',                 nil,          display_external_1, positions.centeredLarge, nil, nil},
  {'Figma',                   nil,          display_external_1, positions.full, nil, nil},
  {'Finder',                  nil,          display_external_1, positions.appFinderLarge, nil, nil},
  {'Fork',                    nil,          display_external_1, positions.centeredLarge, nil, nil},
  {'ForkLift',                nil,          display_external_1, positions.centeredMedium, nil, nil},
  {'Google Chrome',           nil,          display_external_1, positions.full, nil, nil},
  {'iTerm2',                  nil,          display_external_1, positions.full, nil, nil},
  {'iTunes',                  'iTunes',     display_external_1, positions.full, nil, nil},
  {'MacDown',                 nil,          display_external_1, positions.centeredMedium, nil, nil},
  {'Mail',                    nil,          display_external_1, positions.centeredLarge, nil, nil},
  {'Messages',                nil,          display_external_1, positions.appMessagesLarge, nil, nil},
  {'Obsidian',                nil,          display_external_1, positions.fullHeightLarge, nil, nil},
  {'Paw',                     nil,          display_external_1, positions.centeredLarge, nil, nil},
  {'Reeder',                  nil,          display_external_1, positions.full, nil, nil},
  {'Safari',                  nil,          display_external_1, positions.full, nil, nil},
  {'Sketch',                  nil,          display_external_1, positions.full, nil, nil},
  {'Sublime Text',            nil,          display_external_1, positions.fullHeightLarge, nil, nil},
  {'TIDAL',                   nil,          display_external_1, positions.centeredMedium, nil, nil},

  -- Work apps (only on work machine)
  -- {'Insomnia',                nil,          display_external_1, positions.centeredMedium, nil, nil},
  -- {'Microsoft Outlook',       nil,          display_external_1, positions.centeredLarge, nil, nil},
  -- {'Microsoft Teams',         nil,          display_external_1, positions.centeredMedium, nil, nil},
}

code_layout = {
  {'Code',                    nil,          nil, hs.layout.right70, nil, nil},
  {'Google Chrome',           nil,          nil, hs.layout.left30, nil, nil},
  {'Safari',                  nil,          nil, hs.layout.left30, nil, nil},
  {'Sublime Text',            nil,          nil, hs.layout.right70, nil, nil},
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

-- Hotkeys to resize (and move) windows absolutely
hyperfns['t'] = toggle_window_maximized
hyperfns['f'] = function() hs.window.focusedWindow():maximize() end
hyperfns['r'] = function() hs.window.focusedWindow():toggleFullScreen() end
hyperfns['h'] = function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end
hyperfns['j'] = function() hs.window.focusedWindow():moveToUnit(positions.bottom50) end
hyperfns['k'] = function() hs.window.focusedWindow():moveToUnit(positions.top50) end
hyperfns['l'] = function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end
hyperfns[';'] = function() hs.window.focusedWindow():moveToUnit(positions.centeredLarge) end
hyperfns['\''] = function() hs.window.focusedWindow():centerOnScreen() end

-- Hotkeys to trigger defined layouts
hyperfns['1'] = function() hs.layout.apply(internal_display) end
hyperfns['2'] = function() hs.layout.apply(dual_display) end
hyperfns['3'] = function() hs.layout.apply(code_layout) end

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

-- Apply layout based on available screens
screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()

caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
caffeinateWatcher:start()
