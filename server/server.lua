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
                name = 'Cadet',
                payment = 10
            },
			['1'] = {
                name = 'Ranger',
                payment = 25
            },
			['2'] = {
                name = 'Ranger-Park',
				isboss = true,
                payment = 30
            },
        }
    })
    -- Register Item
    QbrCore:AddItem("ranger-park-mission-certificate", {
        name = "ranger-park-mission-certificate",
        label = "Certificat",
        description = "Certificat de passage",
        image = "",
        weight = 0.1,
        type = nil,
        unique = false,
        useable = false,
        combinable = false
    })
end)

-- Get all missions
QbrCore:CreateCallback("sunny-job-rangerpark:server:get-missions", function(source, cb)
    cb(Config.Mission.Missions)
end)

-- Get next mission based on the player office (from it"s job)
QbrCore:CreateCallback("sunny-job-rangerpark:server:get-next-mission", function(source, cb)
    -- Assume that the player has a job in Blackwater
    -- Later, it will be based on PlayerData.job
    local playerCity = "blackwater"

    local playerMissions = table.filter(Config.Mission.Missions, function (x) return x.city == playerCity end)
    local nextMission = playerMissions[math.random(#playerMissions)]
    cb(nextMission)
end)

-- Win reward
QbrCore:CreateCallback("sunny-job-rangerpark:server:apply-mission-reward", function(source, cb)
    local src = source
    local Player = QbrCore:GetPlayer(src)
    if Player and Player.PlayerData.job then
        -- Add money in bank
        Player.Functions.AddMoney("bank", Config.Mission.Payment)
        -- Add item to playe inventory
        Player.Functions.AddItem("ranger-park-mission-certificate", 1)
        -- Trigger client event
        TriggerClientEvent("sunny-job-rangerpark:client:mission-completed", Config.Mission.Payment)
    end
    cb(true)
end)