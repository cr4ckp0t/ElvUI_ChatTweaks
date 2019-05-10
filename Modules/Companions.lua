-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Companions", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local LibPetJournal = LibStub("LibPetJournal-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Companions"]

local db, defaults = {}, {
	global = {
		ppm = 25,
		zone = {
			enable = true,
			throttle = 10,
			frame = "ChatFrame1",
			percent = "owned",
			filter = "none",		
		},
	}
}

local sentZone = false
local frameString = "ChatFrame%d"
local frameList = L["Chat Frame %d"]
local petFamilies = {}

function Module:SendZoneList()
	-- this is affected by the filters being used, so we must
	-- take that into account
	local percentString = " |cffffff00(%d/%d %d%%)|r"
	local output, found = "", {}
	local zone = GetZoneText()
	local owned, unowned, total = 0, 0, 0
	
	-- clear the filters
	LibPetJournal:ClearFilters()
	
	for i = 1, C_PetJournal.GetNumPets(false) do
		local id, speciesID, _, _, _, _, _, name, _, _, _, tooltip, _, _, _, _, _ = C_PetJournal.GetPetInfoByIndex(i)
		if id and speciesID and name and tooltip and tooltip:find(zone) and not found[name] then
			if C_PetJournal.GetPetInfoByPetID(id) ~= nil and (db.zone.filter == "none" or db.zone.filter == "owned") then
				-- you have the pet
				output = output .. C_PetJournal.GetBattlePetLink(id) .. ", "
				owned = owned + 1
			elseif db.zone.filter == "none" or db.zone.filter == "unowned" then
				-- you dont have it yet
				output = output .. name .. ", "
				found[name] = true	-- to prevent duplicates
				unowned = unowned + 1
			end
			total = total + 1
		end
	end
	
	-- put the filters back
	LibPetJournal:RestoreFilters()
	
	-- now print
	if output ~= "" and _G[db.zone.frame] then
		-- calculate the percentage
		local percent = db.zone.percent ~= "none" and percentString:format(db.zone.percent == "owned" and owned or unowned, total, math.ceil((db.zone.percent == "owned" and owned or unowned) / total * 100)) or ""
		_G[db.zone.frame]:AddMessage(("%s%s%s:|r %s"):format(ElvUI_ChatTweaks.hexColor, zone, percent or "", output:sub(1, -2)))
	end
end

-- based on functionality of petbattledump by azilroka
function Module:ZONE_CHANGED_NEW_AREA()
	if not db.zone.enable or sentZone == true then return end
	 
	-- first send the zone list
	self:SendZoneList()
	
	-- then set the throttle, if they chose to
	if db.zone.throttle > 0 then
		sentZone = true
		self.stopTimer = self:ScheduleTimer(function() sentZone = false end, db.zone.throttle)
	end
end

function Module:PetChatCommand(args)
	local action, part, filter = self:GetArgs(args, 3)
	local total, owned = C_PetJournal.GetNumPets(false)
	
	if action == "unique" then
		-- determine how many unique pets
		local count, pets = 0, {}
		for _, id in LibPetJournal:IteratePetIDs() do
			local species = C_PetJournal.GetPetInfoByPetID(id)
			if not pets[species] then
				count = count + 1
				pets[species] = species
			end
		end
		-- then print it
		self:Print((L["You have %s%d|r unique pets."]):format(ElvUI_ChatTweaks.hexColor, count))
		
	elseif action == "duplicates" then
		local count, pets = 0, {}
		for _, id in LibPetJournal:IteratePetIDs() do
			local species = C_PetJournal.GetPetInfoByPetID(id)
			if not pets[species] then
				pets[species] = species
			else
				count = count + 1
			end
		end
		self:Print((L["You have %s%d|r duplicate pets."]):format(ElvUI_ChatTweaks.hexColor, count))
		
	elseif action == "unowned" then
		local count = 0
		for i = 1, total do
			local _, _, isOwned, _, _, _, _, _, _, _ = C_PetJournal.GetPetInfoByIndex(i, false)
			if not isOwned then
				count = count + 1
			end
		end
		self:Print((L["You are missing %s%d|r pets."]):format(ElvUI_ChatTweaks.hexColor, count))
	
	else -- print overall stats
		local unique, dupes, totalPets = 0, 0 ,0
		local pets = {}
		for _, id in LibPetJournal:IteratePetIDs() do
			local species = C_PetJournal.GetPetInfoByPetID(id)
			if not pets[species] then
				unique = unique + 1
				pets[species] = species
			else
				dupes = dupes + 1
			end
			totalPets = totalPets + 1
		end
		self:Print((L["You have %s%d (%d unique, %d duplicates)|r pets."]):format(ElvUI_ChatTweaks.hexColor, totalPets, unique, dupes))
	end
