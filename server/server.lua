QbrCore = exports["qbr-core"]

-- Main
CreateThread(function()
    -- Register the job
    QbrCore:AddJob("ranger-park", {
        label = 'Ranger Park',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recrue',
                payment = 5
            },
			['1'] = {
                name = 'Sergent',
                payment = 10
            },
			['2'] = {
                name = 'Lieutenant',
				isboss = true,
                payment = 20
            },
        }
    })
end)

-- Get all location
QbrCore:CreateCallback("sunny-job-rangerpark:server:getLocations", function(source, cb)
    cb(Config.Locations)
end)

-- Get next location based on the player office (from it"s job)
QbrCore:CreateCallback("sunny-job-rangerpark:server:getNextLocation", function(source, cb)
    local nextLocation = Config.Locations[math.random(#Config.Locations)]
    cb(nextLocation)
end)
