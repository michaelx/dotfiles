local obj = { __gc = true }

setmetatable(obj, obj)

-- Garbage collector
obj.__gc = function(t)
  t:stop()
end

-- Metadata
obj.name = "MX"
obj.version = "0.1"
obj.author = "Michael Xander"
obj.homepage = "https://michaelxander.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Properties
obj.caffeinateStatus = nil
obj.hotkeyToggle = nil
obj.menuBarItem = nil

-- Where to load files from
obj.spoonPath = hs.spoons.scriptPath()

function obj:init() end

local launchbotSets = {
  {
    name = "Daily",
    items = {
      "https://mymorningroutine.com",
      "https://www.nytimes.com",
      "https://www.newyorker.com",
      "https://news.ycombinator.com",
      "https://reddit.com",
      "https://macstories.net",
      "https://brettterpstra.com"
    }
  },
}

function openLaunchbotItems(set)
  local selectedSet = hs.fnutils.find(launchbotSets, function(el) return el.name == set end)
  if selectedSet then
    for _, item in pairs(selectedSet.items) do hs.urlevent.openURL(item) end
  else
    hs.alert("Launchbot: Set not found")
  end
end

function obj:bindHotkeys(mapping)
  local spec = {
    toggle = hs.fnutils.partial(self.clicked, self),
  }
  hs.spoons.bindHotkeysToSpec(spec, mapping)
  return self
end

function getMenuItems()
  return {
    { title = "Caffeinate", fn = function() obj.clicked() end, checked = obj.caffeinateStatus },
    { title = "-" },
    { title = hs.battery.capacity().." mAh, "..hs.battery.cycles(), disabled = true },
    { title = "-" },
    { title = "Launchbot", disabled = true },
    { title = "Daily", fn = function() openLaunchbotItems("Daily") end },
  }
end

function obj:start()
  self.menuBarItem = hs.menubar.new()
  self.menuBarItem:setMenu(function() return getMenuItems() end)
  self.menuBarItem:setClickCallback(self.clicked)
  if self.hotkeyToggle then
    self.hotkeyToggle:enable()
  end
  self.setDisplay(hs.caffeinate.get("displayIdle"))

  return self
end

function obj:stop()
  self.menuBarItem:delete()
  if self.hotkeyToggle then
    self.hotkeyToggle:disable()
  end
  self.menuBarItem = nil

  return self
end

function obj.setDisplay(state)
  local icon = "/logo-"..(state and 1 or 0)..".pdf"
  obj.menuBarItem:setIcon(obj.spoonPath..icon)
  obj.caffeinateStatus = state
end

function obj.clicked()
  obj.setDisplay(hs.caffeinate.toggle("displayIdle"))
end

return obj
