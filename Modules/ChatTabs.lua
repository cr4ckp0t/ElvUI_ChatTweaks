-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Chat Tabs", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Chat Tabs"]
Module.namespace = string.gsub(Module.name, " ", "")

local channels = {
	["whisper"] = "WHISPER",
	["guild"] = "GUILD",
	["officer"] = "OFFICER",
	["raid"] = "RAID",
	["raidLeader"] = "RAID_LEADER",
	["party"] = "PARTY",
	["partyLeader"] = "PARTY_LEADER",
	["instance"] = "INSTANCE_CHAT",
	["instanceLeader"] = "INSTANCE_CHAT_LEADER",
	["bnWhisper"] = "BN_WHISPER",
	["bnConversation"] = "BN_CONVERSATION",
	["channel"] = "CHANNEL",
}

local db, options
local defaults = {
	global = {
		tabs = {
			["whisper"] = true,
			["guild"] = false,
			["officer"] = false,
			["party"] = false,
			["partyLeader"] = false,
			["raid"] = false,
			["raidLeader"] = false,
			["instance"] = false,
			["instanceLeader"] = false,
			["bnWhisper"] = true,
			["bnConversation"] = true,
			["channel"] = false,
		},
		general = {
			["whisper"] = true,
			["guild"] = false,
			["officer"] = false,
			["party"] = false,
			["partyLeader"] = false,
			["raid"] = false,
			["raidLeader"] = false,
			["instance"] = false,
			["instanceLeader"] = false,
			["bnWhisper"] = true,
			["bnConversation"] = true,
			["channel"] = false,
		},
	}
}

function Module:UpdateChannels()
	-- loop the db and setup flashing
	for index, value in pairs(db.tabs) do
		local channel = channels[index]
		if channel and ChatTypeInfo[channel] then
			ChatTypeInfo[channel].flashTab = value
		end
	end
	
	-- general tab has its own
	for index, value in pairs(db.general) do
		local channel = channels[index]
		if channel and ChatTypeInfo[channel] then
			ChatTypeInfo[channel].flashTabOnGeneral = value
		end
	end
end


function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
	-- update the channels
	self:UpdateChannels()
end

function Module:GetOptions()
	if not options then
		options = {
			tabs = {
				type = "multiselect",
				order = 13,
				name = L["Channels"],
				desc = L["Select which channels to flash when a message is received."],
				values = {
					["whisper"] = L["Whisper"],
					["guild"] = L["Guild"],
					["officer"] = L["Officer"],
					["party"] = L["Party"],
					["partyLeader"] = L["Party Leader"],
					["raid"] = L["Raid"],
					["raidLeader"] = L["Raid Leader"],
					["instance"] = L["Instance"],
					["instanceLeader"] = L["Instance Leader"],
					["bnWhisper"] = L["Battle.Net Whisper"],
					["bnConversation"] = L["Battle.Net Convo"],
					["channel"] = L["Numbered Channels"],
				},
				get = function(_, key) return db.tabs[key] end,
				set = function(_, key, value) db.tabs[key] = value; Module:UpdateChannels(); end,
			},
			general = {
				type = "multiselect",
				order = 14,
				name = L["General Tab Channels"],
				desc = L["These channels apply to the General tab only."],
				values = {
					["whisper"] = L["Whisper"],
					["guild"] = L["Guild"],
					["officer"] = L["Officer"],
					["party"] = L["Party"],
					["partyLeader"] = L["Party Leader"],
					["raid"] = L["Raid"],
					["raidLeader"] = L["Raid Leader"],
					["instance"] = L["Instance"],
					["instanceLeader"] = L["Instance Leader"],
					["bnWhisper"] = L["Battle.Net Whisper"],
					["bnConversation"] = L["Battle.Net Convo"],
					["channel"] = L["Numbered Channels"],
				},
				get = function(_, key) return db.general[key] end,
				set = function(_, key, value) db.general[key] = value; Module:UpdateChannels(); end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Handles chat tab flashing."]
end