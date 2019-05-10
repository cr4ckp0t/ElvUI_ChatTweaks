-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)

-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Keyword Sounds", "AceConsole-3.0")
local E, _, _, _, _ = unpack(ElvUI)
local CH = E:GetModule("Chat")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
local LSM = LibStub("LibSharedMedia-3.0")
Module.name = L["Keyword Sounds"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		sound = "ChatTweaks Alert",
		master = true,
		ignoreYours = true,
		channels = {
			["CHANNEL"] = true,
			["EMOTE"] = true,
			["GUILD"] = true,
			["OFFICER"] = false,
			["PARTY"] = false,
			["PARTY_LEADER"] = false,
			["RAID"] = false,
			["RAID_LEADER"] = false,
			["RAID_WARNING"] = false,
			["INSTANCE_CHAT"] = false,
			["INSTANCE_CHAT_LEADER"] = false,
			["SAY"] = true,
			["YELL"] = true,
			["WHISPER"] = true,
		},
	}
}

local function UCWords(link)
	return link:lower():gsub("(%w+)", function(first)
		return first:gsub("^%l", string.upper)
	end)
end

local function FindKeywords(self, event, text, author, ...)
	if db.ignoreYours and author:lower() == UnitName("player"):lower() then return end
	for i = 1, #{string.split(" ", text)} do
		local word = select(i, string.split(" ", text))
		if not word:find("|") then
			for keyword, _ in pairs(CH.Keywords) do
				if word:lower() == keyword:lower() then
					if db.sound and db.sound ~= "None" and LSM:IsValid("sound", db.sound) then
						PlaySoundFile(LSM:Fetch("sound", db.sound), db.master and "Master" or nil)
						return -- only play the sound once
					end
				end
			end
		end
	end
end

function Module:OnEnable()
	for index, value in pairs(db.channels) do
		if index and value == true then
			ChatFrame_AddMessageEventFilter(("CHAT_MSG_%s"):format(index:upper()), FindKeywords)
		end
	end
end

function Module:OnDisable()
	for index, value in pairs(db.channels) do
		if index and value == true then
			ChatFrame_RemoveMessageEventFilter(("CHAT_MSG_%S"):format(index:upper()), FindKeywords)
		end
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(self.namespace, defaults)
	db = self.db.global
	Module.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:RefreshChannels()
	for index, value in pairs(db.channels) do
		if value == true then
			ChatFrame_AddMessageEventFilter(("CHAT_MSG_%s"):format(index:upper()), FindKeywords)
		else
			ChatFrame_RemoveMessageEventFilter(("CHAT_MSG_%S"):format(index:upper()), FindKeywords)
		end
	end
end

function Module:GetOptions()
	if not options then
		options = {
			sound = {
				type = "select",
				order = 13,
				dialogControl = "LSM30_Sound",
				name = L["Sound"],
				desc = L["Set the sound to play."],
				values = AceGUIWidgetLSMlists.sound,
				get = function() return db.sound end,
				set = function(_, value) db.sound = value end,
			},
			master = {
				type = "toggle",
				order = 14,
				name = L["Use Master Channel"],
				desc = L["Use the master channel when playing the sound."],
				get = function() return db.master end,
				set = function(_, value) db.master = value end,
			},
			ignoreYours = {
				type = "toggle",
				order = 15,
				name = L["Ignore Your Messages"],
				desc = L["Ignore any messages you send containing keywords."],
				get = function() return db.ignoreYours end,
				set = function(_, value) db.ignoreYours = value end,
			},
			channels = {
				type = "multiselect",
				order = -1,
				name = L["Channels to Monitor"],
				desc = L["Select the channels you want monitored."],
				values = {
					["CHANNEL"] = L["Channel"],
					["EMOTE"] = CHAT_MSG_EMOTE,
					["GUILD"] = CHAT_MSG_GUILD,
					["OFFICER"] = CHAT_MSG_OFFICER,
					["PARTY"] = CHAT_MSG_PARTY,
					["PARTY_LEADER"] = CHAT_MSG_PARTY_LEADER,
					["RAID"] = CHAT_MSG_RAID,
					["RAID_LEADER"] = CHAT_MSG_RAID_LEADER,
					["RAID_WARNING"] = CHAT_MSG_RAID_WARNING,
					["INSTANCE_CHAT"] = INSTANCE_CHAT,
					["INSTANCE_CHAT_LEADER"] = INSTANCE_CHAT_LEADER,
					["SAY"] = CHAT_MSG_SAY,
					["YELL"] = CHAT_MSG_YELL,
					["WHISPER"] = CHAT_MSG_WHISPER_INFORM,
				},
				get = function(_, key) return db.channels[key] end,
				set = function(_, key, value)
					db.channels[key] = value
					Module:RefreshChannels()
				end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Plays a sound when one of your ElvUI keywords is found."]
end