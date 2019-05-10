-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Channel Notice Filter", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Channel Notice Filter"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		joined = true,
		left = true,
		changed = true,
		throttle = true,
	}
}

local function FilterChannelNotices(self, event, message)
	if Module.debug then
		print(event, message)
	end

	if db.joined and message:find("YOU_JOINED") then
		return true
	elseif db.left and message:find("YOU_LEFT") then
		return true
	elseif db.changed and message:find("YOU_CHANGED") then
		return true
	elseif db.throttle and message:find("THROTTLED") then
		return true
	end
	return false
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", FilterChannelNotices)
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", FilterChannelNotices)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			join = {
				type = "toggle",
				order = 13,
				name = L["Joined Channel"],
				desc = L["Filter joined channel message."],
				get = function() return db.join end,
				set = function(_, value) db.join = value end,
			},
			left = {
				type = "toggle",
				order = 14,
				name = L["Left Channel"],
				desc = L["Filter left channel message."],
				get = function() return db.left end,
				set = function(_, value) db.left = value end,
			},
			changed = {
				type = "toggle",
				order = 15,
				name = L["Changed Channel"],
				desc = L["Filter changed channel message."],
				get = function() return db.changed end,
				set = function(_, value) db.changed = value end,
			},
			throttle = {
				type = "toggle",
				order = 16,
				name = L["Spam Throttle"],
				desc = L["Filter spam throttle notices."],
				get = function() return db.throttle end,
				set = function(_, value) db.throttle = value end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Filters the channel notices."]
end