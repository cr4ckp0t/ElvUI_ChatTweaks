-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Reputation", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Reputation"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db, options
local defaults = {
	global = {
		output = "ChatFrame3",
		bodyColor = {r = 1.0, g = 1.0, b = 0},
		repColor = {r = 0.11, g = 0.38, b = 0.55},
		factColor = {r = 0.65, g = 0.79, b = 0.22},
		standColor = {r = 0.56, g = 0.3, b = 0.67},
		throttle = true,
		interval = 5.0,
		
		-- all cataclysm factions + guild are defaulted to true, rest are false
		factions = {
			["avengersofhyjal"]		= true,
			["baradinswardens"]		= true,
			["dragonmawclan"]		= true,
			["guardiansofhyjal"]	= true,
			["hellscreamsreach"]	= true,
			["ramkahen"]			= true,
			["theearthenring"]		= true,
			["therazane"]			= true,
			["wildhammerclan"]		= true,
		},
	}
}

local frameString = "ChatFrame%d"
local colorString = "|cff%s%s|r"
local hexString = "%02x%02x%02x"
local repError = L["|cffff0000The Chat Frame you chose to output reputation changes,|r |cffffffff%s|r|cffff0000, does not exist."]
local repNeeded = L["%s reputation needed until %s with %s."]
local repLeft = L["%s reputation left until %s with %s."]
local globalString = "FACTION_STANDING_LABEL%d"

local displayedError = false
local messageSent = {}
local reputations = {}

local function PrepareFactionName(name)
	return name:lower():gsub("'", ""):gsub(" ", ""):gsub("-", "")
end

function Module:UPDATE_FACTION()
	local Frame = _G[db.output]
	if not Frame and not displayedError then
		self:Print(repError:format(db.output))
		displayedError = true
		return
	elseif not Frame then
		return
	end
	for i = 1, GetNumFactions() do
		local name, _, standing, bottom, top, earned, _, _, isHeader = GetFactionInfo(i)
		local key = PrepareFactionName(name)
		if not db.factions[key] then return end
		if db.throttle and messageSent[name] == true then return end
		if not isHeader and reputations[name] then
			local difference = earned - reputations[name]
			local faction = colorString:format(hexString:format(db.factColor.r * 255, db.factColor.g * 255, db.factColor.b * 255), name)
			
			if difference > 0 and standing ~= 8 then
				local reputation = colorString:format(hexString:format(db.repColor.r * 255, db.repColor.g * 255, db.repColor.b * 255), top - earned)
				local standFormat = colorString:format(hexString:format(db.standColor.r * 255, db.standColor.g * 255, db.standColor.b * 255), getglobal(globalString:format(standing + 1)))
				Frame:AddMessage(repNeeded:format(reputation, standFormat, faction), db.bodyColor.r, db.bodyColor.g, db.bodyColor.b)
			elseif difference < 0 and standing ~= 1 then
				local reputation = colorString:format(hexString:format(db.repColor.r * 255, db.repColor.g * 255, db.repColor.b * 255), earned - bottom)
				local standFormat = colorString:format(hexString:format(db.standColor.r * 255, db.standColor.g * 255, db.standColor.b * 255), getglobal(globalString:format(standing - 1)))
				Frame:AddMessage(repLeft:format(reputation, standFormat, faction), db.bodyColor.r, db.bodyColor.g, db.bodyColor.b)
			end
			
			-- throttle spam
			if db.throttle then
				messageSent[name] = true
				self:ScheduleTimer(function(name) messageSent[name] = nil end, db.interval, name)
			end
				
			reputations[name] = earned
		else
			reputations[name] = earned
		end
	end
end

function Module:OnEnable()
	self:RegisterEvent("UPDATE_FACTION")
end

function Module:OnDisable()
	self:UnregisterEvent("UPDATE_FACTION")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Displays reputation numbers and progress in the chat frame."]
end

