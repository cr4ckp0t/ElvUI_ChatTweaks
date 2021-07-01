-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-- Module Created By Klix (EU, Twisting Nether)
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Channel Colors", "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Channel Colors"]
Module.namespace = string.gsub(Module.name, " ", "")

local GetMessageTypeColor = _G["GetMessageTypeColor"]
local ChangeChatColor = _G["ChangeChatColor"]
local GetChannelName = _G["GetChannelName"]
local GetChannelList = _G["GetChannelList"]

local db, options
local defaults = {
	global = {
		colors = {}
	}
}

function Module:AddChannels(...)
	for i = 1, select("#", ...), 3 do
		local id, name = select(i, ...)
		db.colors[name] = db.colors[name] or {}
		if not db.colors[name].r then
			local r, g, b = GetMessageTypeColor(type(id) == "number" and ("CHANNEL" .. id) or id)
			db.colors[name].r = r
			db.colors[name].g = g
			db.colors[name].b = b
		end
		if not options[name:gsub(" ", "_")] then
			options[name:gsub(" ", "_")] = {
				type = "color",
				name = name,
				desc = L["Select a color for this channel."],
				order = type(id) == "number" and (50 + id) or 48,
				get = function()
					local c = db.colors[name]
					if c then
						return c.r, c.g, c.b
					else
						return GetMessageTypeColor(type(id) == "number" and ("CHANNEL" .. id) or id)
					end
				end,
				set = function(info, r, g, b)
					db.colors[name] = db.colors[name] or {}
					db.colors[name].r = r
					db.colors[name].g = g
					db.colors[name].b = b
					ChangeChatColor(type(id) == "number" and ("CHANNEL" .. id) or id, r, g, b);
				end
			}
		end
	end
end

function Module:UPDATE_CHAT_COLOR(event, channel, r, g, b)
	if channel then
		local number = tonumber(channel:match("(%d+)$"))
		local chanNumber = number and select(2, GetChannelName(number))
		local name = chanNumber and chanNumber:match("^(%w+)") or channel
		db.colors[name] = db.colors[name] or {}
		db.colors[name].r = r
		db.colors[name].g = g
		db.colors[name].b = b
	end
end

function Module:CHAT_MSG_CHANNEL_NOTICE(event, notice, _, _, fullname, _, _, chanType, chanNumber, chanName)
	if notice == "YOU_JOINED" then
		self:AddChannels(GetChannelList())
		chanName = chanName:match("^(%w+)")
		local color = db.colors[chanName]
		if color then
			ChangeChatColor("CHANNEL" .. chanNumber, color.r, color.g, color.b)
		end
	end
end

function Module:OnEnable()
	self:RegisterEvent("UPDATE_CHAT_COLOR")
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	self:AddChannels(GetChannelList())
	self:AddChannels(
		"SAY", CHAT_MSG_SAY, nil,
		"YELL", CHAT_MSG_YELL, nil,
		"GUILD", CHAT_MSG_GUILD, nil,
		"OFFICER", CHAT_MSG_OFFICER, nil,
		"PARTY", CHAT_MSG_PARTY, nil,
		"PARTY_LEADER", CHAT_MSG_PARTY_LEADER, nil,
		"RAID", CHAT_MSG_RAID, nil,
		"RAID_LEADER", CHAT_MSG_RAID_LEADER, nil,
		"RAID_WARNING", CHAT_MSG_RAID_WARNING, nil,
		"INSTANCE_CHAT", INSTANCE_CHAT, nil,
		"INSTANCE_CHAT_LEADER", INSTANCE_CHAT_LEADER, nil,
		"WHISPER", CHAT_MSG_WHISPER_INFORM, nil,
		"BN_WHISPER", CHAT_MSG_BN_WHISPER, nil
	)
end

function Module:OnDisable()
	self:UnregisterAllEvents()
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Keeps your channel colors by name rather than by number."]
end

function Module:GetOptions()
	if not options then
		options = {
			splitter = {
				type = "header",
				name = L["Other Channels"],
				order = 49
			}
		}
	end
	return options
end
