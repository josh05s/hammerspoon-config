-- Keepalive timer to prevent Hammerspoon going idle
hs.timer.doEvery(60, function() end)

local function restartNanoleaf()
    os.execute("pkill -x 'Nanoleaf Desktop'")
    hs.timer.doAfter(1, function()
        hs.application.open("Nanoleaf Desktop")
    end)
end

hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.systemDidWake or
       event == hs.caffeinate.watcher.screensDidWake or
       event == hs.caffeinate.watcher.sessionDidBecomeActive then
        hs.timer.doAfter(3, restartNanoleaf)
    end
end):start()

hs.application.watcher.new(function(name, event, app)
    if name == "Nanoleaf Desktop" then
        hs.timer.doAfter(0.2, function()
            local a = hs.application.find("Nanoleaf Desktop")
            if a then
                a:hide()
            end
        end)
    end
end):start()
