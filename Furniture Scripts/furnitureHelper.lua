
furnitureCatalogueScript = {}

local config = {}
config.MainGui = 69420
config.categoryList = 69421
config.MessageBox = 69422
config.InputDialog = 69423
config.nameRequiredCommands = {"fsm", "furnselectmode"}
config.names = {"droid", "S3ctor"}
config.rankRequired = 0

local category = {}
local objectRefId = {}
local mode = {}
local tempObjectData = {}
local undo_last_hit = {}

local function toggleSelectionMode(pid, cmd)
		Players[pid].data.customVariables.furnDestroyMode = false
		Players[pid].data.customVariables.furnSelectMode = not Players[pid].data.customVariables.furnSelectMode
		if Players[pid].data.customVariables.furnSelectMode then
				tes3mp.MessageBox(pid, config.MessageBox, color.LimeGreen .. "Furniture Selection Mode" .. color.Silver .. " has been" .. color.LimeGreen .. " enabled.")
		else
				tes3mp.MessageBox(pid, config.MessageBox, color.LimeGreen .. "Furniture Selection Mode" .. color.Silver .. " has been" .. color.Red .. " disabled.")
		end
end

local function toggleDestructionMode(pid, cmd)
		Players[pid].data.customVariables.furnSelectMode = false
		Players[pid].data.customVariables.furnDestroyMode = not Players[pid].data.customVariables.furnDestroyMode
		if Players[pid].data.customVariables.furnDestroyMode then
				tes3mp.MessageBox(pid, config.MessageBox, color.LimeGreen .. "Furniture Destruction Mode" .. color.Silver .. " has been" .. color.LimeGreen .. " enabled. With Great Power Comes Great Responsibility!")
		else
				tes3mp.MessageBox(pid, config.MessageBox, color.LimeGreen .. "Furniture Destruction Mode" .. color.Silver .. " has been" .. color.Red .. " disabled.")
		end
end

local function SendObjectState(pid, refId, cellDescription, uniqueIndex, state)

		local pname = tes3mp.GetName(pid)

    tes3mp.ClearObjectList()
    tes3mp.SetObjectListPid(pid)
    tes3mp.SetObjectListCell(cellDescription)
    local splitIndex = uniqueIndex:split("-")
    tes3mp.SetObjectRefNum(splitIndex[1])
    tes3mp.SetObjectMpNum(splitIndex[2])
    tes3mp.SetObjectState(state)
    tes3mp.AddObject()
    tes3mp.SendObjectState(true, false)

		local objectStatesToSave = {}
		objectStatesToSave[uniqueIndex] = {refId = refId, state = state}

		LoadedCells[cellDescription]:SaveObjectStates(objectStatesToSave)

		--TODO make objects to disable table so we can undo the last object[-1]...
		local objectsToDisable = {}

		objectsToDisable.refNum = splitIndex[1]
		objectsToDisable.mpNum = splitIndex[2]
		objectsToDisable.cell = cellDescription
		objectsToDisable.refId = refId
		objectsToDisable.index = uniqueIndex

		table.insert(undo_last_hit[pname], objectsToDisable)

end

