-- Local
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local PlayerData = {}
local CurrentAction = nil
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local times 					= 0
local userProperties = {}
local this_Garage = {}
local bilhete = false
local placa = ""
local vehi = ""
local locktime = false
local podespawn = false
local umavez = 0
local count = 0
local lastvehicle = nil
local checkcars = {
	[1] = {value = 0, model = "", plate = "", vehicle = {}},
	[2] = {value = 0, model = "", plate = "", vehicle = {}},
	[3] = {value = 0, model = "", plate = "", vehicle = {}},
	[4] = {value = 0, model = "", plate = "", vehicle = {}},
	[5] = {value = 0, model = "", plate = "", vehicle = {}},
	[6] = {value = 0, model = "", plate = "", vehicle = {}},
	[7] = {value = 0, model = "", plate = "", vehicle = {}},
	[8] = {value = 0, model = "", plate = "", vehicle = {}},
	[9] = {value = 0, model = "", plate = "", vehicle = {}},
	[10] = {value = 0, model = "", plate = "", vehicle = {}},
	[11] = {value = 0, model = "", plate = "", vehicle = {}},
	[12] = {value = 0, model = "", plate = "", vehicle = {}},
	[13] = {value = 0, model = "", plate = "", vehicle = {}},
	[14] = {value = 0, model = "", plate = "", vehicle = {}},
	[15] = {value = 0, model = "", plate = "", vehicle = {}},
	[16] = {value = 0, model = "", plate = "", vehicle = {}},
	[17] = {value = 0, model = "", plate = "", vehicle = {}},
	[18] = {value = 0, model = "", plate = "", vehicle = {}},
	[19] = {value = 0, model = "", plate = "", vehicle = {}},
	[20] = {value = 0, model = "", plate = "", vehicle = {}},
	[21] = {value = 0, model = "", plate = "", vehicle = {}},
	[22] = {value = 0, model = "", plate = "", vehicle = {}},
	[23] = {value = 0, model = "", plate = "", vehicle = {}},
	[24] = {value = 0, model = "", plate = "", vehicle = {}},
	[25] = {value = 0, model = "", plate = "", vehicle = {}},
	[26] = {value = 0, model = "", plate = "", vehicle = {}},
	[27] = {value = 0, model = "", plate = "", vehicle = {}},
	[28] = {value = 0, model = "", plate = "", vehicle = {}},
	[29] = {value = 0, model = "", plate = "", vehicle = {}},
	[30] = {value = 0, model = "", plate = "", vehicle = {}},
	[31] = {value = 0, model = "", plate = "", vehicle = {}},
	[32] = {value = 0, model = "", plate = "", vehicle = {}},
	[33] = {value = 0, model = "", plate = "", vehicle = {}},
	[34] = {value = 0, model = "", plate = "", vehicle = {}},
	[35] = {value = 0, model = "", plate = "", vehicle = {}},
	[36] = {value = 0, model = "", plate = "", vehicle = {}},
	[37] = {value = 0, model = "", plate = "", vehicle = {}},
	[38] = {value = 0, model = "", plate = "", vehicle = {}},
	[39] = {value = 0, model = "", plate = "", vehicle = {}},
	[40] = {value = 0, model = "", plate = "", vehicle = {}},
	[41] = {value = 0, model = "", plate = "", vehicle = {}},
	[42] = {value = 0, model = "", plate = "", vehicle = {}},
	[43] = {value = 0, model = "", plate = "", vehicle = {}},
	[44] = {value = 0, model = "", plate = "", vehicle = {}},
	[45] = {value = 0, model = "", plate = "", vehicle = {}},
	[46] = {value = 0, model = "", plate = "", vehicle = {}},
	[47] = {value = 0, model = "", plate = "", vehicle = {}},
	[48] = {value = 0, model = "", plate = "", vehicle = {}},
	[49] = {value = 0, model = "", plate = "", vehicle = {}},
	[50] = {value = 0, model = "", plate = "", vehicle = {}},
}

