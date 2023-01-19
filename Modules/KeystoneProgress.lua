-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Keystone Progress", "AceConsole-3.0", "AceEvent-3.0")
local E, _, V, P, G = unpack(ElvUI)
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Keystone Progress"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

local pairs = _G["pairs"]

local AddTrackedAchievement = _G["AddTrackedAchievement"]
local C_ChallengeMode_GetOverallDungeonScore = C_ChallengeMode.GetOverallDungeonScore
local GetAchievementInfo = _G["GetAchievementInfo"]
local GetAchievementLink = _G["GetAchievementLink"]
local IsTrackedAchievement = _G["IsTrackedAchievement"]
local RemoveTrackedAchievement = _G["RemoveTrackedAchievement"]

local currentScore = 0
local dfks = {
	{
		id = 16647,
		req = 750,
		completed = false
	},
	{
		id = 16648,
		req = 1500,
		completed = false
	},
	{
		id = 16649,
		req = 2000,
		completed = false
	},
	{
		id = 16650,
		req = 2500,
		completed = false
	}
}

local function AchievementsCompleted()
	currentScore = C_ChallengeMode_GetOverallDungeonScore() or 0

	for i = 1, 4 do
		dfks[i].completed = select(4, GetAchievementInfo(dfks[i].id))
	end
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
	self:RegisterEvent("MYTHIC_PLUS_CURRENT_AFFIX_UPDATE", AchievementsCompleted)
	self:RegisterEvent("MYTHIC_PLUS_NEW_WEEKLY_RECORD", AchievementsCompleted)
	self:RegisterChatCommand("kprog", function(args)
		for i = 1, 4 do
			local completedStr = dfks[i].completed == true and ("|cff00ff00%s|r"):format(L["Complete"]) or ("|cffff0000%s|r"):format(L["Incomplete"])
			self:Print(("%s %s%s"):format(GetAchievementLink(dfks[i].id), completedStr, dfks[i].completed == true and "" or (" (%s %d)"):format(L["Short by"], (dfks[i].req - currentScore))))
		end
	end)
end

function Module:OnDisable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("ACHIEVEMENT_EARNED")
	self:UnregisterEvent("MYTHIC_PLUS_CURRENT_AFFIX_UPDATE")
	self:UnregisterEvent("MYTHIC_PLUS_NEW_WEEKLY_RECORD")
	self:UnregisterChatCommand("kprog")
end

function Module:Info()
	return L["This module adds a command to check your progress on the Keystone Conqueror and Master achievements.\n\n|cff00ff00/ksc|r - Keystone Conqueror Progress\n|cff00ff00/ksm|r - Keystone Master Progress\nUse |cff00ff00track|r to toggle achievement tracking for each achievement."]
end
