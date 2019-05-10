-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Color Rolls", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Color Rolls"]
Module.namespace = string.gsub(Module.name, " ", "")

-- roll caputure is different depending on the client's locale
local ROLL_MSG
if GetLocale() == "deDE" then
	ROLL_MSG = RANDOM_ROLL_RESULT:gsub("%(", "%%("):gsub("%)", "%%)"):gsub("%%1$s", "(.+)"):gsub("%%2$d", "(.+)"):gsub("%%3$d", "(.+)"):gsub("%%4$d", "(.+)"):gsub("%-", "%%-")
-- default
else
	ROLL_MSG = RANDOM_ROLL_RESULT:gsub("%(", "%%("):gsub("%)", "%%)"):gsub("%%s", "(.+)"):gsub("%%d", "(.+)"):gsub("%-", "%%-")
end

local db, options
local defaults = {
	global = {
		colorRolls = true,
		rollColor = {r = 1.0, g = 1.0, b = 0},	-- yellow
		colorYours = true,
		yourColor = {r = 0, g = 1.0, b = 1.0},	-- blue/green
		colorWin = true,
		winColor = {r = 0, g = 1.0, b = 0},		-- green
		colorLoss = true,
		lossColor = {r = 1.0, g = 0, b = 0},		-- red
		colorCheats = true,
		cheatsColor = {r = 0, g = 0, b = 1.0},		-- blue
	}
}

local function ColorMessage(color, message)
	return ("|cff%02x%02x%02x%s|r"):format(color.r * 255, color.g * 255, color.b * 255, message)
end

local function CaptureRolls(self, event, message, ...)
	if not message:match(ROLL_MSG) then return false end
	
	local who, roll, min, max = message:match(ROLL_MSG)
	local color = nil
	
	-- debugging
	if Module.debug then
		Module:Print((L["Roll Pattern: |cffffff00%s|r"]):format(ROLL_MSG))
		Module:Print((L["Who: |cffffff00%s|r, Roll: |cffffff00%s|r, Min: |cffffff00%s|r, Max: |cffffff00%s|r"]):format(who, roll, min, max))
	end
	
	roll = tonumber(roll); min = tonumber(min)
	if db.colorCheats and min > 1 then
		-- cheater roll
		color = db.cheatsColor
	elseif who:lower() == UnitName("player"):lower() then
		-- your rolls
		if roll == 1 then
			color = db.colorLoss == true and db.lossColor or nil
		else
			color = db.colorYours == true and db.yourColor or nil
		end
	else
		-- others' rolls
		if roll == 1 then
			color = db.colorWin == true and db.winColor or nil
		else
			color = db.colorRolls == true and db.rollColor or nil
		end
	end
	
	if not color then
		return false
	else
		return false, ColorMessage(color, message), ...
	end
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", CaptureRolls)
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", CaptureRolls)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Color rolls differently to make tracking the roll game easier on the eyes."]
end

function Module:GetOptions()
	if not options then
		options = {
			colorRolls = {
				type = "toggle",
				order = 13,
				name = L["Color Rolls"],
				desc = L["Color regular rolls by others."],
				get = function() return db.colorRolls end,
				set = function(_, value) db.colorRolls = value end,
			},
			rollColor = {
				type = "color",
				order = 14,
				width = "double",
				name = L["Roll Color"],
				desc = L["Color of other's rolls."],
				disabled = function() return not db.colorRolls end,
				get = function() return db.rollColor.r, db.rollColor.g, db.rollColor.b end,
				set = function(_, r, g, b) db.rollColor.r = r; db.rollColor.g = g; db.rollColor.b = b; end,
			},
			colorYours = {
				type = "toggle",
				order = 15,
				name = L["Color Your Rolls"],
				desc = L["Color your rolls to set them apart."],
				get = function() return db.colorYours end,
				set = function(_, value) db.colorYours = value end,
			},
			yourColor = {
				type = "color",
				order = 16,
				width = "double",
				name = L["Your Color"],
				desc = L["Color to use for your rolls."],
				disabled = function() return not db.colorYours end,
				get = function() return db.yourColor.r, db.yourColor.g, db.yourColor.b end,
				set = function(_, r, g, b) db.yourColor.r = r; db.yourColor.g = g; db.yourColor.b = b; end,
			},
			colorWin = {
				type = "toggle",
				order = 17,
				name = L["Color Win"],
				desc = L["Color a roll game win, aka when someone else rolls a one (1)."],
				get = function() return db.colorWin end,
				set = function(_, value) db.colorWin = value end,
			},
			winColor = {
				type = "color",
				order = 18,
				width = "double",
				name = L["Win Color"],
				desc = L["Color to designate a roll game win."],
				disabled = function() return not db.colorWin end,
				get = function() return db.winColor.r, db.winColor.g, db.winColor.b end,
				set = function(_, r, g, b) db.winColor.r = r; db.winColor.g = g; db.winColor.b = b; end,
			},
			colorLoss = {
				type = "toggle",
				order = 19,
				name = L["Color Loss"],
				desc = L["Color a roll game loss, aka when you roll a one (1)."],
				get = function() return db.colorLoss end,
				set = function(_, value) db.colorLoss = value end,
			},
			lossColor = {
				type = "color",
				order = 20,
				width = "double",
				name = L["Loss Color"],
				desc = L["Color to designate a roll game loss."],
				disabled = function() return not db.colorLoss end,
				get = function() return db.lossColor.r, db.lossColor.g, db.lossColor.b end,
				set = function(_, r, g, b) db.lossColor.r = r; db.lossColor.g = g; db.lossColor.b = b; end,
			},
			colorCheats = {
				type = "toggle",
				order = 21,
				name = L["Color Cheats"],
				desc = L["Color rolls that do not start at 1."],
				get = function() return db.colorCheats end,
				set = function(_, value) db.colorCheats = value end,
			},
			cheatsColor = {
				type = "color",
				order = 22,
				width = "double",
				name = L["Cheats Color"],
				desc = L["Color to designate a cheating roll."],
				disabled = function() return not db.colorCheats end,
				get = function() return db.cheatsColor.r, db.cheatsColor.g, db.cheatsColor.b end,
				set = function(_, r, g, b) db.cheatsColor.r = r; db.cheatsColor.g = g; db.cheatsColor.b = b; end,
			},
		}
	end
	return options
end