-- End Local
-- Initialise ESX

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

-- End ESX Initialisation
--- Generate map blips



-- Private Blips

local function has_value (tab, val)
	for index, value in ipairs(tab) do
			if value == val then
					return true
			end
	end

	return false
end


-- End Private Blips
-- End map blip generation
-- Main menu

function OpenMenuGarage(PointType)

	ESX.UI.Menu.CloseAll()

	local elements = {}

	if PointType == 'spawn' then
		table.insert(elements,{label = _U('list_vehicles'), value = 'list_vehicles'})
	end

	if PointType == 'comando' then
		table.insert(elements,{label = _U('list_vehicles'), value = 'list_vehicles1'})
	end

	if PointType == 'delete' then
		table.insert(elements,{label = _U('stock_vehicle'), value = 'stock_vehicle'})
	end

	if PointType == 'pound' then
		table.insert(elements,{label = "Veiculos Apreendidos", value = 'return_vehicle'})
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'garage_menu',
		{
			title    = _U('garage'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'list_vehicles') then
				ListVehiclesMenu()
			end
			if(data.current.value == 'list_vehicles1') then
				ListVehiclesMenu()
			end
			if(data.current.value == 'stock_vehicle') then
				if bilhete == true then	
					StockVehicleMenu()
				else
					TriggerEvent('esx:showNotification', 'Tem de obter o Bilhete de Parque')
				end
			end
			if(data.current.value == 'return_vehicle') then
				ReturnVehicleMenu()
			end


		end,
		function(data, menu)
			menu.close()
			
		end
	)	
end
	
-- Vehicle list

function ListVehiclesMenu()
	local elements = {}

	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)

		for _,v in pairs(vehicles) do

			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    		local labelvehicle
			local plate = v.plate

    		if(v.state)then
    		labelvehicle = vehicleName.. ' (' .. plate .. ') ' .._U('garage')
    		else
    		labelvehicle = vehicleName.. ' (' .. plate .. ') Out of Garage'
    		end	
			table.insert(elements, {label =labelvehicle , value = v})
			
		end

	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = _U('garage'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)
			menu.close()
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
	)	
	end)
end

-- End vehicle list

function reparation(prix,vehicle,vehicleProps, health)
	
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = _U('return_vehicle').." ("..prix.."$)", value = 'yes'},
	}
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'delete_menu',
		{
			title    = _U('damaged_vehicle'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'yes') then
				ESX.TriggerServerCallback('kuana:payhealth', function(check)
					if check then
						SetVehicleEngineHealth(vehicle, 1000)
						TriggerServerEvent('garagem:fixcar', vehiclePropsn.plate, 1000)
						ESX.ShowNotification("You fixed your vehicle with ~g~success~w~.")
					else
						TriggerEvent('esx:showNotification', "You ~r~don't~w~ have enough ~g~money~w~")
					end
				end, prix)
			end
		end,
		function(data, menu)
			menu.close()
			
		end
	)	
end
RegisterNetEvent('kuana:ranger')
AddEventHandler('kuana:ranger', function(vehicle)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('kuana:modifystate', vehicleProps.plate, true)
	TriggerEvent('esx:showNotification', "Your ~g~vehicle~w~is in your garage")
end)

-- Store vehicle

-- End story vehicle
--End main menu
--Vehicle spawn

RegisterNetEvent('kuana:checkcoordss')
AddEventHandler('kuana:checkcoordss', function(xx, yy, zz, hh, vidaa)
		local cods = {x = xx + 0, y = yy + 0, z= zz + 1}
		local hh    = hh + 0.0000000001
		local vidaa = vidaa + 0.0
		ESX.Game.SpawnVehicle(vehi.model, cods,hh, function(callback_vehicle)
			ESX.Game.SetVehicleProperties(callback_vehicle, vehi)
			ESX.TriggerServerCallback('kuana:checklock', function(islock)
				if islock == true then
					SetVehicleDoorsLocked(callback_vehicle, 2)
				elseif islock == false then
					SetVehicleDoorsLocked(callback_vehicle, 1)
				end
			end, placa)
			SetVehRadioStation(callback_vehicle, "OFF")
			SetVehicleEngineHealth(callback_vehicle, vidaa)
		end)	
		ESX.ShowNotification("Your car is in the ~b~last location~w~ you parked or was ~b~seized~w~.")	
	TriggerServerEvent('kuana:modifystate', placa, false)
	
end)

