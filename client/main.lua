
RegisterCommand('blips', function ()
    exports['qbr-core']:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        --print(blips)
        print(Dump(blips))

        for k,v in pairs(blips) do
            print(k, v["city"])
        end
    end)
end, false)

function Dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. Dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

