-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("AFK/DND Filter", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["AFK/DND Filter"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db, options
local defaults = {
	global = {
		afk = true,
		dnd = true,
	}
}

local function FilterMessages(self, event, message)
	if Module.debug then Module:Print(message) end
	if event == "CHAT_MSG_AFK" and db.afk == true then return true end
	if event == "CHAT_MSG_DND" and db.dnd == true then return true end
	return false
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", FilterMessages)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", FilterMessages)
	
	if IsAddOnLoaded("WIM") then
		if db.afk == true then WIM.modules.WhisperEngine:UnregisterChatEvent("CHAT_MSG_AFK") end
		if db.dnd == true then WIM.modules.WhisperEngine:UnregisterChatEvent("CHAT_MSG_DND") end
	end
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_AFK", FilterMessages)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_DND", FilterMessages)
	
	if IsAddOnLoaded("WIM") then
		if db.afk == true then WIM.modules.WhisperEngine:RegisterChatEvent("CHAT_MSG_AFK") end
		if db.dnd == true then WIM.modules.WhisperEngine:RegisterChatEvent("CHAT_MSG_DND") end
	end
	
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Filter AFK/DND auto responses.  This module is compatible with WIM."]
end

function Module:GetOptions()
	if not options then
		options = {
			afk = {
				type = "toggle",
				order = 13,
				name = L["AFK Messages"],
				desc = L["Filter AFK messages."],
				get = function() return db.afk end,
				set = function(_, value) 
					db.afk = value
					if db.afk == true then
						ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", FilterMessages)
						if IsAddOnLoaded("WIM") then WIM.modules.WhisperEngine:UnregisterChatEvent("CHAT_MSG_AFK") end
					else
						ChatFrame_RemoveMessageEventFilter("CHAT_MSG_AFK", FilterMessages)
						if IsAddOnLoaded("WIM") then WIM.modules.WhisperEngine:RegisterChatEvent("CHAT_MSG_AFK") end
					end
				end,
			},
			dnd = {
				type = "toggle",
				order = 14,
				name = L["DND Messages"],
				desc = L["Filter DND messages."],
				get = function() return db.dnd end,
				set = function(_, value)
					db.dnd = value
					if db.dnd == true then
						ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", FilterMessages)
						if IsAddOnLoaded("WIM") then WIM.modules.WhisperEngine:UnregisterChatEvent("CHAT_MSG_DND") end
					else
						ChatFrame_RemoveMessageEventFilter("CHAT_MSG_DND", FilterMessages)
						if IsAddOnLoaded("WIM") then WIM.modules.WhisperEngine:RegisterChatEvent("CHAT_MSG_DND") end
					end
				end,
			}
		}
	end
	return options
end