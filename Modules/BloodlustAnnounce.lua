-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Bloodlust Announce", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Bloodlust Announce"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

local CreateFrame = _G["CreateFrame"]
local IsAddOnLoaded = _G["IsAddOnLoaded"]
local CombatLogGetCurrentEventInfo = _G["CombatLogGetCurrentEventInfo"]
local GetNumGroupMembers = _G["GetNumGroupMembers"]
local UnitPlayerOrPetInParty = _G["UnitPlayerOrPetInParty"]
local UnitPlayerOrPetInRaid = _G["UnitPlayerOrPetInRaid"]
local IsInGroup = _G["IsInGroup"]
local IsInRaid = _G["IsInRaid"]
local UnitName = _G["UnitName"]
local GetSpellLink = _G["GetSpellLink"]
local C_Timer_After = C_Timer.After

local Drums = {
	[146555] = true, 	-- Drums of Rage (MoP)
	[178207] = true, 	-- Drums of Fury (WoD)
	[230935] = true, 	-- Drums of the Mountain (Legion)
	[256740] = true, 	-- Drums of the Maelstrom (BfA)
}

local Bloodlust = {
	[2825] = true, 		-- Bloodlust (Horde Shaman)
	[32182] = true, 	-- Heroism (Alliance Shaman)
	[80353] = true, 	-- Time Warp (Mage)
	[272678] = true, 	-- Primal Rage (Hunter, cast by command pet)
}

local PetBL = {
	[264667] = true, 	-- Primal Rage (Hunter, cast from pet spellbook)
}

local db, options
local defaults = {
	global = {
		hidemessage = false,
	}
}

local scanTool = CreateFrame( "GameTooltip", "ScanTooltip", nil, "GameTooltipTemplate" )
scanTool:SetOwner( WorldFrame, "ANCHOR_NONE" )
local scanText = _G["ScanTooltipTextLeft2"]

local function getPetOwner(sourceName)
	scanTool:ClearLines()
	scanTool:SetUnit(sourceName)
	local ownerText = scanText:GetText()
	if not ownerText then return sourceName end
	local owner, _ = string.split("-'",ownerText)
	return owner
end

function Module:PLAYER_REGEN_DISABLED()
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function Module:COMBAT_LOG_EVENT_UNFILTERED()
	if IsAddOnLoaded("ElvUI_KlixUI") then return end
	local _, event, _, _, sourceName, _, _, _, destName, _, _, spellID, _ = CombatLogGetCurrentEventInfo()
	if event == "SPELL_CAST_SUCCESS" and GetNumGroupMembers() > 0 and (Drums[spellID] or Bloodlust[spellID] or PetBL[spellID]) and (UnitPlayerOrPetInParty(sourceName) or UnitPlayerOrPetInRaid(sourceName)) then
		local chatType = "PARTY"
		local isInstance, instanceType = IsInInstance()
		if isInstance and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or instanceType == "pvp" then
			chatType = "INSTANCE_CHAT"
		elseif IsInRaid() then
			chatType = "RAID"
		end
		if Drums[spellID] then
			SendChatMessage("BL/Hero used by: " .. UnitName(sourceName) .. " " .. GetSpellLink(spellID) .. " (25% haste)",chatType)
		elseif Bloodlust[spellID] then
			SendChatMessage("BL/Hero used by: " .. UnitName(sourceName) .. " " .. GetSpellLink(spellID) .. " (30% haste)",chatType)
		elseif PetBL[spellID] then
			SendChatMessage("BL/Hero used by: " .. getPetOwner(sourceName) .. " " .. GetSpellLink(spellID) .. " (30% haste)",chatType)
		end
	end
end

function Module:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
end

function Module:OnEnable()
	if IsAddOnLoaded("ElvUI_KlixUI") and not db.hidemessage then 
		C_Timer_After(0.75, function() ElvUI_ChatTweaks:Print(L["Bloodlust Announce is disabled, locate it under |cfff960d9KlixUI|r settings instead."]) end)
	else
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnDisable()
	self:UnregisterAllEvents()
end

function Module:GetOptions()
	if not options then
		options = {
			hidemessage = {
				order = 15,
				type = "toggle",
				name = L["Hide Compatibility Message"],
				desc = L["Hide the compatibility message in chat when KlixUI is installed."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Makes it easy to identify which person popped bloodlust/heroism."]
end
