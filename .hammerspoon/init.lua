-- Default options
hs.window.animationDuration = 0.1

-- Define some keyboard modifier variables
hyper = {'ctrl', 'alt', 'cmd'}

-- Watchers
screenWatcher = nil
caffeinateWatcher = nil
appWatcher = nil

-- Caffeine
hs.loadSpoon('Caffeine')
spoon.Caffeine:bindHotkeys({toggle={hyper, 'c'}})
spoon.Caffeine:start()

-- Define monitor names for layout purposes
display_mbp = 'Color LCD'
display_monitor = 'PL2492H'

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

-- Define window layouts
--   Format reminder:
--     {'App name', 'Window name', 'Display Name', 'unitrect', 'framerect', 'fullframerect'},
internal_display = {
    {'1Password',               nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Calendar',                nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Finder',                  nil,          display_mbp, hs.geometry.unitrect(2/10, 2/10, 6/10, 6/10), nil, nil},
    {'ForkLift',                nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'iTerm2',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'iTunes',                  'iTunes',     display_mbp, hs.layout.maximized, nil, nil},
    {'MacDown',                 nil,          display_mbp, hs.geometry.unitrect(1/10, 1/10, 8/10, 8/10), nil, nil},
    {'Mail',                    nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Messages',                nil,          display_mbp, hs.geometry.unitrect(2/10, 1/10, 6/10, 8/10), nil, nil},
    {'Notational Velocity',     nil,          display_mbp, hs.geometry.unitrect(1/10, 1/10, 8/10, 8/10), nil, nil},
    {'ReadKit',                 nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Safari',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Sketch',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'SourceTree',              nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Spotify',                 nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Sublime Text',            nil,          display_mbp, hs.layout.maximized, nil, nil},
}

dual_display = {
    {'1Password',               nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Calendar',                nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Finder',                  nil,          display_mbp, hs.geometry.unitrect(2/10, 2/10, 6/10, 6/10), nil, nil},
    {'ForkLift',                nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'iTerm2',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'iTunes',                  'iTunes',     display_monitor, hs.layout.maximized, nil, nil},
    {'MacDown',                 nil,          display_mbp, hs.geometry.unitrect(1/10, 1/10, 8/10, 8/10), nil, nil},
    {'Mail',                    nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Messages',                nil,          display_monitor, hs.geometry.unitrect(2/10, 1/10, 6/10, 8/10), nil, nil},
    {'Notational Velocity',     nil,          display_mbp, hs.geometry.unitrect(1/10, 1/10, 8/10, 8/10), nil, nil},
    {'ReadKit',                 nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Safari',                  nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Sketch',                  nil,          display_monitor, hs.layout.maximized, nil, nil},
    {'SourceTree',              nil,          display_mbp, hs.layout.maximized, nil, nil},
    {'Spotify',                 nil,          display_monitor, hs.layout.maximized, nil, nil},
    {'Sublime Text',            nil,          display_monitor, hs.layout.maximized, nil, nil},
}

-- Helper functions

-- Toggle an application between being the frontmost app, and being hidden
function toggle_application(_app)
    local app = hs.appfinder.appFromName(_app)
    if not app then
        -- FIXME: This should really launch _app
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

-- And now for hotkeys relating to Hyper.
-- First, let's capture all of the functions, then we can just quickly iterate and bind them
hyperfns = {}

-- Hotkeys to resize windows absolutely
hyperfns['t'] = toggle_window_maximized
hyperfns['f'] = function() hs.window.focusedWindow():maximize() end
hyperfns['r'] = function() hs.window.focusedWindow():toggleFullScreen() end
hyperfns['['] = function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end
hyperfns[']'] = function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end
hyperfns['o'] = function() hs.window.focusedWindow():moveToUnit(hs.layout.left30) end
hyperfns['p'] = function() hs.window.focusedWindow():moveToUnit(hs.layout.right30) end

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
hyperfns['i'] = function() toggle_application('iTerm2') end
hyperfns['s'] = function() toggle_application('Safari') end

-- Hotkey to display window hints
hyperfns['a'] = hs.hints.windowHints

-- Hotkey to reload config
hyperfns['q'] = function() hs.reload() end
hs.alert.show('Config loaded')

--- Bind all hotkeys
for _hotkey, _fn in pairs(hyperfns) do
    hs.hotkey.bind(hyper, _hotkey, _fn)
end

-- Create and start our callbacks
appWatcher = hs.application.watcher.new(applicationWatcher):start()

screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()

caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
caffeinateWatcher:start()