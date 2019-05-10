-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Pet Battles", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local LibPetJournal = LibStub("LibPetJournal-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Pet Battles"]
Module.namespace = string.gsub(Module.name, " ", "")

local insert = table.insert
local concat = table.concat
local getn = table.getn

local db, options
local defaults = {
	global = {
		stableMaster = true,
		trackPets = true,
		colorNames = true,
		quality = {
			enable = true,
			tooltip = true,
			frame = "ChatFrame1",
		},
		battle = {
			enable = true,
			color = {r = 0.72, g = 0.63, b = 0.31},	-- tannish/yellowish
			frame = "ChatFrame3",
		},
		combat = {
			enable = true,
			color = {r = 0.09, g = 0.52, b = 0.82},	-- bluish
			frame = "ChatFrame11",
		},
	}
}

local sentZone = false
local battleMSG = ""
local combatMSG = ""
local frameString = "ChatFrame%d"
local frameList = L["Chat Frame %d"]
local stableMasterString = MINIMAP_TRACKING_STABLEMASTER
local trackPetsString = L["Track Pets"]	-- i wasnt able to find this in globalstrings.lua

local function GetTrackingIndex(tracker)
	for i = 1, GetNumTrackingTypes() do
		local name, _, active, _ = GetTrackingInfo(i)
		if name == tracker then
			return i
		end
	end
end

local function IsTrackingActive(tracker)
	for i = 1, GetNumTrackingTypes() do
		local name, _, active, _ = GetTrackingInfo(i)
		if name == tracker then
			return active and true or false
		end
	end
	return false
end

local function PetBattleFilter(self, event, message)
	if not db.battle.enable or not message or not _G[db.battle.frame] then return false end
	if Module.debug then
		_G[db.battle.frame]:AddMessage("I'm using this ChatFrame.")
		print(message)
	end
	
	if message ~= battleMSG then	-- prevent duplicate messages
		_G[db.battle.frame]:AddMessage(message, db.battle.color.r, db.battle.color.g, db.battle.color.b)
		battleMSG = message
	end
	return true
end

local function PetCombatFilter(self, event, message)
	if not db.combat.enable or not message or not _G[db.combat.frame] then return false end
	if Module.debug then
		_G[db.combat.frame]:AddMessage("I'm using this ChatFrame.")
		print(message)
	end
	if message ~= combatMSG then
		_G[db.combat.frame]:AddMessage(message, db.combat.color.r, db.combat.color.g, db.combat.color.b)
		combatMSG = message
	end
	return true
end

local function GetPetQualities(name)
	local pets, petString = {}, "|c%s%s|r |cffffffff(%d)|r"
	for i, id in LibPetJournal:IteratePetIDs() do
		local _, _, level, _, _, _, petName, _, _, _, _, _, _, _, _, _ = C_PetJournal.GetPetInfoByPetID(id)
		if petName == name then
			local _, _, _, _, quality = C_PetJournal.GetPetStats(id)
			local _, _, _, hex = GetItemQualityColor(quality - 1)
 			insert(pets, petString:format(hex, _G[("ITEM_QUALITY%d_DESC"):format(quality - 1)], level))
		end
	end
	if #pets == 0 then
		return false
	else
		return concat(pets, ", ")
	end
end

local function GetHighestQuality(species)
	local highest
	for i, id in LibPetJournal:IteratePetIDs() do
		local speciesID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _ = C_PetJournal.GetPetInfoByPetID(id)
		if speciesID == species then
			local _, _, _, _, quality = C_PetJournal.GetPetStats(id)
			if not highest or highest < quality then
				highest = quality
			end
		end
	end
	return not highest and false or highest
end



function Module:HookTooltip(tooltip)
	if not db.quality.enable or not db.quality.tooltip or not UnitIsWildBattlePet("mouseover") then
		return
	else
		local name, unit = tooltip:GetUnit()
		if not unit then
			return
		else
			local owned = GetPetQualities(name)
			if owned == false or owned:gsub(" ", "") == "" then
				tooltip:AddLine(L["|cffff9000Not in Pet Journal|r"])
			else
				tooltip:AddLine((L["|cffff9000Pet Journal:|r %s"]):format(owned))
			end
		end
	end
end

