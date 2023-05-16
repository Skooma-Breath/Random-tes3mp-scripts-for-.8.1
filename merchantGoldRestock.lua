--[[
	Lear's Custom Merchant Restock Script:
		version 1.00 (for TES3MP 0.8 & 0.8.1)

	DESCRIPTION:
		This simple script will ensure your designated merchants always have their gold restocked.
		Simply add the refId of the merchant you want to always restock gold into the `restockingGoldMerchants` table below.

	INSTALLATION:
		1) Place this file as `customMerchantRestock.lua` inside your TES3MP servers `server\scripts\custom` folder.
		2) Open your `customScripts.lua` file in a text editor.
				(It can be found in `server\scripts` folder.)
		3) Add the below line to your `customScripts.lua` file:
				require("custom.customMerchantRestock")
		4) BE SURE THERE IS NO `--` SYMBOLS TO THE LEFT OF IT, ELSE IT WILL NOT WORK.
		5) Save `customScripts.lua` and restart your server.


	VERSION HISTORY:
		1.00 (5/30/2022)		- Initial public release.

		05/16/2023          - modified by skoomabreath to for item restocking
--]]


customMerchantRestock = {}

-- Add the refId of merchants you want to restock their gold every time the "Barter" option is selected below:
local restockingGoldMerchants = {
	"mudcrab_unique",
	"scamp_creeper"
}
-- Add the refId of merchants that will restock items specified in the itemsToRestock table
local itemRestockingMerchants = {
	"meldor",
	"ajira",
}
-- Add the uniqueIndex and table of items you want to restock in the format shown below
local itemsToRestock = {
	--meldor
	["41720-0"] = {
		{
			refId = "repair_journeyman_01",
			count =  20,
		},
	},
	--ajira
	["67618-0"] = {
		{
			refId = "ingred_willow_anther_01",
			count =  5,
		},
		{
			refId = "ingred_scales_01",
			count =  5,
		},
		{
			refId = "food_kwama_egg_01",
			count =  5,
		},
		{
			refId = "ingred_black_anther_01",
			count =  5,
		},
		{
			refId = "ingred_comberry_01",
			count =  5,
		},
		{
			refId = "ingred_crab_meat_01",
			count =  5,
		},
		{
			refId = "ingred_heather_01",
			count =  5,
		},
		{
			refId = "ingred_hound_meat_01",
			count =  5,
		},
		{
			refId = "ingred_kwama_cuttle_01",
			count =  5,
		},
	},
	--fadase selvayn
	["190375-0"] = {
		{
			refId = "Misc_SoulGem_Petty",
			count =  10,
		},
		{
			refId = "Misc_SoulGem_Lesser",
			count =  5,
		},
		{
			refId = "Misc_SoulGem_Common",
			count =  3,
		},
	},
}

local initialMerchantGoldTracking = {} -- Used below for tracking merchant uniqueIndexes and their goldPools.
local fixGoldPool = function(pid, cellDescription, uniqueIndex)

	if initialMerchantGoldTracking[uniqueIndex] ~= nil then

		local cell = LoadedCells[cellDescription]
		local objectData = cell.data.objectData
		if objectData[uniqueIndex] ~= nil and objectData[uniqueIndex].refId ~= nil then

			local currentGoldPool = objectData[uniqueIndex].goldPool

			if currentGoldPool ~= nil and currentGoldPool < initialMerchantGoldTracking[uniqueIndex] then

				tes3mp.ClearObjectList()
				tes3mp.SetObjectListPid(pid)
				tes3mp.SetObjectListCell(cellDescription)

				local lastGoldRestockHour = objectData[uniqueIndex].lastGoldRestockHour
				local lastGoldRestockDay = objectData[uniqueIndex].lastGoldRestockDay

				if lastGoldRestockHour == nil or lastGoldRestockDay == nil then
					objectData[uniqueIndex].lastGoldRestockHour = 0
					objectData[uniqueIndex].lastGoldRestockDay = 0
				end

				objectData[uniqueIndex].goldPool = initialMerchantGoldTracking[uniqueIndex]

				packetBuilder.AddObjectMiscellaneous(uniqueIndex, objectData[uniqueIndex])

				tes3mp.SendObjectMiscellaneous()

			end

		end

	end

end

local restockItems = function(pid, cellDescription, uniqueIndex)

    if itemsToRestock[uniqueIndex] ~= nil then

        local cell = LoadedCells[cellDescription]
        local objectData = cell.data.objectData
				local reloadInventory = false
				local itr = itemsToRestock[uniqueIndex]
				local currentInventory = objectData[uniqueIndex].inventory

        if objectData[uniqueIndex] ~= nil then

						for _, object in pairs(currentInventory) do
								for i, itemData in pairs(itr) do
										if object.refId == itr[i].refId then
												if object.count < itr[i].count then
														object.count = itr[i].count
														reloadInventory = true
												end
										end
								end
						end

						for i, v in pairs(itr) do
								if not tableHelper.containsValue(currentInventory, itr[i].refId, true) then
										inventoryHelper.addItem(currentInventory, itr[i].refId, itr[i].count, itr[i].charge or -1, itr[i].enchantmentCharge or -1, itr[i].soul or "")
										reloadInventory = true
								end
						end

						if reloadInventory then
								--load container data for all pid's in the cell
								for i = 0, #Players do
										if Players[i] ~= nil and Players[i]:IsLoggedIn() then
												if Players[i].data.location.cell == cellDescription then
														cell:LoadContainers(i, cell.data.objectData, {uniqueIndex})
												end
										end
								end
						end

        end
    end
end

customEventHooks.registerValidator("OnObjectDialogueChoice", function(eventStatus, pid, cellDescription, objects)
	if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then

		for uniqueIndex, object in pairs(objects) do

			for i,refId in pairs(restockingGoldMerchants) do
				if object.refId == refId then
					if object.dialogueChoiceType == 3 then -- BARTER
						fixGoldPool(pid, cellDescription, uniqueIndex)
					end
				end
				if itemRestockingMerchants[i] == object.refId then
					if object.dialogueChoiceType == 3 then -- BARTER
						restockItems(pid, cellDescription, uniqueIndex)
					end
				end
			end

		end
	end
end)

customEventHooks.registerValidator("OnObjectMiscellaneous", function(eventStatus, pid, cellDescription, objects)
	if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then

		for uniqueIndex, object in pairs(objects) do

			if object.goldPool ~= nil and object.goldPool > 0 then
				for _,refId in pairs(restockingGoldMerchants) do
					if object.refId == refId then
						if initialMerchantGoldTracking[uniqueIndex] == nil then
							initialMerchantGoldTracking[uniqueIndex] = object.goldPool
						else
							fixGoldPool(pid, cellDescription, uniqueIndex)
						end
					end
				end
			end

    end
	end
end)

return customMerchantRestock