--End vehicle spawn
--Spawn impounded vehicle

--End spawn impounded vehicle
--Marker action notifications




--End marker action notifications

function ReturnVehicleMenu()

	ESX.TriggerServerCallback('kuana:getOutVehicles', function(vehicles)

		local elements = {}

		for _,v in pairs(vehicles) do

			local hashVehicule = v.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local plate = v.plate

    		labelvehicle = vehicleName..': ' ..plate
    	
			table.insert(elements, {label =labelvehicle, value = v})
			
		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'return_vehicle',
		{
			title    = "Veiculos apreendidos",
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)
			placa = data.current.value.plate
			TriggerServerEvent('kuana:modifystate', placa, true)
			TriggerEvent('esx:showNotification', "Car ~g~delivered~w~ to the ~b~owner~w~.")
			menu.close()
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
		)	
	end)
end

-- Marker display

-- End marker display
-- Activate menu when in

-- End Activate menu when in
-- Controls/Keybinds

-- End Controls/Keybinds
--RegisterCommand('garage', function(source, args, rawCommand)
	--OpenMenuGarage('comando')
--end)
--RegisterCommand('mycars', function(source, args, rawCommand)
	--OpenMenuGarage('comando')
--end)

--RegisterCommand('spawnall', function(source, args, rawCommand)
	--if umavez == 0 then
		--ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
			--for _,v in pairs(vehicles) do
				--Citizen.Wait(1000)
				--ESX.TriggerServerCallback('kuana:checkcoordsall', function(xx, yy, zz, hh, vidaa)
					--local cods = {x = xx + 0, y = yy + 0, z= zz + 0}
					--local hh    = hh + 0.0000000001
					--local vidaa = vidaa + 0.0
					--ESX.Game.SpawnVehicle(v.vehicle.model, cods,hh, function(callback_vehicle)
						--ESX.Game.SetVehicleProperties(callback_vehicle, v.vehicle)
						--ESX.TriggerServerCallback('kuana:checklock', function(islock)
							--if islock == true then
								--SetVehicleDoorsLocked(callback_vehicle, 2)
							--elseif islock == false then
								--SetVehicleDoorsLocked(callback_vehicle, 1)
							--end
						--end, v.plate)
						--SetVehRadioStation(callback_vehicle, "OFF")
						--SetVehicleEngineHealth(callback_vehicle, vidaa)
						--count = count + 1
					 --checkcars[count].value = callback_vehicle
					 --checkcars[count].model = v.vehicle.model
					 --checkcars[count].plate = v.plate
					 --checkcars[count].vehicle = v.vehicle
					--end)
					--TriggerServerEvent('kuana:modifystate', v.plate, false)
				--end, v.plate)
			--end
		--end)
		--umavez = 1
	--end
--end)

--RegisterCommand('seizedcars', function(source, args, rawCommand)
--	if PlayerData.job.name == "police" then
--		OpenMenuGarage('pound')
--	else
--		ESX.ShowNotification("You need to be a ~b~cop~w~ to do that.")
--	end
--end)

