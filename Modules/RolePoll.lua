-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Role Poll Command", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Role Poll Command"]
Module.namespace = string.gsub(Module.name, " ", "")

function Module:OnEnable()
	self:RegisterChatCommand("role", function() InitiateRolePoll() end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("role")
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds the |cff00ff96/role|r command for initiating a role poll in raids."]
end