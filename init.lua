local function restartNanoleaf()
    os.execute("pkill -x 'Nanoleaf Desktop'")
    hs.timer.doAfter(1, function()
        hs.application.open("Nanoleaf Desktop")
    end)
end

-- Catches lid open/close and system sleep/wake
hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.systemDidWake or
       event == hs.caffeinate.watcher.screensDidWake or
       event == hs.caffeinate.watcher.sessionDidBecomeActive then
        hs.timer.doAfter(3, restartNanoleaf)
    end
end):start()
