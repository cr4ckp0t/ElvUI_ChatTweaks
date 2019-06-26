-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpotx (US, Lightbringer)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Clear Chat Commands", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Clear Chat Commands"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local clearCMD = L["|cff00ff00%s|r or |cff00ff00%s|r %s"]

function Module:ClearChat(frame)
	local vartype = type(frame)
	local type = frame:GetObjectType() or nil
	
	if type == "Frame" and frame.Clear then
		frame:Clear()
	end
end

function Module:ClearAllChats()
	for i = 1, NUM_CHAT_WINDOWS do
		self:ClearChat(_G[format("ChatFrame%d", i)])
	end
	for _, frame in ipairs(self.TempChatFrames) do
		self:ClearChat(_G[frame])
	end
end

function Module:OnEnable()
	self:RegisterChatCommand("clear", function() self:ClearChat(SELECTED_CHAT_FRAME) end)
	self:RegisterChatCommand("clr",	function() self:ClearChat(SELECTED_CHAT_FRAME) end)
	self:RegisterChatCommand("clearall", function() self:ClearAllChats() end)
	self:RegisterChatCommand("clrall", function() self:ClearAllChats() end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("clear")
	self:UnregisterChatCommand("clr")
	self:UnregisterChatCommand("clearall")
	self:UnregisterChatCommand("clrall")
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds chat commands to clear the chat windows.\n\n"] .. format(clearCMD, "/clear", "/clr", L["Clear current chat."]) .. "\n" .. format(clearCMD, "/clearall", "/clrall", L["Clear all chat windows."])
end