function Module:ColorNames(frame)
	if not db.colorNames or not frame.petOwner or not frame.petIndex or not frame.Name then return end
	local quality = C_PetBattles.GetBreedQuality(frame.petOwner, frame.petIndex) - 1
	local _, _, _, hex = GetItemQualityColor(quality)
	local petName = C_PetBattles.GetName(frame.petOwner, frame.petIndex)
	if frame.petOwner == 1 and petName then
		frame.Name:SetText(("|c%s%s|r"):format(hex, petName))
	elseif frame.petOwner == 2 and petName then
		if C_PetBattles.IsWildBattle(frame.petOwner, frame.PetIndex) then
			local petString = "|c%s%s|r (|c%s%s|r)"
			-- this only applies to wild pet battles, pvp ones are ignored
			if (quality + 1) ~= 5 and (quality + 1) ~= 6 then
				local species = C_PetBattles.GetPetSpeciesID(frame.petOwner, frame.petIndex)
				local highest = GetHighestQuality(species)
				if not highest then
					frame.Name:SetText(petString:format(hex, petName, "ffccff00", L["Not Owned"]))
				else
					frame.Name:SetText(petString:format(hex, petName, select(4, GetItemQualityColor(highest - 1)), _G[("ITEM_QUALITY%d_DESC"):format(highest - 1)]))
				end
			else
				-- legendary and epic pets are not capturable
				frame.Name:SetText(petString:format(hex, petName, "ffccff00", L["Not Capturable"]))
			end
		else
			frame.Name:SetText(("|c%s%s|r"):format(hex, petName))
		end
	end
end

