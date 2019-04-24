# KUANA_GARAGE
Hi, so im 17 old (a kid who do scripts like that).
I made this plugin for a wile and this is the last release i made.
If this get a good feedback, maybe i will do more scripts.

Video: https://youtu.be/sv0Bt76SmVU - Sorry for my bad english, im portuguese.

Vehicle Shop/ 
Server:
      RegisterServerEvent('esx_vehicleshop:setVehicleOwned')
      AddEventHandler('esx_vehicleshop:setVehicleOwned', function (vehicleProps)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, x, y, z, h, health) VALUES (@owner, @plate, @vehicle, @xx, @yy, @zz, @hh, @vida)',
        {
          ['@owner']   = xPlayer.identifier,
          ['@plate']   = vehicleProps.plate,
          ['@vehicle'] = json.encode(vehicleProps),
          ["@xx"] = -245.86,
          ["@yy"] = 6257.2,
          ["@zz"] = 31.09,
          ["@hh"] = 223.97,
          ["@vida"] = 1000
        }, function (rowsChanged)
          TriggerClientEvent('esx:showNotification', _source, _U('vehicle_belongs', vehicleProps.plate))
        end)
      end)

      RegisterServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId')
      AddEventHandler('esx_vehicleshop:setVehicleOwnedPlayerId', function (playerId, vehicleProps)
        local xPlayer = ESX.GetPlayerFromId(playerId)

        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, x, y, z, h, health) VALUES (@owner, @plate, @vehicle, @xx, @yy, @zz, @hh, @vida)',
        {
          ['@owner']   = xPlayer.identifier,
          ['@plate']   = vehicleProps.plate,
          ['@vehicle'] = json.encode(vehicleProps),
          ["@xx"] = -245.86,
          ["@yy"] = 6257.2,
          ["@zz"] = 31.09,
          ["@hh"] = 223.97,
          ["@vida"] = 1000
        }, function (rowsChanged)
          TriggerClientEvent('esx:showNotification', playerId, _U('vehicle_belongs', vehicleProps.plate))
        end) 
      end)
      
Mechanic/
Client: 
    {label = "Nitro Canister - 20000$",      value = 'giveboost'},


    if data.current.value == 'giveboost' then
          local playerPed = PlayerPedId()
          local vehicle   = ESX.Game.GetVehicleInDirection()
          local coords    = GetEntityCoords(playerPed)
          local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

          if IsPedSittingInAnyVehicle(playerPed) then
            ESX.ShowNotification(_U('inside_vehicle'))
            return
          end

          if DoesEntityExist(vehicle) then
            isBusy = true
            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
            Citizen.CreateThread(function()
              Citizen.Wait(20000)

              ESX.TriggerServerCallback('esx_mechanicjob:checkdbnitro', function(check)
                if check == true then
                  ESX.ShowNotification("Nitro Canister ~g~placed~w~")
                elseif check == false then
                  ESX.ShowNotification("Nitro Canister was ~y~already~w~ placed or you ~r~dont~w~ have enough money.")
                end
              end, vehicleProps.plate)
              SetVehicleEngineOn(vehicle, true, true)
              ClearPedTasksImmediately(playerPed)
              isBusy = false
            end)
          else
            ESX.ShowNotification(_U('no_vehicle_nearby'))
          end

    else
    
Server:
    ESX.RegisterServerCallback('esx_mechanicjob:checkdbnitro', function(source, cb, plate)
        local xPlayer = ESX.GetPlayerFromId(source)
        local result = MySQL.Sync.fetchAll("SELECT nitro FROM owned_vehicles WHERE plate = @plate", {
          ['@plate'] = plate
          })
          local check          = result[1]
          local resultado	   = check['nitro']
          if xPlayer.getMoney() >= 20000 then
          if resultado == "sim" then
            cb(false)
          elseif resultado == "nao" then
            MySQL.Sync.execute("UPDATE owned_vehicles SET nitro =@comprado WHERE plate=@plate",{['@comprado'] = "sim" , ['@plate'] = plate})
            xPlayer.removeMoney(20000)
            cb(true)
          end
          else
          cb(false)
          end
      end)


      ESX.RegisterServerCallback('esx_mechanicjob:usedbnitro', function(source, cb, plate)
        local xPlayer = ESX.GetPlayerFromId(source)
        local result = MySQL.Sync.fetchAll("SELECT nitro FROM owned_vehicles WHERE plate = @plate", {
          ['@plate'] = plate
          })
          local check          = result[1]
          local resultado	   = check['nitro']

          if resultado == "sim" then
          cb(true)
          MySQL.Sync.execute("UPDATE owned_vehicles SET nitro =@comprado WHERE plate=@plate",{['@comprado'] = "nao" , ['@plate'] = plate})
          elseif resultado == "nao" then
          cb(false)
          end
    end)
