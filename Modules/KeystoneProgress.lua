-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Keystone Progress", "AceConsole-3.0", "AceEvent-3.0")
local E, _, V, P, G = unpack(ElvUI)
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Keystone Progress"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

local AddTrackedAchievement = _G["AddTrackedAchievement"]
local GetAchievementInfo = _G["GetAchievementInfo"]
local IsTrackedAchievement = _G["IsTrackedAchievement"]
local RemoveTrackedAchievement = _G["RemoveTrackedAchievement"]

local ksmId = 14145
local kscId = 14144
local completed = {
	[14145] = false,
	[14144] = false,
}

local function AchievementsCompleted()
	local _, _, _, complete = GetAchievementInfo(ksmId)
	completed[14145] = complete
	local _, _, _, complete = GetAchievementInfo(kscId)
	completed[14144] = complete
end

function Module:ToggleTracking(id)
	local _, name = GetAchievementInfo(id)
	if completed[id] then
		self:Print((L["You have already completed %s."]):format(name))
	else
		if IsTrackedAchievement(id) then
			RemoveTrackedAchievement(id)
			self:Print((L["Stopped tracking %s."]):format(name))
		else
			AddTrackedAchievement(id)
			self:Print((L["Tracking %s."]):format(name))
		end
	end
end

function Module:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", AchievementsCompleted)
	self:RegisterEvent("ACHIEVEMENT_EARNED", AchievementsCompleted)

	self:RegisterChatCommand("ksm", function(args)
		local action = self:GetArgs(args)
		local _, name = GetAchievementInfo(ksmId)
		if action == "track" then
			self:ToggleTracking(ksmId)
		else
			if completed[ksmId] then
				self:Print((L["You have already completed %s."]):format(name))
			else
				self:Print(("|cffffff00%s|r"):format(L["Keystone Master Completion Status"]))
				for criteria = 1, 12 do
					local name, _, completed = GetAchievementCriteriaInfo(ksmId, criteria ~= 13 and criteria or 14)
					self:Print(("|cffffffff%s:|r %s"):format(name, completed and ("|cff00ff00%s|r"):format(L["Complete"]) or ("|cffff0000%s|r"):format(L["Incomplete"])))
				end
			end
		end
	end)
	self:RegisterChatCommand("ksc", function(args)
		local action = self:GetArgs(args)
		local _, name = GetAchievementInfo(kscId)
		if action == "track" then
			self:ToggleTracking(kscId)
		else 
			if completed[kscId] then
				self:Print((L["You have already completed %s."]):format(name))
			else
				self:Print(("|cffffff00%s|r"):format(L["Keystone Conqueror Completion Status"]))
				for criteria = 1, 12 do
					local name, _, completed = GetAchievementCriteriaInfo(kscId, criteria ~= 13 and criteria or 14)
					self:Print(("|cffffffff%s:|r %s"):format(name, completed and ("|cff00ff00%s|r"):format(L["Complete"]) or ("|cffff0000%s|r"):format(L["Incomplete"])))
				end
			end
		end
	end)
end

function Module:OnDisable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("ACHIEVEMENT_EARNED")
	self:UnregisterChatCommand("ksm")
	self:UnregisterChatCommand("ksc")
end

function Module:Info()
	return L["This module adds a command to check your progress on the Keystone Conqueror and Master achievements.\n\n|cff00ff00/ksc|r - Keystone Conqueror Progress\n|cff00ff00/ksm|r - Keystone Master Progress\nUse |cff00ff00track|r to toggle achievement tracking for each achievement."]
end