--RegisterCommand('park', function(source, args, rawCommand)
--	ped = GetPlayerPed(-1)
--	local vehicle = 0
--	if IsPedInAnyVehicle(ped) then
--		vehicle = GetVehiclePedIsUsing(ped)
--		local model = GetEntityModel(vehicle)
--		local x,y,z = table.unpack(GetEntityCoords(vehicle))
--		local headings = GetEntityHeading(vehicle)
--		local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
--		local engineHealth  = GetVehicleEngineHealth(vehicle)
--		ESX.ShowNotification("You saved your vehicle with ~g~success~w~.")
--		TriggerServerEvent('garagem:apre', vehicleProps.plate, x, y, z, headings, engineHealth)
--	else
--		ESX.ShowNotification("You need to be inside of your vehicle.")
--	end
--end)

--RegisterCommand('fixcar', function(source, args, rawCommand)
	--local ped = GetPlayerPed(-1)
	--if IsPedInAnyVehicle(ped) then
		--local playerVeh = GetVehiclePedIsIn(ped, false)
		--local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerVeh)
		--ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
			--for _,v in pairs(vehicles) do
				--if vehiclePropsn.plate == v.plate then
					--local engineHealth  = GetVehicleEngineHealth(playerVeh)
					--local fraisRep= math.floor((1000 - engineHealth)*10)	
					--if engineHealth < 1000 then
						--reparation(fraisRep,playerVeh,vehiclePropsn, engineHealth)
					--else
						--ESX.ShowNotification("You fixed your vehicle with ~g~success~w~.")
						--TriggerServerEvent('garagem:fixcar', vehiclePropsn.plate, 1000)
						--SetVehicleEngineHealth(playerVeh, 1000)
					--end
				--end
			--end
		--end)
	--else
		--ESX.ShowNotification("You ~g~need~w~ inside a vehicle.")
	--end
--end)


--RegisterCommand('seize', function(source, args, rawCommand)
--	ped = GetPlayerPed(-1)
--	local vehicle = 0
--	if PlayerData.job.name == "police" then
--		if IsPedInAnyVehicle(ped) then
--			vehicle = GetVehiclePedIsUsing(ped)
--			local model = GetEntityModel(vehicle)
--			local x,y,z = table.unpack(GetEntityCoords(vehicle))
--			local headings = GetEntityHeading(vehicle)
--			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
--			local engineHealth  = GetVehicleEngineHealth(vehicle)
--			ESX.ShowNotification("You seized your vehicle with ~g~success~w~.")
--			TriggerServerEvent('garagem:apre', vehicleProps.plate, x, y, z, headings, engineHealth)
--			ESX.Game.DeleteVehicle(vehicle)
--		else
--			ESX.ShowNotification("You need to be inside of a vehicle to seize it.")
--		end
--	else
--		ESX.ShowNotification("You need to be a ~b~cop~w~ to do that.")
--	end
--end)
RegisterNetEvent('kuana:checkveh')
AddEventHandler('kuana:checkveh', function(xxx, yyy, zzz)
        local xxx = xxx + 0.0
        local zzz = zzz + 0.0
		local yyy = yyy + 0.0
				blipm = AddBlipForCoord(xxx, yyy, zzz)
        			
    				SetBlipSprite (blipm, 66)
    				SetBlipDisplay(blipm, 4)
    				SetBlipScale  (blipm, 0.8)
   					SetBlipColour (blipm, 59)
    				SetBlipAsShortRange(blipm, true)
    				BeginTextCommandSetBlipName("STRING")
    				AddTextComponentString("Lost Car")
					EndTextCommandSetBlipName(blipm)
end)

