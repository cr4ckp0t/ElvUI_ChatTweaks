-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("XP Left To Level", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["XP Left To Level"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		frame 	= "ChatFrame3",
		rested = true,
		percent = true,
		total = true,
		color = {r = 0.44, g = 0.44, b = 1.0},
		every = 3
	}
}

local counter = 0
local outString = L["You need %s%s%s%sto hit level %d."]
local frameString = "ChatFrame%d"
local frameList = L["Chat Frame %d"]

local function Percent(min, max)
	return ("%.2f%%"):format(min / max * 100)
end

local function ShortValue(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

function Module:CHAT_MSG_COMBAT_XP_GAIN(self, event, ...)
	counter = counter + 1
	if counter == db.every then
		local rested
		local total = db.total and "/" .. ShortValue(UnitXPMax("player")) or " "
		local percent = db.percent and " (" .. Percent(UnitXP("player"), UnitXPMax("player")) .. ")" or ""
		local remain = ShortValue(UnitXPMax("player") - UnitXP("player"))
		
		if db.rested and GetXPExhaustion() ~= nil then
			rested = " (" .. ShortValue(GetXPExhaustion()) .. ") "
		end
		
		if Module.debug then
			print(total)
			print(rested)
			print(percent)
		end
		
		-- build the string based on values
		local output = outString:format(remain, total, percent, rested or " ", UnitLevel("player") + 1)
		_G[db.frame]:AddMessage(output, db.color.r, db.color.g, db.color.b)
		counter = 0	-- reset the counter
	end
end

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
end

function Module:OnDisable()
	self:UnregisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Prints a message in the chat with your remain XP needed to level up."]
end

function Module:GetOptions()
	if not options then
		options = {
			frame = {
				type = "select",
				order = 13,
				name = L["Output Frame"],
				desc = L["Chat frame to output the message to.  Default is |cffffff00ChatFrame3|r, which is the default frame for ElvUI XP messages."],
				get = function() return db.frame end,
				set = function(_, value) db.frame = value end,
				values = function()
					local frames = {}
					for i = 1, 18 do
						if _G[frameString:format(i)] then
							frames[frameString:format(i)] = frameList:format(i)
						end
					end
					return frames
				end,
			},
			color = {
				type = "color",
				order = 14,
				name = L["Output Color"],
				desc = L["Color of the output message."],
				get = function() return db.color.r, db.color.g, db.color.b end,
				set = function(_, r, g, b) db.color.r = r; db.color.g = g; db.color.b = b; end,
			},
			every = {
				type = "range",
				order = 15,
				name = L["Output Message Every..."],
				desc = L["Output the message every X times you gain XP."],
				get = function() return db.every end,
				set = function(_, value) db.every = value end,
				min = 1, max = 25, step = 1, bigStep = 1,
			},
			rested = {
				type = "toggle",
				order = 16,
				name = L["Show Rested XP"],
				desc = L["Show remaining rested XP."],
				get = function() return db.rested end,
				set = function(_, value) db.rested = value end,
			},
			percent = {
				type = "toggle",
				order = 17,
				name = L["Show Percentage"],
				desc = L["Show current to total XP percentage."],
				get = function() return db.percent end,
				set = function(_, value) db.percent = value end,
			},
			total = {
				type = "toggle",
				order = 18,
				name = L["Show Total XP"],
				desc = L["Show total XP needed to level."],
				get = function() return db.total end,
				set = function(_, value) db.total = value end,
			},
		}
	end
	return options
end