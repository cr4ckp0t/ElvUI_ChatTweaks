-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local E, _, _, _, _, _ = unpack(ElvUI)
local Module = ElvUI_ChatTweaks:NewModule("Channel Invite Spam", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Channel Invite Spam"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		decline = true,
		ignore = true,
		logging = true,
		lifetime = 60,
		senders = {},
	}
}

local function NoticeFilter(self, event, ...)
	if select(1, ...) == "INVITE" then
		return true, ...
	else
		return false, ...
	end
end

function Module:ProcessChannelInvite(event, channel, sender)
	if db.senders[sender] ~= nil then
		if db.decline then
			DeclineInvite(channel)
		end
		return
	end
	
	-- ignore them if they have sent multiple invites
	if db.ignore then
		AddIgnore(sender)
		db.senders[sender] = true
	end
end

function Module:CleanUp()
	if #db.senders == 0 then return end
	for key, _ in pairs(db.senders) do
		DelIgnore(key)
		db.senders[key] = nil
	end
end

function Module:OnEnable()
	self.log = ElvUI_ChatTweaks:GetModule("Spam Log")
	-- start the timer to keep the database clean
	self.timer = self:ScheduleRepeatingTimer("CleanUp", db.lifetime)
	
	-- register necessary events
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "CleanUp")
	self:RegisterEvent("CHANNEL_INVITE_REQUEST", "ProcessChannelInvite")
	
	-- now unregister ui parent's events so we can control them
	if UIParent ~= nil then
		UIParent:UnregisterEvent("CHANNEL_INVITE_REQUEST")
	end
	
	-- elvui has one too
	if E.UIParent ~= nil then
		E.UIParent:UnregisterEvent("CHANNEL_INVITE_REQUEST")
	end
	
	-- finally message event filters
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", NoticeFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE_USER", NoticeFilter)
end

function Module:OnDisable()
	-- undo our changes
	self:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
	self:UnregisterEvent("CHANNEL_INVITE_REQUEST")
	
	if UIParent ~= nil then
		UIParent:RegisterEvent("CHANNEL_INVITE_REQUEST")
	end
	
	if E.UIParent ~= nil then
		E.UIParent:RegisterEvent("CHANNEL_INVITE_REQUEST")
	end
	
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", NoticeFilter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE_USER", NoticeFilter)
	
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Allows you to block chat channel invites and ignore the person who sent them.  Useful for preventing spam."]
end

function Module:GetDefaults()
	return defaults
end

function Module:GetOptions()
	if not options then
		options = {
			decline = {
				type = "toggle",
				order = 13,
				name = L["Decline Invite"],
				desc = L["Automatically decline any channel invites."],
				get = function() return db.decline end,
				set = function(_, value) db.decline = value end,
			},
			ignore = {
				type = "toggle",
				order = 14,
				name = L["Ignore Sender"],
				desc = L["If a person sends you multiple channel invites this will automatically put them on your ignore list."],
				get = function() return db.ignore end,
				set = function(_, value) db.ignore = value end,
			},
			lifetime = {
				type = "range",
				order = 15,
				name = L["Ignore Lifetime"],
				desc = L["Time, in seconds, to run the clean up to keep your ignore list clean."],
				min = 30, max = 600, step = 10,
				get = function() return db.lifetime end,
				set = function(_, value) 
					db.lifetime = value
					-- update the timer
					if self.timer then
						self:CancelTimer(self.timer)
						self.timer = nil
					end
					self.timer = self:ScheduleRepeatingTimer("CleanUp", db.lifetime)
				end,
			},
			logging = {
				type = "toggle",
				order = 16,
				name = L["Enable Logging"],
				desc = L["Toggle logging any actions taken to the Spam Log module."],
				get = function() return db.logging end,
				set = function(_, value) db.logging = value end,
			},
		}
	end
	return options
end