function Module:GetOptions()
	if not options then
		options = {
			output = {
				type = "select",
				order = 13,
				width = "double",
				name = L["Ouput Frame"],
				desc = L["Chat frame to output the messages.  Default is ChatFrame3, which is the default output frame for reputation messages in ElvUI."],
				get = function() return db.output end,
				set = function(_, value) db.output = value end,
				values = {
					["ChatFrame1"]	= L["Chat Frame "].."1",
					["ChatFrame3"]	= L["Chat Frame "].."3",
					["ChatFrame4"]	= L["Chat Frame "].."4",
					["ChatFrame5"]	= L["Chat Frame "].."5",
					["ChatFrame6"]	= L["Chat Frame "].."6",
					["ChatFrame7"]	= L["Chat Frame "].."7",
					["ChatFrame8"]	= L["Chat Frame "].."8",
					["ChatFrame9"]	= L["Chat Frame "].."9",
					["ChatFrame10"]	= L["Chat Frame "].."10",
					["ChatFrame11"]	= L["Chat Frame "].."11",
					["ChatFrame12"]	= L["Chat Frame "].."12",
					["ChatFrame13"]	= L["Chat Frame "].."13",
					["ChatFrame14"]	= L["Chat Frame "].."14",
					["ChatFrame15"]	= L["Chat Frame "].."15",
					["ChatFrame16"]	= L["Chat Frame "].."16",
					["ChatFrame17"]	= L["Chat Frame "].."17",
					["ChatFrame18"]	= L["Chat Frame "].."18",
				},
			},
			bodyColor = {
				type = "color",
				order = 15,
				name = L["Output Color"],
				desc = L["Color of the base reputation messages."],
				get = function() return db.bodyColor.r, db.bodyColor.g, db.bodyColor.b end,
				set = function(_, r, g, b)
					db.bodyColor.r = r
					db.bodyColor.g = g
					db.bodyColor.b = b
				end
			},
			repColor = {
				type = "color",
				order = 16,
				name = L["Reputation Color"],
				desc = L["Color of the reputation needed/left."],
				get = function() return db.repColor.r, db.repColor.g, db.repColor.b end,
				set = function(_, r, g, b)
					db.repColor.r = r
					db.repColor.g = g
					db.repColor.b = b
				end,
			},
			factColor = {
				type = "color",
				order = 17,
				name = L["Faction Color"],
				desc = L["Color of the faction."],
				get = function() return db.factColor.r, db.factColor.g, db.factColor.b end,
				set = function(_, r, g, b)
					db.factColor.r = r
					db.factColor.g = g
					db.factColor.b = b
				end,
			},
			standColor = {
				type = "color",
				order = 18,
				name = L["Standing Color"],
				desc = L["Color of the standing (honored, revered, etc.)."],
				get = function() return db.standColor.r, db.standColor.g, db.standColor.b end,
				set = function(_, r, g, b)
					db.standColor.r = r
					db.standColor.g = g
					db.standColor.b = b
				end,
			},
			throttle = {
				type = "toggle",
				order = 19,
				name = L["Throttle Messages"],
				desc = L["Throttle output messages to prevent spam."],
				get = function() return db.throttle end,
				set = function(_, value) db.throttle = value end,
			},
			interval = {
				type = "range",
				order = 20,
				name = L["Throttle Interval"],
				desc = L["Time, in seconds, to throttle output messages to prevent spam."],
				disabled = function() return not db.throttle end,
				get = function() return db.interval end,
				set = function(_, value) db.interval = value end,
				min = 1, max = 10, step = 1,
			},
		}
		
		-- load factions
		options.factions = {
			type = "multiselect",
			order = 100,
			name = "",
			desc = L["Select which factions you would like to receive notifications for."],
			get = function(info, key)
				if db.factions[key] == nil then
					db.factions[key] = false
				end
				return db.factions[key]
			end,
			set = function(info, key, value) db.factions[key] = value end,
			values = function()
				-- add factions to options table
				local factions = {}
				for i = 1, GetNumFactions() do
					local name, _, _, _, _, _, _, _, isHeader = GetFactionInfo(i)
					-- we don't want headers
					if not isHeader then
						local key = PrepareFactionName(name)
						factions[key] = name
					end
				end
				sort(factions)
				return factions
			end,
		}
	end
	return options
end