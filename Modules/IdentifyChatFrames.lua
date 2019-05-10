-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Identify Chat Frames", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Identify Chat Frames"]
Module.namespace = string.gsub(Module.name, " ", "")

local function IdentifyChatFrames()
	local frameString = "ChatFrame%d"
	for i = 1, 18 do
		local frame = _G[frameString:format(i)]
		if frame then
			frame:AddMessage((L["I am |cff1784d1%s|r"]):format(frameString:format(i)), 1.0, 1.0, 0)
		end
	end
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnEnable()
	self:RegisterChatCommand("chatframes", function() IdentifyChatFrames() end)
	self:RegisterChatCommand("cf", function() IdentifyChatFrames() end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("chatframes")
	self:UnregisterChatCommand("cf")
end

function Module:Info()
	return L["Adds chat commands |cff1784d1/chatframes|r and |cff1784d1/cf|r to help you identify the chat frames and their numbers."]
end