
furnitureCatalogueScript = {}

local config = {}
config.MainGui = 69420
config.categoryList = 69421
config.MessageBox = 69422
config.InputDialog = 69423
config.nameRequiredCommands = {"fsm", "furnselectmode", "cs"}
config.names = {"test1", "test2", "test3", "test4", "cyborg"}
config.rankRequired = 0

local category = {}
local objectRefId = {}
local mode = {}
local tempObjectData = {}

if jsonInterface.load("custom/furniture_crafting.json") == nil then
		jsonInterface.save("custom/furniture_crafting.json", furnitureCrafting)
		tes3mp.LogAppend(enumerations.log.INFO, "------------------------- " .. "furniture_crafting.json was created")
else
		furnitureCrafting = jsonInterface.load("custom/furniture_crafting.json")
		tes3mp.LogAppend(enumerations.log.INFO, "------------------------- " .. "furniture_crafting.json was loaded")
end

local function toggleSelectionMode(pid, cmd)
		Players[pid].data.customVariables.furnSelectMode = not Players[pid].data.customVariables.furnSelectMode
		tes3mp.MessageBox(pid, config.MessageBox, color.LimeGreen .. Furniture Selection Mode .. color.Silver .. " has been enabled.")
end

local function MainGUI(pid)
		tes3mp.CustomMessageBox(pid, config.MainGui, "Choose or select a category.", "Choose Category;Create Category;Cancel;")
end

local function categoryList(pid)
		local list = ""
		for i, v in pairs(kanaFurniture.furnitureCategories) do
				list = list .. tostring(v) .. "\n"
		end
		tes3mp.ListBox(pid, config.categoryList, "Select a category.\nSelect nothing to cancel.", list)
end

local function append_furniture(pid)

		local pname = tes3mp.GetName(pid)

		for cat, value in pairs(kanaFurniture.furnitureData) do
				tes3mp.LogAppend(enumerations.log.INFO, "------------------------- " .. "TOP of append_furniture. category: " .. tostring(type(category[pname])))
				tes3mp.LogAppend(enumerations.log.INFO, "------------------------- " .. "TOP of append_furniture. value.name: " .. tostring(type(value.category)))
				if tostring(category[pname]) == tostring(cat) then
						tempObjectData[pname].refId = objectRefId[pname]
						tes3mp.LogAppend(enumerations.log.INFO, "------------------------- " .. "value.category: " .. tostring(value.category))						
						tes3mp.MessageBox(pid, config.MessageBox, color.LimeGreen .. objectRefId[pname] .. color.Silver .. " was added to the furniture list inside the category: " .. color.LimeGreen .. category[pname] .. "\n")	
						mode[pname] = "name"
						tes3mp.InputDialog(pid, config.InputDialog, "Enter a name.", "Enter one space to cancel.")				
				end
		end
end

local function create_new_category(pid)

		local pname = tes3mp.GetName(pid)

		mode[pname] = "category"
		tes3mp.InputDialog(pid, config.InputDialog, "Enter a new category.", "Enter one space to cancel.")

end

furnitureCatalogueScript.OnGUIAction = function(eventStatus, pid, idGui, data)

		local pname = tes3mp.GetName(pid)

		if idGui == config.MainGui then
				if tonumber(data) == 0 then
						categoryList(pid)
				elseif tonumber(data) == 1 then
					 	create_new_category(pid)
				else
						return
				end
	  elseif idGui == config.categoryList then
				for i = 0, #kanaFurniture.furnitureCategories do
						if tonumber(data) == i then
								category[pname] = tostring(kanaFurniture.furnitureCategories[i+1])
								append_furniture(pid)
						end
				end
		elseif idGui == config.InputDialog then

				if tostring(data) == " " then return end

				if mode[pname] == "category" then

						category[pname] = tostring(data)
						kanaFurniture.furnitureData[category[pname]] = {}
						table.insert(kanaFurniture.furnitureCategories, tostring(data))
						tableHelper.print(kanaFurniture.furnitureCategories)
						tempObjectData[pname].refId = objectRefId[pname]
						tes3mp.MessageBox(pid, config.MessageBox, color.Silver .. "New category " .. color.LimeGreen .. tostring(data) .. color.Silver .. " was created\n")
						mode[pname] = "name"
						tes3mp.InputDialog(pid, config.InputDialog, "Enter a name.", "Enter one space to cancel.")

				elseif mode[pname] == "name" then

						tempObjectData[pname].name = tostring(data)
						mode[pname] = "price"
						tes3mp.InputDialog(pid, config.InputDialog, "Enter a price.", "Enter one space to cancel.")

				elseif mode[pname] == "price" then

						tempObjectData[pname].price = tonumber(data)
						newData = tableHelper.deepCopy(tempObjectData[pname])
						table.insert(kanaFurniture.furnitureData[category[pname]], newData)
						tableHelper.print(kanaFurniture.furnitureData[category[pname]])

						--TODO function in kanaFurniture that merges the furnitureData tables
						kanaFurniture.mergeFurn()

				end
		end