RegisterCommand('findcar', function(source, args, rawCommand)
		local placa = rawCommand:sub(9)
		local elements = {
					
		}
		if PlayerData.job ~= nil and PlayerData.job.name == "police" then
			if placa ~= "" then
				ESX.TriggerServerCallback('kuana:checkcarfind', function(vehicles)
					for _,v in pairs(vehicles) do
							local hashVehicule = v.vehicle.model
							local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
							local labelvehicle
							carname = ""..v.target..""
							local plate = v.plate

						
						table.insert(elements, {label ="Check Owner" , value = "carowner"})
						table.insert(elements, {label ="Car Model: "..vehicleName , value = vehicleName})
						table.insert(elements, {label ="Plate: "..placa , value = "placa"})
						if v.lock == "nao" then
							table.insert(elements, {label ="Lock: Unlocked" , value = "unlock"})
						elseif v.lock == "sim" then
							table.insert(elements, {label ="Lock: Locked" , value = "lock"})
						end
						if not blipmapa then
							table.insert(elements, {label ="Place on GPS" , value = "gps"})
						else
							table.insert(elements, {label ="Remove on GPS" , value = "gps2"})
						end
					end
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'findcar',
						{
							title    = "",
							align    = 'top-left',
							elements = elements,
						},
						function(data, menu)
				
							
							if data.current.value == 'gps' then
								blipmapa = true
								RemoveBlip(blipm)
								TriggerServerEvent('kuana:checkvehi', placa)
								menu.close()
							elseif data.current.value == 'gps2' then
								blipmapa = false
								RemoveBlip(blipm)
								menu.close()
							elseif data.current.value == 'carowner' then
								local elements3 = {

								}
								ESX.TriggerServerCallback('kuana:checkcarowner', function(owner)
									for _,v in pairs(owner) do
										table.insert(elements3, {label ="Name: "..v.names , value = "name"})
										if v.sex == "M" then
											table.insert(elements3, {label ="Sex: Male" , value = "sex"})
										else
											table.insert(elements3, {label ="Sex: Female" , value = "sex"})
										end
										table.insert(elements3, {label ="Height: "..v.height.." cm" , value = "height"})
										table.insert(elements3, {label ="Back" , value = "back"})
									end

									ESX.UI.Menu.Open(
										'default', GetCurrentResourceName(), 'findcarowner',
										{
											title    = "",
											align    = 'top-left',
											elements = elements3,
										},
										function(data2, menu2)
											if data2.current.value == "back" then
												menu2.close()
											end
										end,
										function(data2, menu2)
											menu2.close()											
										end
									)									
								end, carname)
							end
						end,
						function(data, menu)
							menu.close()
							
						end
					)
				end, placa)	
			else
				ESX.ShowNotification("~r~Wrong Comand~w~: /findcar [plate] ")
			end
		else
			ESX.ShowNotification("You need to be a ~b~Police~w~ to do that.")
		end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('kuana:updateall')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand('givecarkeys', function(source, args, rawCommand)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = nil
	end
	
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	local platec = vehicleProps.plate
	

	local elements2 = {}

			ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)

				for _,v in pairs(vehicles) do

					local hashVehicule = v.vehicle.model
						local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
						local platep = v.plate
						local labelvehicle = ""..vehicleName.." | Plate: " ..platep
						if platep == platec then
							table.insert(elements2, {label =labelvehicle , value = v})
						end
				end
				Citizen.Wait(1000)

			
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'sell_vehicle',
				{
					title    = "Sell Vehicles",
					align    = 'top-left',
					elements = elements2,
				},
				function(data, menu)
						menu.close()
						if IsPedInAnyVehicle(playerPed,  false) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification('No players nearby!')
							else
							ESX.ShowNotification('You are giving your car keys for vehicle with plate ~g~'..vehicleProps.plate..'!')
							TriggerServerEvent('esx_darcoche:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
							end
						else
							menu.close()
						end
				end,
				function(data, menu)
					menu.close()
					--CurrentAction = 'open_garage_action'
				end
			)	
			end)
end)

