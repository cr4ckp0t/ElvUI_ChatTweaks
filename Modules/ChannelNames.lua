-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Channel Names", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Channel Names"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

local EnumerateServerChannels = _G["EnumerateServerChannels"]
local GetChannelList = _G["GetChannelList"]


local gsub = string.gsub
local find = string.find
local select = select
local pairs = pairs
local loadstring = loadstring
local tostring = tostring
local GetChannelList = GetChannelList

local empty_tag = L["$$EMPTY$$"];
local channels

local db, options
local defaults = {
	global = {
		channels = {
			[CHAT_MSG_SAY] = "[S]",
			[CHAT_MSG_GUILD] = "[G]",
			[CHAT_MSG_OFFICER] = "[O]",
			[CHAT_MSG_PARTY] = "[P]",
			[CHAT_MSG_PARTY_LEADER] = "[PL]",
			[L["Dungeon Guide"]] = "[DG]",
			[CHAT_MSG_RAID] = "[R]",
			[CHAT_MSG_RAID_LEADER] = "[RL]",
			[CHAT_MSG_RAID_WARNING] = "[RW]",
			[INSTANCE_CHAT] = "[I]",
			[INSTANCE_CHAT_LEADER] = "[IL]",
			-- Not localized here intentionally
			["Whisper From"] = "[W:From]",
			["Whisper To"] = "[W:To]",
			["BN Whisper From"] = "[BN:From]",
			["BN Whisper To"] = "[BN:To]",
			["away BN Whisper To"] = "<Away>[BN:To]",
			["busy BN Whisper To"] = "<Busy>[BN:To]"
		},
		addSpace = true
	}
}

local options = {
	addSpace = {
		type = "toggle",
		name = L["Add space after channels"],
		desc = L["Add space after channels"],
		get = function() return db.addSpace end,
		set = function(info, v) db.addSpace = v end
	}
}

local serverChannels = {}
local function excludeChannels(...)
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		serverChannels[name] = true
	end
end

local functions = {}

local function addChannel(name)
	options[name:gsub(" ", "_")] = {
		type = "input",
		name = name,
		desc = L["Replace this channel name with..."],
		order = name:lower() == name and 101 or 98,
		get = function()
			local v = db.channels[name]
			return v == "" and " " or v
		end,
		set = function(info, v)
			db.channels[name] = #v > 0 and v or nil
			if v:match("^function%(") then
				functions[name] = loadstring("return " .. v)()
			else
				functions[name] = nil
			end
		end
	}
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
	
	self.db.global.customChannels = nil
	for k, _ in pairs(self.db.global.channels) do
		addChannel(k)
	end
	excludeChannels(EnumerateServerChannels())
	for k, v in pairs(serverChannels) do
		addChannel(k)
	end
	self:AddCustomChannels(GetChannelList())

	for k, v in pairs(self.db.global.channels) do
		if v:match("^function%(") then
			functions[k] = loadstring("return " .. v)()
		end
	end
end

function Module:AddCustomChannels(...)
	for i = 1, select("#", ...), 3 do
		local id, name = select(i, ...)
		if not serverChannels[name] and not options[name:gsub(" ", "_")] then
			options[name:gsub(" ", "_")] = {
				type = "input",
				name = name,
				desc = L["Replace this channel name with..."],
				order = id <= 4 and 98 or 101,
				get = function()
					local v = db.channels[name:lower()]
					return v == "" and " " or v
				end,
				set = function(info, v)
					db.channels[name:lower()] = #v > 0 and v or nil
					if v:match("^function%(") then
						functions[name:lower()] = loadstring("return " .. v)()
					end
				end
			}
		end
	end
end

function Module:Decorate(frame)
	self:RawHook(frame, "AddMessage", true)
end

function Module:OnEnable()
	channels = db.channels
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		if cf ~= COMBATLOG then
			self:RawHook(cf, "AddMessage", true)
		end
	end
	for index,name in ipairs(self.TempChatFrames) do
		local cf = _G[name]
		if cf then
			self:RawHook(cf, "AddMessage", true)
		end
	end
end

function Module:OnDisable()
	self:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	self:UnhookAll()
end

function Module:CHAT_MSG_CHANNEL_NOTICE()
	self:AddCustomChannels(GetChannelList())
end

local function replaceChannel(origChannel, msg, num, channel)
	local f = functions[channel] or functions[channel:lower()]
	local newChannelName = f and f(channel) or channels[channel] or channels[channel:lower()] or msg
	if newChannelName == empty_tag then return "" end
	return ("|Hchannel:%s|h%s|h%s"):format(origChannel, newChannelName, db.addSpace and " " or "")
end

local function replaceChannelRW(msg, channel)
	local f = functions[channel] or functions[channel:lower()]
	local newChannelName = f and f(channel) or channels[channel] or channels[channel:lower()] or msg
	return newChannelName .. (db.addSpace and " " or "")
end

function Module:AddMessage(frame, text, ...)
	if not text then
		return self.hooks[frame].AddMessage(frame, text, ...)
	end
	-- removed the start of check, since blizz timestamps inject themselves in front of the line
	if (CHAT_TIMESTAMP_FORMAT) then
		text = gsub(text, "|Hchannel:(%S-)|h(%[([%d. ]*)([^%]]+)%])|h ", replaceChannel)
		text = gsub(text, "(%[(" .. L["Raid Warning"] .. ")%]) ", replaceChannelRW)
	else
		text = gsub(text, "^|Hchannel:(%S-)|h(%[([%d. ]*)([^%]]+)%])|h ", replaceChannel)
		text = gsub(text, "^(%[(" .. L["Raid Warning"] .. ")%]) ", replaceChannelRW)
	end
	if db.channels then
		text = gsub(text, L["(|Hplayer.-|h) says:"], (db.channels[CHAT_MSG_SAY]) .. (db.addSpace and " %1:" or "%1:"))
		text = gsub(text, L["To (|Hplayer.-|h):"], (db.channels["Whisper To"] or "[W:From]") .. (db.addSpace and " %1:" or "%1:"))
		text = gsub(text, L["(|Hplayer.-|h) whispers:"], (db.channels["Whisper From"] or "[W:To]") .. (db.addSpace and " %1:" or "%1:"))
		text = gsub(text, L["To (|HBNplayer.-|h):"], (db.channels["BN Whisper To"] or "[BN:From]") .. (db.addSpace and " %1:" or "%1:"))
		text = gsub(text, L["To <Away>(|HBNplayer.-|h):"], (db.channels["away BN Whisper To"] or "[BN:To]") .. (db.addSpace and " %1:" or "%1:"))
		text = gsub(text, L["To <Busy>(|HBNplayer.-|h):"], (db.channels["busy BN Whisper To"] or "<Away>[BN:To]") .. (db.addSpace and " %1:" or "%1:"))
		text = gsub(text, L["(|HBNplayer.-|h): whispers:"], (db.channels["BN Whisper From"] or "<Busy>[BN:To") .. (db.addSpace and " %1:" or "%1:"))
	end
	return self.hooks[frame].AddMessage(frame, text, ...)
end

function Module:GetOptions()
	return options
end

function Module:Info()
	return L["Enables you to replace channel names with your own names. You can use '%s' to force an empty string.\n\n|cffffff00Please disable ElvUI Short Channel option for this to work, you'll find the option under /ec - Chat - General - Short Channels."]:format( empty_tag )
end
