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
    -- Register Item
    QbrCore:AddItem("ranger-park-reward-voucher", {})
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
        Player.Functions.AddMoney("bank", Player.PlayerData.job.payment)
        -- Add item to playe inventory
        Player.Functions.AddItem("ranger-park-reward-voucher", 1)
    end
    cb(true)
end)