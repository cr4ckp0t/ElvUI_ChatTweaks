-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Ready Check Command", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Ready Check Command"]
Module.namespace = string.gsub(Module.name, " ", "")

function Module:OnEnable()
	self:RegisterChatCommand("rc", function() DoReadyCheck() end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("rc")
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r."]
end