-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpotx (US, Lightbringer)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Semi-Auto Congratulate", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Semi-Auto Congratulate"]
Module.namespace = string.gsub(Module.name, " ", "")

local GetAchievementLink = _G["GetAchievementLink"]
local UnitIsAFK = _G["UnitIsAFK"]
local UnitIsDND = _G["UnitIsDND"]
local UnitName = _G["UnitName"]
local UnitInParty = _G["UnitInParty"]
local UnitInRaid = _G["UnitInRaid"]

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Prints a link you can click to congratulate when someone obtains an achievement."]
end