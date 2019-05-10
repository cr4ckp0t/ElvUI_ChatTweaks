-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Emote Filter", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Emote Filter"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		standard = true,
		custom = true,
	}
}

local function FilterEmote(self, event, message, ...)
	-- custom emotes
	if event == "CHAT_MSG_EMOTE" and db.custom == true then
		if Module.debug then
			Module:Print((L["Custom Emote: |cffffff00%s|r"]):format(message))
		end
		
		return true
		
	-- standard emotes
	elseif event == "CHAT_MSG_TEXT_EMOTE" and db.standard == true then
		if Module.debug then
			Module:Print((L["Standard Emote: |cffffff00%s|r"]):format(message))
		end
		return true
	else
		return false
	end
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", FilterEmote)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", FilterEmote)
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_EMOTE", FilterEmote)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_TEXT_EMOTE", FilterEmote)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging	
end

function Module:Info()
	return L["Filter standard and/or custom emotes."]
end

function Module:GetOptions()
	if not options then
		options = {
			standard = {
				type = "toggle",
				order = 13,
				name = L["Standard Emotes"],
				desc = L["Enable to filter standard emotes such as |cff00ff00/dance|r or |cff00ff00/flirt|r."],
				get = function() return db.standard end,
				set = function(_, value) db.standard = value end,
			},
			custom = {
				type = "toggle",
				order = 14,
				name = L["Custom Emotes"],
				desc = L["Enable to filter custom emotes made using |cff00ff00/emote|r or |cff00ff00/e|r."],
				get = function() return db.custom end,
				set = function(_, value) db.custom = value end,
			},
		}
	end
	return options
end