-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------

-- Module is based on Fake Achievement by lenwe-saralonde
local Module = ElvUI_ChatTweaks:NewModule("Fake Achievement", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Fake Achievement"]
Module.namespace = string.gsub(Module.name, " ", "")

local gsub, gmatch, find, match = string.gsub, string.gmatch, string.find, string.match

-- regex for the chat arguments
local idMatch = "([0-9]+)%s+([0-9]+)/([0-9]+)/([0-9]+)"
local linkMatch = "(.+)%s+([0-9]+)/([0-9]+)/([0-9]+)"
local achievementString = "|cffffff00|Hachievement:%d:%s:1:%d:%d:%d:4294967295:4294967295:4294967295:4294967295|h[%s]|h|r"
local extractAchieve = "|cffffff00|Hachievement:([0-9]+):.+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+|h%[([^]]+)%]|h|r"

function Module:OnEnable()
	self:RegisterChatCommand("fake", function(args)
		local id, month, day, year, aName, aLink, checkLink
		local hex = ElvUI_ChatTweaks.hexColor
		-- some info we need to generate the achievement completion link
		local guid = UnitGUID("target") ~= nil and UnitGUID("target") or UnitGUID("player")
		local name = UnitName("target") ~= nil and UnitName("target") or UnitName("player")
		guid = guid:gsub("0x", "") -- clean up the guid
		
		if args:find(idMatch) then
			-- extract data we need from args string
			id, month, day, year = args:match(idMatch)
			_, aName = GetAchievementInfo(id)
			
			if aName == nil then
				self:Print((L["Invalid achievement ID for %s%d|r."]):format(hex, id))
				return
			end
			
			self:Print((L["Achievement for %s%s|r: %s"]):format(hex, name, achievementString:format(id, guid, month, day, year, aName)))
		elseif args:find(linkMatch) then
			checkLink, month, day, year = args:match(linkMatch)
			
			if checkLink == nil then
				self:Print(L["Invalid achievement link provided."])
				return
			end
			
			local sID, sName = checkLink:match(extractAchieve)
			if sID == nil or sName == nil then
				self:Print(L["Invalid achievement link provided."])
				return
			end
			
			self:Print((L["Achievement for %s%s|r: %s"]):format(hex, name, achievementString:format(sID, guid, month, day, year, sName)))
		else
			print(L["|cffffff00Usage: /fake <id or link> <date in MM/DD/YY format>|r"])
		end
	end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("fake")
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds a |cff00ff00/fake|r command for generating fake achievements."]
end