local function undo(pid, cmd)

		local pname = tes3mp.GetName(pid)

		if  tableHelper.isEmpty(undo_last_hit[pname]) then

				tes3mp.MessageBox(pid, config.MessageBox, color.LimeGreen .. "Nothing to" .. color.Red .. " undo" .. color.LimeGreen .. " yet.")

				return
		end

		tes3mp.ClearObjectList()
    tes3mp.SetObjectListPid(pid)
    tes3mp.SetObjectListCell(undo_last_hit[pname][#undo_last_hit[pname]].cell)
		tes3mp.SetObjectRefNum(undo_last_hit[pname][#undo_last_hit[pname]].refNum)
    tes3mp.SetObjectMpNum(undo_last_hit[pname][#undo_last_hit[pname]].mpNum)
    tes3mp.SetObjectState(true)
    tes3mp.AddObject()
    tes3mp.SendObjectState(true, false)

		local uniqueIndex = undo_last_hit[pname][#undo_last_hit[pname]].refNum .. "-" .. undo_last_hit[pname][#undo_last_hit[pname]].mpNum

		local objectStatesToSave = {}
		objectStatesToSave[uniqueIndex] = {refId = undo_last_hit[pname][#undo_last_hit[pname]].refId, state = true}

		LoadedCells[undo_last_hit[pname][#undo_last_hit[pname]].cell]:SaveObjectStates(objectStatesToSave)

		table.remove(undo_last_hit[pname])
end

local function flush_turds(pid, cmd)

		local pname = tes3mp.GetName(pid)

		if  tableHelper.isEmpty(undo_last_hit[pname]) then

				tes3mp.MessageBox(pid, config.MessageBox, color.LimeGreen .. "Nothing to" .. color.Red .. " flush.")

				return
		end

		for i, object in pairs(undo_last_hit[pname]) do
				logicHandler.DeleteObjectForEveryone(object.cell, object.index)
		end

		undo_last_hit[pname] = {}

		tes3mp.MessageBox(pid, config.MessageBox, color.Red .. "The turds have been flushed.")

end

local function MainGUI(pid)
		tes3mp.CustomMessageBox(pid, config.MainGui, "Choose or select a category.", "Choose Category;Create Category;Cancel;")
end

local function categoryList(pid)
		local list = ""
		table.sort(kanaFurniture.furnitureCategories, function(a,b) return a < b end)
		for i, v in pairs(kanaFurniture.furnitureCategories) do
				list = list .. tostring(v) .. "\n"
		end

		tes3mp.ListBox(pid, config.categoryList, "Select a category.\nSelect nothing to cancel.", list)
end

local function append_furniture(pid)

		local pname = tes3mp.GetName(pid)

		for cat, value in pairs(kanaFurniture.furnitureData) do
				if tostring(category[pname]) == tostring(cat) then
						tempObjectData[pname].refId = objectRefId[pname]
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
						tes3mp.MessageBox(pid, config.MessageBox, color.Silver .. "name: " .. color.LimeGreen .. tempObjectData[pname].name .. color.Silver .. "\nrefId: " .. color.LimeGreen ..
						tempObjectData[pname].refId .. color.Silver .. "\nwas added to the furniture list inside the category: " .. color.LimeGreen .. category[pname] .. "\n")

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

if not tes3mp.HasItemEquipped(pid, "furn_selection_tool") or not tableHelper.containsKeyValue(objects, "hittingPid", pid, true) then return end

furnitureMode = Players[pid].data.customVariables

--TODO do all of the stuff
		if furnitureMode.furnSelectMode then

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

		elseif furnitureMode.furnDestroyMode then
			if not kanaHousing then return end -- kanaHousing not installed

			local pname = tes3mp.GetName(pid) -- See if this can do to be removed, pname causes crashes

			local hdata = kanaHousing.GetCellData(cellDescription)
			local odata = kanaHousing.GetOwnerData(pname)

			-- if player is admin then let them delete anything.... otherwise only in a house you own.
			if not Players[pid]:IsAdmin() then
					if not hdata or not odata or not odata.houses[hdata.house] then return end
			end

			for index, object in pairs(objects) do
				SendObjectState(pid, object.refId, cellDescription, index, false) -- Delete the smacked thing
			end

		end
end

furnitureCatalogueScript.OnPlayerAuthentifiedHandler = function(eventStatus, pid)

		if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then
				Players[pid].data.customVariables.furnSelectMode = false
				Players[pid].data.customVariables.furnDestroyMode = false
				tes3mp.LogAppend(enumerations.log.INFO, "------------------------- " .. "furnSelectMode was set to false")

				local pname = tes3mp.GetName(pid)

				category[pname] = ""
				objectRefId[pname] = ""
				mode[pname] = ""
				tempObjectData[pname] = {}
				undo_last_hit[pname] = {}

				if tableHelper.containsValue(config.names, pname) then
						if not tableHelper.containsValue(Players[pid].data.inventory, "furn_selection_tool", true) then
								logicHandler.RunConsoleCommandOnPlayer(pid, 'player->additem "furn_selection_tool" 1', false)
								--tableHelper.print(Players[pid].data.inventory)
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
customCommandHooks.registerCommand("fdm", toggleDestructionMode)
customCommandHooks.registerCommand("undo", undo)
customCommandHooks.registerCommand("flush", flush_turds)

--[[for command, v in pairs(customCommandHooks.commands) do
		for j = 1, #config.nameRequiredCommands do
				if command == config.nameRequiredCommands[j] then
						customCommandHooks.setNameRequirement(command, config.names)
				end
		end
end

for i, v in pairs(config.nameRequiredCommands) do
		customCommandHooks.setRankRequirement(v, config.rankRequired)
end]]--

return furnitureCatalogueScript