end

function Module:MountChatCommand(args)
	self:Print((L["You have %s%d|r mounts."]):format(ElvUI_ChatTweaks.hexColor, GetNumCompanions("MOUNT")))
end

function Module:OnEnable()
	self:RegisterChatCommand("pets", "PetChatCommand")
	self:RegisterChatCommand("mounts", "MountChatCommand")
	self:RegisterChatCommand("zonelist", "SendZoneList")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
end

function Module:OnDisable()
	self:UnregisterChatCommand("pets")
	self:UnregisterChatCommand("mounts")
	self:UnregisterChatCommand("zonelist")
	self:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace("Companions", defaults)
	db = self.db.global
	db.global = self.db.global
	Module.debug = ElvUI_ChatTweaks.db.global.debugging
	
	-- fill in the pet families w/ the localized strings
	for i = 1, 10 do
		if _G[("BATTLE_PET_NAME_%d"):format(i)] then
			local family = _G[("BATTLE_PET_NAME_%d"):format(i)]:lower()
			petFamilies[family] = i
		end
	end
end

function Module:GetOptions()
	if not options then
		options = {
			ppm = {
				type = "range",
				order = 13,
				name = L["Pets Per Line"],
				desc = L["How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command."],
				get = function() return db.ppm end,
				set = function(_, value) db.ppm = value end,
				min = 1, max = 50, step = 1, bigStep = 5,
			},
			zone = {
				type = "group",
				guiInline = true,
				order = 98,
				name = L["Zone List"],
				args = {
					about = {
						type = "description",
						order = 1,
						width = "full",
						name = L["Enabling this will send a message to your chat whenever you change a zone with a list of the Battle Pets that are obtainable in the zone.  You have the option to filter them based on whether or not you own them.  This will also add the chat command |cff00ff96/zonelist|r to send the list whenever.  Even if you disable this the chat commands will still work."],
					},
					enable = {
						type = "toggle",
						order = 2,
						name = L["Enable"],
						desc = L["Toggle the pet list message when you enter a different zone."],
						get = function() return db.zone.enable end,
						set = function(_, value) db.zone.enable = value end,
					},
					throttle = {
						type = "range",
						order = 3,
						name = L["Throttle Time"],
						desc = L["Time, in seconds, to throttle the zone list to prevent any spam."],
						disabled = function() return not db.zone.enable end,
						get = function() return db.zone.throttle end,
						set = function(_, value)
							db.zone.throttle = value
							-- cancel a timer if it's running, and reset the throttle
							if Module.stopTimer then
								Module:CancelTimer(Module.stopTimer, true)
								sentZone = false
							end
						end,
						min = 0, max = 30, step = 1, bigStep = 3,
					},
					frame = {
						type = "select",
						order = 4,
						name = L["Output Frame"],
						desc = L["Chat frame to send the list to."],
						values = function()
							local frames = {}
							for i = 1, 18 do
								if _G[frameString:format(i)] then
									frames[frameString:format(i)] = frameList:format(i)
								end
							end
							return frames
						end,
						get = function() return db.zone.frame end,
						set = function(_, value) db.zone.frame = value end,
					},
					percent = {
						type = "select",
						style = "radio",
						order = 5,
						name = L["Add Percentage"],
						desc = L["Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it."],
						values = {
							["none"] = L["Disabled"],
							["owned"] = L["% Owned"],
							["unowned"] = L["% Unowned"],
						},
						get = function() return db.zone.percent end,
						set = function(_, value) db.zone.percent = value end,
					},
					filter = {
						type = "select",
						style = "radio",
						order = 6,
						name = L["Filter Pets"],
						desc = L["Select an option if you want the zone list to only contain pets you own or do not own."],
						values = {
							["none"] = L["No Filter"],
							["owned"] = L["Owned Only"],
							["unowned"] = L["Unowned Only"],
						},
						get = function() return db.zone.filter end,
						set = function(_, value) db.zone.filter = value end,
					},
				},
			},		
		}
	end
	return options
end

function Module:Info()
	return L["Adds the chat commands |cff00ff96/zonelist|r, |cff00ff96/pets|r and |cff00ff96/mounts|r to provide information about your mounts and pets."]
end