-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("A Test of Valor", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["A Test of Valor"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		gains = true,
		throttle = 5,
		completed = false,
	}
}

function Module:CHAT_MSG_CURRENCY(event, message, ...)
	if not db.gains or not message:find(L["Valor Points"]) then return end
	
	-- check if the achievement has already been completed
	local _, _, _, completed, month, day, year, _, _, _, _, _ = GetAchievementInfo(8030)
	if completed then
		self:Print((L[" %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"]):format(GetAchievementLink(8030), ElvUI_ChatTweaks.hexColor, month, ElvUI_ChatTweaks.hexColor, day, ElvUI_ChatTweaks.hexColor, year))
		db.gains = false
		db.completed = true
		self:UnregisterEvent("CHAT_MSG_CURRENCY")
	end
	
	-- code to throttle
	if db.throttle > 0 and self.updateSent then
		if db.debug then
			self:Print((L["Throttle time prevented %s update."]):format(GetAchievementLink(8030)))
		end
		return
	end
	
	local _, _, _, quantity, _, _, _, _, _, _ = GetAchievementCriteriaInfo(8030, 1)
	self:Print((" %s Progress: %s%s|r/%s6000|r (%s%s|r remaining, %s%.1f%%|r)"):format(GetAchievementLink(8030), ElvUI_ChatTweaks.hexColor, quantity, ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.hexColor, 6000 - quantity, ElvUI_ChatTweaks.hexColor, quantity / 6000 * 100))
	
	-- set the throttle
	if db.throttle > 0 then
		self:ScheduleTimer(function() self.updateSent = false end, db.throttle)
		self.updateSent = true
	end
end

function Module:OnEnable()
	self:RegisterChatCommand("tov", function()
		-- first get achievement info
		local _, _, _, completed, month, day, year, _, _, _, _, _ = GetAchievementInfo(8030)
		if completed then
			-- already finished
			self:Print((L[" %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"]):format(GetAchievementLink(8030), ElvUI_ChatTweaks.hexColor, month, ElvUI_ChatTweaks.hexColor, day, ElvUI_ChatTweaks.hexColor, year))
			db.gains = false
			db.completed = true
			
		else
			-- not completed, so we must gather the required information
			local _, _, _, quantity, _, _, _, _, _, _ = GetAchievementCriteriaInfo(8030, 1)
			self:Print((" %s Progress: %s%s|r/%s6000|r (%s%s|r remaining, %s%.1f%%|r)"):format(GetAchievementLink(8030), ElvUI_ChatTweaks.hexColor, quantity, ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.hexColor, 6000 - quantity, ElvUI_ChatTweaks.hexColor, quantity / 6000 * 100))
		end
	end)
	
	if not db.completed then
		self:RegisterEvent("CHAT_MSG_CURRENCY")
		self.updateSent = false
	end
end

function Module:OnDisable()
	self:UnregisterChatCommand("tov")
	
	if not db.completed then
		self:UnregisterEvent("CHAT_MSG_CURRENCY")
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(self.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugginga
end

function Module:GetOptions()
	if not options then
		options = {
			gains = {
				type = "toggle",
				order = 13,
				name = L["Progress Updates"],
				desc = L["Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement."],
				disabled = function() return db.completed end,
				get = function() return db.gains end,
				set = function(_, value) db.gains = value end,
			},
			throttle = {
				type = "range",
				order = 14,
				name = L["Message Throttle"],
				desc = L["Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable."],
				disabled = function() return not db.gains end,
				get = function() return db.throttle end,
				set = function(_, value) db.throttle = value; Module.updateSent = false; end,
				min = 0, max = 60, step = 5, bigStep = 10,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command."]
end