function Module:PET_BATTLE_OPENING_DONE()
	local chatFrame = _G[db.quality.frame]
	-- this only applies to wild pet battles
	if db.quality.enable and C_PetBattles.IsWildBattle(2, i) then
		local lineString = "|cffffff00Pet #%d:|r %s|Hbattlepet:%s:%s:%s:%s:%s:%s:|h[%s]|h|r |cffffffff(%d), %s:|r %s"
		local notCapturable = "|cffffff00Pet #%d:|r %s|Hbattlepet:%s:%s:%s:%s:%s:%s:|h[%s]|h|r |cffffffff(%d), |cffff5a00%s|r"
		chatFrame:AddMessage(L["|cFF5cb4f8Pet Battle - Tale of the Tape|r"])
		for i = 1, C_PetBattles.GetNumPets(2) do
			-- get pet info for the link
			local quality = C_PetBattles.GetBreedQuality(2, i)
			local species = C_PetBattles.GetPetSpeciesID(2, i)
			local level = C_PetBattles.GetLevel(2, i)
			local health = C_PetBattles.GetMaxHealth(2, i)
			local power = C_PetBattles.GetPower(2, i)
			local speed = C_PetBattles.GetSpeed(2, i)
			
			if quality ~= 5 and quality ~= 6 then
				local highest = GetHighestQuality(species)
				local extra = ""
				if not highest then
					extra = L["|cFFccff00Not Owned|r"]
				else
					local _, _, _, hex = GetItemQualityColor(highest - 1)
					extra = ("|c%s%s|r"):format(hex, _G[("ITEM_QUALITY%d_DESC"):format(highest - 1)])
					-- now check for an upgrade
					if highest < quality then
						extra = extra .. L[" |cFFff5a00(Upgrade)|r"]
					end
				end
				chatFrame:AddMessage(lineString:format(i, ITEM_QUALITY_COLORS[quality - 1].hex, species, level, quality, health, power, speed, C_PetBattles.GetName(2, i), level, L["Yours"], extra))
			else
				-- epic and legendary pets can't be captured
				chatFrame:AddMessage(notCapturable:format(i, ITEM_QUALITY_COLORS[quality - 1].hex, species, level, quality, health, power, speed, C_PetBattles.GetName(2, i), level, L["Not Capturable"]))
			end
		end
	end
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PET_BATTLE_INFO", PetBattleFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PET_BATTLE_COMBAT_LOG", PetCombatFilter)
	
	-- stable master tracking
	if db.stableMaster and not IsTrackingActive(stableMasterString) then
		SetTracking(GetTrackingIndex(stableMasterString), true)
	end
	
	-- pet tracking
	if db.trackPets and not IsTrackingActive(trackPetsString) then
		SetTracking(GetTrackingIndex(trackPetsString), true)
	end
	
	-- hooks for pet battle tweaks
	self:HookScript(GameTooltip, "OnTooltipSetUnit", "HookTooltip")
	self:SecureHook("PetBattleUnitFrame_UpdateDisplay", "ColorNames")
	self:RegisterEvent("PET_BATTLE_OPENING_DONE")
	
	-- disable arkinventory's version
	if IsAddOnLoaded("ArkInventory") then
		self.arkInventory = ArkInventory.db.global.option.message.battlepet.opponent
		ArkInventory.db.global.option.message.battlepet.opponent = false
	end
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PET_BATTLE_INFO", PetBattleFilter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PET_BATTLE_COMBAT_LOG", PetCombatFilter)
	
	-- stable master tracking
	if db.stableMaster and IsTrackingActive(stableMasterString) then
		SetTracking(GetTrackingIndex(stableMasterString), false)
	end
	
	-- pet tracking
	if db.trackPets and IsTrackingActive(trackPetsString) then
		SetTracking(GetTrackingIndex(trackPetsString), false)
	end
	
	self:Unhook(GameTooltip, "OnTooltipSetUnit")
	self:Unhook("PetBattleUnitFrame_UpdateDisplay")
	self:UnregisterEvent("PET_BATTLE_OPENING_DONE")
	
	-- set it back to it's previous value
	if IsAddOnLoaded("ArkInventory") then
		ArkInventory.db.global.option.message.battlepet.opponent = self.arkInventory
		self.arkInventory = nil
	end
	
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			stableMaster = {
				type = "toggle",
				order = 13,
				name = L["Track Stable Masters"],
				desc = L["Automatically enable tracking of Stable Masters to help you revive and/or heal your pets."],
				get = function() return db.stableMaster end,
				set = function(_, value) db.stableMaster = value; SetTracking(GetTrackingIndex(stableMasterString), value); end,
			},
			trackPets = {
				type = "toggle",
				order = 14,
				name = L["Track Pets"],
				desc = L["Automatically enable tracking of pets for battles."],
				get = function() return db.trackPets end,
				set = function(_, value) db.trackPets = value; SetTracking(GetTrackingIndex(trackPetsString), value); end,
			},
			colorNames = {
				type = "toggle",
				order = 15,
				name = L["Color Name"],
				desc = L["Color the name of the pets during a pet battle relative to their rarity.  If you have the pet you're currently battling it will also add the quality of the pet you have in your journal."],
				get = function() return db.colorNames end,
				set = function(_, value) db.colorNames = value end,
			},
			quality = {
				type = "group",
				guiInline = true,
				order = 97,
				name = L["Quality Notification"],
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Toggle the pet quality notifications when you join a wild pet battle."],
						get = function() return db.quality.enable end,
						set = function(_, value) db.quality.enable = value end,
					},
					tooltip = {
						type = "toggle",
						order = 2,
						name = L["Hook Tooltip"],
						desc = L["Hook the GameTooltip to add information to pet tooltips."],
						disabled = function() return not db.quality.enable end,
						get = function() return db.quality.tooltip end,
						set = function(_, value) db.quality.tooltip = value end,
					},
					frame = {
						type = "select",
						order = 3,
						name = L["Output Frame"],
						desc = L["Chat frame to send the messages to."],
						disabled = function() return not db.quality.enable end,
						values = function()
							local frames = {}
							for i = 1, 18 do
								if _G[frameString:format(i)] then
									frames[frameString:format(i)] = frameList:format(i)
								end
							end
							return frames
						end,
						get = function() return db.quality.frame end,
						set = function(_, value) db.quality.frame = value end,
					},
				},
			},
			battle = {
				type = "group",
				guiInline = true,
				order = 99,
				name = L["Pet Battle Info"],
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Toggle coloring and changing of the chat frame for pet battle info messages."],
						get = function() return db.battle.enable end,
						set = function(_, value) db.battle.enable = value end,
					},
					color = {
						type = "color",
						order = 2,
						name = L["Message Color"],
						disabled = function() return not db.battle.enable end,
						get = function() return db.battle.color.r, db.battle.color.g, db.battle.color.b end,
						set = function(_, r, g, b) db.battle.color.r = r; db.battle.color.g = g; db.battle.color.b = b; end,
					},
					frame = {
						type = "select",
						order = 3,
						name = L["Output Frame"],
						desc = L["Chat frame to route the messages to."],
						disabled = function() return not db.battle.enable end,
						values = function()
							local frames = {}
							for i = 1, 18 do
								if _G[frameString:format(i)] then
									frames[frameString:format(i)] = frameList:format(i)
								end
							end
							return frames
						end,
						get = function() return db.battle.frame end,
						set = function(_, value) db.battle.frame = value end,
					},
				},
			},
			combat = {
				type = "group",
				guiInline = true,
				order = 100,
				name = L["Pet Combat Log"],
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Toggle coloring and change of the chat frame for pet combat log messages."],
						get = function() return db.combat.enable end,
						set = function(_, value) db.combat.enable = value end,
					},
					color = {
						type = "color",
						order = 2,
						name = L["Message Color"],
						disabled = function() return not db.combat.enable end,
						get = function() return db.combat.color.r, db.combat.color.g, db.combat.color.b end,
						set = function(_, r, g, b) db.combat.color.r = r; db.combat.color.g = g; db.combat.color.b = b; end,
					},
					frame = {
						type = "select",
						order = 3,
						name = L["Output Frame"],
						desc = L["Chat frame to route the messages to."],
						disabled = function() return not db.combat.enable end,
						values = function()
							local frames = {}
							for i = 1, 18 do
								if _G[frameString:format(i)] then
									frames[frameString:format(i)] = frameList:format(i)
								end
							end
							return frames
						end,
						get = function() return db.combat.frame end,
						set = function(_, value) db.combat.frame = value end,
					},
				},
			},
		}
	end
	return options
end

function Module:Info()
	return L["Allows you to color the pet battle info messages, and determine which chat frame to send them to.\n\nI am aware that some of the features of this module don't really pertain to the chat, but I couldn't really justify an entirely new addon.  So I just snuck them into here."]
end