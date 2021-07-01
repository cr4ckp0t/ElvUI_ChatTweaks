-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Custom Names", "AceConsole-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Custom Names"]
Module.namespace = string.gsub(Module.name, " ", "")

local UnitName = _G["UnitName"]
local GetChannelName = _G["GetChannelName"]

local character_name
local db, options
local defaults = {
	global = {
		guild = true,
		party = false,
		raid = false,
		instance_chat = false,
		channel = nil,
		hideOnMatchingCharName = false,
	}
}

function Module:OnEnable()
	self:RawHook("SendChatMessage", true)
	character_name, _ = UnitName("player")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnDisable()
	self:Unhook("SendChatMessage")
end

function Module:SendChatMessage(msg, chatType, language, channel)
	if db.name and db.name ~= "" then
		if (not db.hideOnMatchingCharName) or (db.name ~= character_name) then

			if  (db.guild and (chatType == "GUILD" or chatType == "OFFICER")) or
				(db.raid and chatType == "RAID") or
				(db.party and chatType == "PARTY") or
				(db.instance_chat and chatType == "INSTANCE_CHAT")
			then
				msg = "(" .. db.name .. "): " .. msg

			elseif db.channel and chatType == "CHANNEL" then
				--local id, chname = GetChannelName(channel)
				--if strupper(db.channel) == strupper(chname) then
					msg = "(" .. db.name .. "): " .. msg
				--end
			end
		end
	end

	-- Call original function
	self.hooks.SendChatMessage(msg, chatType, language, channel)
end

function Module:GetOptions()
	if not options then
		options = {
			name = {
				order = 15,
				type = "input",
				name = L["Name"],
				desc = L["The name that should be displayed in your chat messages."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
			guild = {
				order = 16,
				type = "toggle",
				name = L["Guild"],
				desc = L["Add custom names to the guild chat messages. (also include officer chat)."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
			party = {
				order = 17,
				type = "toggle",
				name = L["Party"],
				desc = L["Add custom names to the party chat messages."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
			raid = {
				order = 18,
				type = "toggle",
				name = L["Raid"],
				desc = L["Add custom names to the raid chat messages."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
			instance_chat = {
				order = 19,
				type = "toggle",
				name = L["Instance"],
				desc = L["Add custom names to the instance chat messages, e.g., LFR and battlegrounds."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
			channel = {
				order = 20,
				type = "input",
				name = L["Channel"],
				desc = L["Add custom names to the chat messages in this custom channel."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
			hideOnMatchingCharName = {
				order = 21,
				type = "toggle",
				name = L["Hide name if it matches your character's name"],
				desc = L["If the name specified above matches your current character's name, this module will not add it again if this option is checked."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Gives the ability to add custom names to the chat messages for better recognition."]
end