end

furnitureCatalogueScript.OnObjectActivateValidator = function(eventStatus, pid, cellDescription, objects, targetPlayers)

		if Players[pid].data.customVariables.furnSelectMode == true then

				local pname = tes3mp.GetName(pid)

				MainGUI(pid)

				for index, object in pairs(objects) do
						objectRefId[pname] = object.refId
						table.insert(Players[pid].consoleCommandsQueued, "ExplodeSpell, Shield")
						logicHandler.RunConsoleCommandOnObject(pid, "ExplodeSpell, Shield", cellDescription, tostring(object.uniqueIndex), false)
						logicHandler.RunConsoleCommandOnPlayer(pid, 'PlaySound, "book page2"', false)
						return customEventHooks.makeEventStatus(false, false)
				end
		end
end

furnitureCatalogueScript.OnObjectHitValidator = function(eventStatus, pid, cellDescription, objects, targetPlayers)

--TODO do all of the stuff
		if Players[pid].data.customVariables.furnSelectMode == true and tes3mp.HasItemEquipped(pid, "furn_selection_tool") then

				if not tableHelper.containsKeyValue(objects, "hittingPid", pid, true) then
						return
				end

				local pname = tes3mp.GetName(pid)

				MainGUI(pid)

				for index, object in pairs(objects) do
						objectRefId[pname] = object.refId
						-- needed to prevent getting kicked for using console without permission (check the registered OnConsoleCommand validator in eventHandler.lua)
						-- logichandler.RunConsoleCommandOnObject doesn't queue the command when its forEveryone argument is false)
						table.insert(Players[pid].consoleCommandsQueued, "ExplodeSpell, Shield")
						logicHandler.RunConsoleCommandOnObject(pid, "ExplodeSpell, Shield", cellDescription, tostring(object.uniqueIndex), false)
						logicHandler.RunConsoleCommandOnPlayer(pid, 'PlaySound, "book page2"', false)
						return customEventHooks.makeEventStatus(false, false)
				end
		end
end

furnitureCatalogueScript.OnPlayerAuthentifiedHandler = function(eventStatus, pid)

		if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
				Players[pid].data.customVariables.furnSelectMode = false
				tes3mp.LogAppend(enumerations.log.INFO, "------------------------- " .. "furnSelectMode was set to false")

				local pname = tes3mp.GetName(pid)

				category[pname] = ""
				objectRefId[pname] = ""
				mode[pname] = ""
				tempObjectData[pname] = {}

				if tableHelper.containsValue(config.names, pname) then
						if not tableHelper.containsValue(Players[pid].data.inventory, "furn_selection_tool", true) then
								logicHandler.RunConsoleCommandOnPlayer(pid, 'player->additem "furn_selection_tool" 1', false)
								tableHelper.print(Players[pid].data.inventory)
						end
		 		end
		end
end

customEventHooks.registerValidator("OnObjectHit", furnitureCatalogueScript.OnObjectHitValidator)
customEventHooks.registerValidator("OnObjectActivate", furnitureCatalogueScript.OnObjectActivateValidator)

customEventHooks.registerHandler("OnPlayerAuthentified", furnitureCatalogueScript.OnPlayerAuthentifiedHandler)
customEventHooks.registerHandler("OnGUIAction", furnitureCatalogueScript.OnGUIAction)
-- customEventHooks.registerHandler("OnServerPostInit", furnitureCatalogueScript.OnServerPostInitHandler)

customCommandHooks.registerCommand("furnselectmode", toggleSelectionMode)
customCommandHooks.registerCommand("fsm", toggleSelectionMode)

for command, v in pairs(customCommandHooks.commands) do
		for j = 1, #config.nameRequiredCommands do
				if command == config.nameRequiredCommands[j] then
						customCommandHooks.setNameRequirement(command, config.names)
				end
		end
end

for i, v in pairs(config.nameRequiredCommands) do
		customCommandHooks.setRankRequirement(v, config.rankRequired)
end

return furnitureCatalogueScript
