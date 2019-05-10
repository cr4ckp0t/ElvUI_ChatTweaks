-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Auto Welcome", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Auto Welcome"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db, options
local defaults = {
	global = {
		dontAlways = true,
		chance = 50,
		minDelay = 1,
		maxDelay = 5,
		messages = {},
		afk = true,
		dnd = true,
	}
}

local guildJoin = format(ERR_GUILD_JOIN_S, "(.+)")

function Module:PopulateFilters(filters)
	db.messages = {}
	for _, value in pairs(filters) do
		if value ~= "" and value ~= nil then db.messages[#db.messages + 1] = value end
	end
end

function Module:FiltersToString()
	local trigs = ""
	if #db.messages == 0 then return "" end
	for i = 1, #db.messages do
		if db.messages[i]:trim() ~= "" and db.messages[i]:trim() ~= nil then
			trigs = trigs .. db.messages[i] .. "\n"
		end
	end
	return trigs
end

function Module:SendWelcome(settings)
	SendChatMessage(db.messages[random(1, #db.messages)]:gsub("#name#", settings[1]):gsub("#guild#", settings[2]), "GUILD", nil)
end

function Module:CHAT_MSG_SYSTEM(event, message, ...)
	if not IsInGuild() or not message then return end
	
	-- dont run if afk/dnd and appropriate setting is enabled
	if db.afk and UnitIsAFK("player") then return end
	if db.dnd and UnitIsDND("player") then return end
	
	-- sometimes (randomly) the function will return to prevent annoyances
	if db.dontAlways then
		local number, percent = random(1, 10), db.chance / 10
		if type(number) == "number" and type(percent) == "number" then
			if number > percent then return end	-- stop execution
		end
	end
	
	local who = message:match(guildJoin)
	if who ~= nil then
		local guildName, _, _ = GetGuildInfo("player")
		self:ScheduleTimer("SendWelcome", random(db.minDelay, db.maxDelay), {who, guildName})
	end
end

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_SYSTEM")
end

function Module:OnDisable()
	self:UnregisterEvent("CHAT_MSG_SYSTEM")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Automatically welcomes someone to your guild."]
end

function Module:GetOptions()
	if not options then
		options = {
			dontAlways = {
				type = "toggle",
				order = 13,
				name = L["Dont Always Run"],
				desc = L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always welcome."],
				get = function() return db.dontAlways end,
				set = function(_, value) db.dontAlways = value end,
			},
			chance = {
				type = "range",
				order = 14,
				name = L["Percent Chance"],
				desc = L["The percent chance the module has to welcome someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."],
				disabled = function() return not db.dontAlways end,
				get = function() return db.chance end,
				set = function(_, value) db.chance = value end,
				min = 0, max = 100, step = 10,
			},
			minDelay = {
				type = "range",
				order = 15,
				name = L["Minimum Delay"],
				desc = L["Minimum time, in seconds, to wait before welcoming someone."],
				get = function() return db.minDelay end,
				set = function(_, value)
					db.minDelay = value
					options.maxDelay.min = value
				end,
				min = 0, max = 30, step = 1,
			},
			maxDelay = {
				type = "range",
				order = 16,
				name = L["Maximum Delay"],
				desc = L["Maximum time, in seconds, to wait before welcoming someone."],
				get = function() return db.maxDelay end,
				set = function(_, value)
					db.maxDelay = value
					options.minDelay.max = value
				end,
				min = 0, max = 30, step = 1,
			},
			disableIf = {
				type = "group",
				order = 99,
				name = L["Disable if..."],
				guiInline = true,
				args = {
					afk = {
						type = "toggle",
						order = 1,
						name = L["AFK"],
						desc = L["Disable while you're AFK flagged."],
						get = function() return db.afk end,
						set = function(_, value) db.afk = value end,
					},
					dnd = {
						type = "toggle",
						order = 2,
						name = L["Busy"],
						desc = L["Disable while you're DND flagged."],
						get = function() return db.dnd end,
						set = function(_, value) db.dbd = value end,
					},
				}
			},
			messages = {
				type = "input",
				order = 100,
				multiline = true,
				width = "full",
				name = L["Welcome Messages"],
				desc = L["Messages to use when someone joins your guild.\n\n|cffFA6400Wildcards|r\n|cff00ff00#name#|r - Person who joined.\n|cff00ff00#guild#|r - Name of your guild."],
				get = function() return Module:FiltersToString() end,
				set = function(_, value) Module:PopulateFilters({strsplit("\n", value:trim())}) end,
			}
		}
	end
	return options
end