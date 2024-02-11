QbrCore = exports["qbr-core"]

-- Get all location
QbrCore:CreateCallback("sunny-job-rangerpark:server:getLocations", function(source, cb)
    cb(Config.Locations)
end)

-- Get next location based on the player office (from it"s job)
QbrCore:CreateCallback("sunny-job-rangerpark:server:getNextLocation", function(source, cb)
    local nextLocation = Config.Locations[math.random(#Config.Locations)]
    cb(nextLocation)
end)
