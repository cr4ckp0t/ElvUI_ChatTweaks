-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Automatic Chat Logging", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Automatic Chat Logging"]
Module.namespace = string.gsub(Module.name, " ", "")

function Module:OnEnable()
	self.isLogging = LoggingChat()
	if not self.isLogging then
		LoggingChat(true)
	end
end

function Module:OnDisable()
	if not self.isLogging then
		LoggingChat(false)
	end
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Automatically enables chat logging."]
end