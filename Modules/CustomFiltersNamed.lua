-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Custom Named Chat Filters", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Custom Named Chat Filters"]
Module.namespace = string.gsub(Module.name, " ", "")

local channels = {"party", "guild", "officer", "raid", "say", "yell"}

local db, options
local defaults = {
	global = {
		mode = "HIDE",
		color = {r = 0.45, g = 0.45, b = 0.45},
		filters = {
			"^[aA]nal (.+)$",
			"[aA]nal",
			"Thunderfury",
		},

		party = true,
		guild = true,
		officer = false,
		raid = true,
		instance_chat = true,
		say = true,
		yell = true,
	},
}

local function UCWords(link)
	return link:lower():gsub("(%w+)", function(first)
		return first:gsub("^%l", upper)
	end)
end

local function NamedFilters(self, event, message, author, ...)
	if not message or #db.filters == 0 or author == UnitName("player") then return end
	for _, value in ipairs(db.filters) do
		if Module.debug then
			print(message)
		end
		if message:match(value) then
			if db.mode == "COLOR" then
				local color = ("%02x%02x%02x"):format(db.color.r * 255, db.color.g * 255, db.color.b * 255)
				return false, ("|cff%s%s|r"):format(color, message), author, ...
			else
				return true
			end
		end
	end
end

function Module:PopulateFilters(filters)
	db.filters = {}
	for _, value in pairs(filters) do
		if value ~= "" and value ~= nil then
			db.filters[#db.filters + 1] = value
		end
	end
end

function Module:FiltersToString()
	local trigs = ""
	for i = 1, #db.filters do
		if db.filters[i]:trim() ~= "" then
			trigs = trigs .. db.filters[i] .. "\n"
		end
	end
	return trigs
end

function Module:SetEventFilters()
	for _, info in ipairs(channels) do
		if db[info] then
			ChatFrame_AddMessageEventFilter(("CHAT_MSG_%s"):format(info:upper()), NamedFilters)
		else
			ChatFrame_RemoveMessageEventFilter(("CHAT_MSG_%s"):format(info:upper()), NamedFilters)
		end
	end
end


function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
	self:SetEventFilters()
end

function Module:Info()
	return L["This module is for named channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.\n\nFor more information see this addon's Curse page."]
end

function Module:GetOptions()
	if not options then
		options = {
			mode = {
				type = "select",
				order = 13,
				name = L["Filtering Mode"],
				desc = L["How to filter any matches."],
				values = {
					["COLOR"] = L["Colorize"],
					["HIDE"] = L["Remove"],
				},
				get = function() return db.mode end,
				set = function(_, value) db.mode = value end
			},
			color = {
				type = "color",
				order = 14,
				name = L["Filter Color"],
				desc = L["Color to change the filtered message to.\n\n|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r."],
				get = function() return db.color.r, db.color.g, db.color.b end,
				set = function(_, r, g, b)
					db.color.r = r
					db.color.g = g
					db.color.b = b
				end
			},
			filters = {
				type = "input",
				order = 15,
				multiline = true,
				width = "double",
				name = L["Filters"],
				desc = L["Custom chat filters."],
				get = function() return Module:FiltersToString() end,
				set = function(_, value)
					local trigList = {strsplit("\n", value:trim())}
					Module:PopulateFilters(trigList)
				end
			},
			channels = {
				type = "group",
				order = 100,
				name = L["Channels"],
				get = function(info) return db[info[#info]] end,
				set = function(info, value) db[info[#info]] = value; Module:SetEventFilters(); end,
				guiInline = true,
				args = {
					party = {
						type = "toggle",
						order = 1,
						name = CHAT_MSG_PARTY,
					},
					guild = {
						type = "toggle",
						order = 2,
						name = CHAT_MSG_GUILD,
					},
					officer = {
						type = "toggle",
						order = 3,
						name = CHAT_MSG_OFFICER,
					},
					raid = {
						type = "toggle",
						order = 4,
						name = CHAT_MSG_RAID,
					},
					instance_chat = {
						type = "toggle",
						order = 5,
						name = INSTANCE_CHAT,
					},
					say = {
						type = "toggle",
						order = 7,
						name = CHAT_MSG_SAY,
					},
					yell = {
						type = "toggle",
						order = 8,
						name = CHAT_MSG_YELL,
					},
				},
			},
		}	
	end
	return options
end