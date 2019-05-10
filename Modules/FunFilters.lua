-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Fun Filters", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Fun Filters"]
Module.namespace = string.gsub(Module.name, " ", "")

local upper = string.upper

local db, options
local defaults = {
	global = {
		mode = "reverse",
		channels = {
			["guild"] = true,
			["officer"] = false,
			["channel"] = true,
			["say"] = true,
			["yell"] = true,
			["raid"] = false,
			["raid_leader"] = false,
			["raid_warning"] = false,
			["party"] = false,
			["party_leader"] = false,
			["instance"] = false,
			["instance_leader"] = false,
		},
	}
}

local function capitalize(str)
    return str:gsub("^%l", upper)
end

local function replace(str, arr)
	for char, rep in pairs(arr) do
		str = str:gsub(("[%s]"):format(char), rep)
	end
	return str
end

local function RunFilter(self, event, message, ...)
	local channel = event:match("CHAT_MSG_(.+)"):lower()
	
	-- something went wrong, or the channel is disabled
	if not channel or not db.channels[channel] then return false end
	
	if db.mode == "ucase" then
		message = message:upper()
	
	elseif db.mode == "lcase" then
		message = message:lower()
	
	elseif db.mode == "altcaps" then
		local out = ""
		for i = 1, #message do
			local char = mod(i, 2) == 0 and message:sub(i, i):lower() or message:sub(i, i):upper()
			out = out .. char
		end
		message = out
	
	elseif db.mode == "capitalize" then
		message = message:gsub("%w+", capitalize)
	
	elseif db.mode == "reverse" then
		local out = ""
		for i = 1, #message do
			out = message:sub(i, i) .. out
		end
		message = out
	
	-- all other replacement types
	else
		message = replace(message, Module.replacements[db.mode])
	
	end
	
	return false, message, ... 
end

function Module:UpdateChannels()
	for channel, filter in pairs(db.channels) do
		local name = ("CHAT_MSG_%s"):format(channel:upper())
		if filter == true then
			ChatFrame_AddMessageEventFilter(name, RunFilter)
		else
			ChatFrame_RemoveMessageEventFilter(name, RunFilter)
		end
	end
end

function Module:OnEnable()
	self:UpdateChannels()
end

function Module:OnDisable()
	for channel, _ in pairs(db.channels) do
		ChatFrame_RemoveMessageEventFilter(("CHAT_MSG_%s"):format(channel:upper()), RunFilter)
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(self.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			mode = {
				type = "select",
				order = 13,
				name = L["Filter Mode"],
				desc = L["Choose the filter to use."],
				values = {
					["leet"] = "13375p34|<",
					["ucase"] = L["Uppercase"],
					["lcase"] = L["lowercase"],
					["capitalize"] = L["Capitalize Words"],
					["altcaps"] = L["AlTeRnAtInG CaPs"],
					["baltcaps"] = L["BeTTeR ALTeRNaTiNG CaPS"],
					["reverse"] = L["sretteL esreveR"],
					["grave"] = "Gràvè Lèttèrs",
					["acute"] = "Ácúté Léttérs",
					["circumflex"] = "Cîrcûmflêx Lêttêrs",
					["diaresis"] = "Dïärësïs Lëttërs",
				},
				get = function() return db.mode end,
				set = function(_, value) db.mode = value end,
			},
			channels = {
				type = "multiselect",
				order = 14,
				name = L["Channels to Filter"],
				desc = L["Select the channels to apply the filter to."],
				values = {
					["guild"] = L["Guild"],
					["officer"] = L["Officer"],
					["channel"] = L["Numbered Channels"],
					["say"] = L["Say"],
					["yell"] = L["Yell"],
					["raid"] = L["Raid"],
					["raid_leader"] = L["Raid Leader"],
					["raid_warning"] = L["Raid Warning"],
					["party"] = L["Party"],
					["party_leader"] = L["Party Leader"],
					["instance"] = L["Instance"],
					["instance_leader"] = L["Instance Leader"],
				},
				get = function(_, key) return db.channels[key] end,
				set = function(_, key, value) db.channels[key] = value; Module:UpdateChannels(); end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Allows you to use some fun filters on various chat channels.\n\n|cffff0000This will break any links in the chat message.|r\n\n|cffffff00Filters:|r\n13375p34|<, ALL UPPERCASE, all lowercase, Capitalize Words, AlTeRnAtInG CaPs, BeTTeR ALTeRNaTiNG CaPS, sretteL esreveR, Gràvè Lèttèrs, Ácúté Léttérs, Ðïärësïs Lëttërs, Cîrcûmflêx Lêttêrs"]
end

Module.replacements = {
	-- leetspeak
	["leet"] = {
		["Aa"] = "4", ["Bb"] = "8", ["Cc"] = "©", ["Dd"] = "[)", ["Ee"] = "3", ["Ff"] = "ƒ", ["Gg"] = "9",
		["Hh"] = "}{", ["Ii"] = "¡", ["Jj"] = "j", ["Kk"] = "|<", ["Ll"] = "1", ["Mm"] = "|V|", ["Nn"] = "(\)",
		["Oo"] = "0", ["Pp"] = "Þ", ["Qq"] = "q", ["Rr"] = "|2", ["Ss"] = "5", ["Tt"] = "7", ["Uu"] = "µ",
		["Vv"] = "\\/", ["Ww"] = "VV", ["Xx"] = "x", ["Yy"] = "¥", ["Zz"] = "2",
	},
	
	-- better alternating caps
	["baltcaps"] = {
		["Aa"] = "a", ["Bb"] = "B", ["Cc"] = "C", ["Dd"] = "D", ["Ee"] = "e", ["Ff"] = "F", ["Gg"] = "G",
		["Hh"] = "H", ["Ii"] = "I", ["Jj"] = "J", ["Kk"] = "K", ["Ll"] = "L", ["Mm"] = "M", ["Nn"] = "N",
		["Oo"] = "o", ["Pp"] = "P", ["Qq"] = "Q", ["Rr"] = "R", ["Ss"] = "S", ["Tt"] = "T", ["Uu"] = "u",
		["Vv"] = "V", ["Ww"] = "W", ["Xx"] = "X", ["Yy"] = "y", ["Zz"] = "Z",
	},
	
	-- grave letters
	["grave"] = {
		["A"] = "À", ["E"] = "È", ["I"] = "Ì", ["O"] = "Ò", ["U"] = "Ù",
		["a"] = "à", ["e"] = "è", ["i"] = "ì", ["o"] = "ò", ["u"] = "ù",
	},
	
	-- acute letters
	["acute"] = {
		["A"] = "Á", ["E"] = "É", ["I"] = "Í", ["O"] = "Ó", ["U"] = "Ú",
		["a"] = "á", ["e"] = "é", ["i"] = "í", ["o"] = "ó", ["u"] = "ú",
	},
	
	-- circumflex letters
	["circumflex"] = {
		["A"] = "Â", ["E"] = "Ê", ["I"] = "Î", ["O"] = "Ô", ["U"] = "Û",
		["a"] = "â", ["e"] = "ê", ["i"] = "î", ["o"] = "ô", ["u"] = "û",
	},
	
	-- diaresis letters
	["diaresis"] = {
		["A"] = "Ä", ["E"] = "Ë", ["I"] = "Ï", ["O"] = "Ö", ["U"] = "Ü",
		["a"] = "ä", ["e"] = "ë", ["i"] = "ï", ["o"] = "ö", ["u"] = "ü",
	},
}