RegisterCommand('neon', function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
		if IsPedInAnyVehicle(ped) then
			local playerVeh = GetVehiclePedIsIn(ped, false)
			local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerVeh)
			ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
				for _,v in pairs(vehicles) do
					if vehiclePropsn.plate == v.plate then
						if neons == true then
							SetVehicleNeonLightEnabled(playerVeh,0,true)
							SetVehicleNeonLightEnabled(playerVeh,1,true)
							SetVehicleNeonLightEnabled(playerVeh,2,true)
							SetVehicleNeonLightEnabled(playerVeh,3,true)
							neons = false
						else
							SetVehicleNeonLightEnabled(playerVeh,0,false)
							SetVehicleNeonLightEnabled(playerVeh,1,false)
							SetVehicleNeonLightEnabled(playerVeh,2,false)
							SetVehicleNeonLightEnabled(playerVeh,3,false)
							neons = true
						end
					end
				end
			end)
		else
			ESX.ShowNotification("You ~g~need~w~ inside a vehicle.")
		end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(1, 303) then
			local ped = GetPlayerPed(-1)
			local coords    = GetEntityCoords(ped)
			playerLastVeh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(playerLastVeh), 1)
			if IsPedInAnyVehicle(ped) then
				local playerVeh = GetVehiclePedIsIn(ped, false)
				local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerVeh)
				ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
					for _,v in pairs(vehicles) do
						if vehiclePropsn.plate == v.plate then
							ESX.TriggerServerCallback('kuana:checklock', function(islock)
								if islock == false then
									SetVehicleDoorsLocked(playerVeh, 2)
									ESX.ShowNotification("The vehicle is ~r~locked~w~.")
									TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "lock", 1.0)
									TriggerServerEvent("garagem:lockvehi", vehiclePropsn.plate)
								elseif islock == true then
									SetVehicleDoorsLocked(playerVeh, 1)
									ESX.ShowNotification("The vehicle is ~g~unlocked~w~.")
									TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "unlock", 1.0)
									TriggerServerEvent("garagem:lockvehia", vehiclePropsn.plate)
								end
							end, vehiclePropsn.plate)
						end
					end
				end)
			elseif distanceToVeh <= 4 then
				local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerLastVeh)
				ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
					for _,v in pairs(vehicles) do
						if vehiclePropsn.plate == v.plate then
							ESX.TriggerServerCallback('kuana:checklock', function(islock)
								if islock == false then
									--ANIMATION------------------------------
									RequestModel(GetHashKey("p_car_keys_01"))
									while not HasModelLoaded(GetHashKey("p_car_keys_01")) do
											Citizen.Wait(100)
									end
							
									local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -5.0)
									local micspawned = CreateObject(GetHashKey("p_car_keys_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
									local netid = ObjToNet(micspawned)
									SetNetworkIdExistsOnAllMachines(netid, true)
									NetworkSetNetworkIdDynamic(netid, true)
									SetNetworkIdCanMigrate(netid, false)
									AttachEntityToEntity(micspawned, ped, GetPedBoneIndex(ped, 28422), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
									ESX.Streaming.RequestAnimDict("anim@mp_atm@enter", function()
										TaskPlayAnim(ped, "anim@mp_atm@enter", "enter", 8.0, -8.0, -1, 0, 0, false, false, false)
										Citizen.Wait(1000)
										SetVehicleDoorsLocked(playerLastVeh, 2)
										ESX.ShowNotification("The vehicle is ~r~locked~w~.")
										TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "lock", 1.0)
										TriggerServerEvent("garagem:lockvehi", vehiclePropsn.plate)
										Citizen.Wait(3000)
									end)
									ClearPedSecondaryTask(ped)
									DetachEntity(NetToObj(netid), 1, 1)
									DeleteEntity(NetToObj(netid))
									------------------------------------------
								elseif islock == true then
									--ANIMATION------------------------------
									RequestModel(GetHashKey("p_car_keys_01"))
									while not HasModelLoaded(GetHashKey("p_car_keys_01")) do
											Citizen.Wait(100)
									end
							
									local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -5.0)
									local micspawned = CreateObject(GetHashKey("p_car_keys_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
									local netid = ObjToNet(micspawned)
									SetNetworkIdExistsOnAllMachines(netid, true)
									NetworkSetNetworkIdDynamic(netid, true)
									SetNetworkIdCanMigrate(netid, false)
									AttachEntityToEntity(micspawned, ped, GetPedBoneIndex(ped, 28422), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
									ESX.Streaming.RequestAnimDict("anim@mp_atm@enter", function()
										TaskPlayAnim(ped, "anim@mp_atm@enter", "enter", 8.0, -8.0, -1, 0, 0, false, false, false)
										Citizen.Wait(1000)
										SetVehicleDoorsLocked(playerLastVeh, 1)
										ESX.ShowNotification("The vehicle is ~g~unlocked~w~.")
										TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "unlock", 1.0)
										TriggerServerEvent("garagem:lockvehia", vehiclePropsn.plate)
										Citizen.Wait(3000)
									end)
									ClearPedSecondaryTask(ped)
									DetachEntity(NetToObj(netid), 1, 1)
									DeleteEntity(NetToObj(netid))
									------------------------------------------
								end
							end, vehiclePropsn.plate)
						end
					end
				end)
			end
			Citizen.Wait(1000)
		end
	end
end)


