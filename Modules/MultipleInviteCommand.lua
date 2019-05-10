-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------

-- Module Written by Björn Benjamin Hiller <bjoern.hiller@gmail.com>
local Module = ElvUI_ChatTweaks:NewModule("Multiple Invite Command", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Multiple Invite Command"]
Module.namespace = string.gsub(Module.name, " ", "")

local abbrev = {}
local db, options
local defaults = {
	global = {
		abbreviations = "",
		prefixChar = "@"
	}
}

local function updateAbbreviations()
	table.wipe(abbrev)
	for entry in db.abbreviations:gmatch("[^,]+") do
		local short, full = entry:match(" *(%w+) *: *([^ ]+)")
		abbrev[short:lower()] = full
	end
end

local function multipleInvite(args)
	for name in args:gmatch("[^ ]+") do
		if name:sub(1, 1) == db.prefixChar then
			name = name:sub(2):lower()
			if abbrev[name] then InviteUnit(abbrev[name])
			else print(L["|cffffff00This abbreviation is unknown."]) end
		else InviteUnit(name) end
	end
end

function Module:OnEnable()
	self:RegisterChatCommand("minv", multipleInvite)
end

function Module:OnDisable()
	self:UnregisterChatCommand("minv")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	updateAbbreviations()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			prefixChar = {
				type = "input",
				name = L["Prefix Character"],
				desc = L["The character in front of abbreviations to be recognised as such."],
				width = "half",
				get = function() return db.prefixChar end,
				set = function(_, value) db.prefixChar = value end,
				validate = function(_, value)
					if value:len() > 1 then return L["Just one character."] end
					if value:match("[a-zA-Z0-9]") then return L["Do not use alphanumerical characters."] end
					return true
				end
			},	
			abbreviations = {
				type = "input",
				name = L["Abbreviations"],
				desc = L["Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN."],
				width = "full",
				get = function() return db.abbreviations end,
				set = function(_, value)
					db.abbreviations = value
					updateAbbreviations()
				end,
				validate = function(_, value)
					for entry in value:gmatch("[^,]+") do
						if not entry:match("^ *%w+ *: *[^ ]+ *$") then return L["Invalid format found on entry \"%s\"."]:format(entry) end
					end
					return true
				end
			}
		}
	end
	return options
end

function Module:Info()
	return L["Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.\n\nModule Written by Björn Benjamin Hiller <bjoern.hiller@gmail.com>"]
end
