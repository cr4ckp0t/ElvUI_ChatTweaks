-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpotx (US, Lightbringer)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Rare Announce", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Rare Announce"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

--[[
-- local api cache
local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit
local C_Map_GetPlayerMapPosition = C_Map.GetPlayerMapPosition
local GetPlayerMapPosition = GetPlayerMapPosition
local GetZoneText = GetZoneText
local SendChatMessage = SendChatMessage
local UnitAffectingCombat = UnitAffectingCombat
local UnitClassification = UnitClassification
local UnitExists = UnitExists
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsDead = UnitIsDead
local UnitName = UnitName

local ceil = math.ceil
local format = string.format
local tostring = tostring

local messageToSend = "<NAME> (<HEALTH>) is at <COORDS>, and <COMBAT>"
local healthString = "%s/%s %.2f"
local coordString = "%s %s"
local lastAnnounce
local db, options
local defaults = {
	global = {
		autoAnnounce = false,
	}
}

function FormatNumber(n)
    if n >= 10^6 then
        return format("%.2fm", n / 10^6)
    elseif n >= 10^3 then
        return format("%.2fk", n / 10^3)
    else
        return tostring(n)
    end
end

local function DecRound(num, decPlaces)
	return format("%." .. (decPlaces or 0) .. "f", num)
end

local function AnnounceRare()
	-- player target is a rare
	local tarName, tarCombat = UnitName("target"), UnitAffectingCombat("target")
	local tarHealth, tarHealthMax = UnitHealth("target"), UnitHealthMax("target")
	local tarHealthPercent = (tarHealth / tarHealthMax) * 100
	local tarPos = C_Map_GetPlayerMapPosition(C_Map_GetBestMapForUnit("player"), "player")

	-- fill in the wildcards
	local chatMsg = messageToSend:gsub("<NAME>", UnitName("target"))
	chatMsg = chatMsg:gsub("<HEALTH>", healthString:format(FormatNumber(tarHealth), FormatNumber(tarHealthMax), tarHealthPercent) .. "%%")
	chatMsg = chatMsg:gsub("<COORDS>", coordString:format(ceil(tarPos.x * 10000) / 100, ceil(tarPos.y * 10000) / 100))
	chatMsg = chatMsg:gsub("<COMBAT>", UnitAffectingCombat("target") and L["has been engaged!"] or L["has NOT been engaged!"])

	-- send the message
	SendChatMessage(chatMsg, "CHANNEL", "COMMON", 1)
end

function Module:PLAYER_TARGET_CHANGED()
	local zoneText = GetZoneText()
	local tarClass = UnitClassification("target")
		-- only do anything when the player is in mechagon or nazjatar
	if db.autoAnnounce and not self.msgSent and (zoneText:lower() == "mechagon" or zoneText:lower() == "nazjatar") then
		if UnitExists("target") and (tarClass == "rare" or tarClass == "rareelite") and not UnitIsDead("target") then
			-- announce the rare
			AnnounceRare()

			-- set the flag to throttle this and schedule a timer to disable it
			self.msgSent = true
			self.throttle = self:ScheduleTimer(function(self) self.msgSent = false end, 30)
		end
	end	
end]]

function Module:GetOptions()
	if not options then
		options = {
			getAddon = {
				type = "input",
				order = 17,
				width = "full",
				name = L["Get Anounce Rare on Curse/Twitch"],
				desc = L["I have split this off into its own addon, so ElvUI and ElvUI Chat Tweaks are not required. Copy the link in the text box to get the new addon."],
				get = function(info) return "https://www.curseforge.com/wow/addons/announce-rare" end,
				set = function(info, value) end,
			},
			--[[autoAnnounce = {
				type = "toggle",
				order = 17,
				name = L["Auto Announce"],
				desc = L["When you target a rare in Mechagon or Nazjatar, and it is alive, it will announce to general. There is a built in throttle to only send a message every 30 seconds."],
				get = function(info) return db.autoAnnounce end,
				set = function(info, value) db.autoAnnounce = value end,
			},]]
		}
	end
	return options
end

--[[
function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
	self.msgSent = false
end

function Module:OnEnable()
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterChatCommand("rare", function(args)
		
		local zoneText = GetZoneText()
		-- only do anything when the player is in mechagon or nazjatar
		if zoneText:lower() == "mechagon" or zoneText:lower() == "nazjatar" then
			local tarClass = UnitClassification("target")
			if UnitExists("target") and (tarClass == "rare" or tarClass == "rareelite") and not UnitIsDead("target") then
				AnnounceRare()
			elseif not UnitExists("target") then
				self:Print(L["You do not have a target."])
			elseif UnitIsDead("target") then
				self:Print(format(L["%s is already dead."], UnitName("target"))) 
			elseif (tarClass ~= "rare" and tarClass ~= "rareelite") then
				self:Print(format(L["%s is not a rare or you have killed it today."], UnitName("target")))
			end
		else
			self:Print(L["You must be in Mechagon or Nazjatar to use this command."])
		end
	end)
end

function Module:OnDisable()
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnregisterChatCommand("rare")
end
]]

function Module:Info()
	return L["Target the rare and then type |cff00ff00/rare|r to announce it in general chat."]
end