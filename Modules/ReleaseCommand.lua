-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpotx (US, Lightbringer)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Release Command", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Release Command"]
Module.namespace = string.gsub(Module.name, " ", "")

local RepopMe = _G["RepopMe"]

function Module:OnEnable()
	self:RegisterChatCommand("release", function() RepopMe() end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("release")
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears."]
end