RegisterCommand('garage', function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	local veh = ESX.Game.GetVehiclesInArea(pos, 20000.0)
	local elements = {}
	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
		for _,v in pairs(vehicles) do
			local hashVehicule = v.vehicle.model
			local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local plate = v.plate
			labelvehicle = vehicleName.. ' (' .. plate .. ') '			
			table.insert(elements, {label =labelvehicle , value = v})
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'spawn_vehiclereload',
			{
				title    = _U('garage'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)
					for i=1, #veh, 1 do
						if veh then
							local vehiclePropsn  = ESX.Game.GetVehicleProperties(veh[i])
							if vehiclePropsn.plate == data.current.value.plate then
								podespawn = false
								break
							else
								podespawn = true
							end
						else
							podespawn = true
						end
					end

					if podespawn == true then
						ESX.TriggerServerCallback('kuana:checkcoordsall', function(xx, yy, zz, hh, vidaa)
							local cods = {x = xx + 0, y = yy + 0, z= zz + 1}
							local hh    = hh + 0.0000000001
							local x = xx + 0
							local y = yy + 0
							local z = zz + 1
							local vidaa = vidaa + 0.0
							local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), x, y, z, 1)
							if distanceToVeh <= 1000 then
								ESX.Game.SpawnVehicle(data.current.value.vehicle.model, cods,hh, function(callback_vehicle)
									ESX.Game.SetVehicleProperties(callback_vehicle, data.current.value.vehicle)
									ESX.TriggerServerCallback('kuana:checklock', function(islock)
										if islock == true then
											SetVehicleDoorsLocked(callback_vehicle, 2)
										elseif islock == false then
											SetVehicleDoorsLocked(callback_vehicle, 1)
										end
									end, data.current.value.plate)
									SetVehRadioStation(callback_vehicle, "OFF")
									SetVehicleEngineHealth(callback_vehicle, vidaa)
								end)
								TriggerServerEvent('kuana:modifystate', data.current.value.plate, false)
								ESX.ShowNotification("Your car ~g~spawned~w~.")
							else
								ESX.ShowNotification("~r~Out~w~ of range.")
							end
						end, data.current.value.plate)
						menu.close()
				else
					ESX.ShowNotification("Your car was ~g~already~w~ spawned,")
				end
			end,
			function(data, menu)
				menu.close()
				--CurrentAction = 'open_garage_action'
			end
		)	
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
		if IsPedInAnyVehicle(ped) then
			lastvehicle = GetVehiclePedIsUsing(ped)
		else
			if lastvehicle ~= nil then
				local model = GetEntityModel(lastvehicle)
				local x,y,z = table.unpack(GetEntityCoords(lastvehicle))
				local headings = GetEntityHeading(lastvehicle)
				local vehicleProps  = ESX.Game.GetVehicleProperties(lastvehicle)
				local engineHealth  = GetVehicleEngineHealth(lastvehicle)
				TriggerServerEvent('garagem:apre', vehicleProps.plate, x, y, z, headings, engineHealth)
				lastvehicle = nil
			end
		end
	end
end)