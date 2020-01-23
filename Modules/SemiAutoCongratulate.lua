-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpotx (US, Lightbringer)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Semi-Auto Congratulate", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Semi-Auto Congratulate"]
Module.namespace = string.gsub(Module.name, " ", "")

local GetAchievementLink = _G["GetAchievementLink"]
local UnitIsAFK = _G["UnitIsAFK"]
local UnitIsDND = _G["UnitIsDND"]
local UnitName = _G["UnitName"]
local UnitInParty = _G["UnitInParty"]
local UnitInRaid = _G["UnitInRaid"]

local db, options
local defaults = {
	global = {
		afk = true,
		dnd = true,
		nearby = false,
		guild = true,
		party = false,
		raid = false
	}
}

function Module:Achievement(event, message, sender)
	local temp = {strsplit("-", sender)}
	local senderName = temp[1]

	-- don't run if afk/dnd and setting is enabled
	if db.afk and UnitIsAFK("player") then return end
	if db.dnd and UnitIsDND("player") then return end

	-- pull the achievement id from the message
	local id = message:match("|cffffff00|Hachievement:([0-9]+):.+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+:[%-0-9]+|h%[[^]]+%]|h|r")
	
	if event == "CHAT_MSG_ACHIEVEMENT" then
		-- nearby
		if db.nearby and not UnitInParty(sender) and not UnitInRaid(sender) then
		
		-- party
		elseif db.party and UnitInParty(sender) and not UnitInRaid(sender) then

		-- raid
		elseif db.raid and UnitInRaid(sender) then

		end
	elseif event == "CHAT_MSG_GUILD_ACHIEVEMENT" and db.guild then

	end
end

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_ACHIEVEMENT", "Achievement")
	self:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT", "Achievement")
end

function Module:OnDisable()
	self:UnregisterEvent("CHAT_MSG_ACHIEVEMENT")
	self:UnregisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Prints a link you can click to congratulate when someone obtains an achievement."]
end

function Module:GetOptions()
	if not options then
		options = {
			disableIf = {
				type = "group",
				order = 98,
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
						set = function(_, value) db.dnd = value end,
					},
				}
			},
			whoToGrts = {
				type = "group",
				order = 99,
				name = L["Who to Congratulate?"],
				guiInline = true,
				args = {
					nearby = {
						type = "toggle",
						name = L["Nearby People"],
						desc = L["Congratulate achievements earned by people near you."],
						get = function() return db.nearby end,
						set = function(_, value) db.nearby = value end
					},
					raid = {
						type = "toggle",
						name = L["Raid Members"],
						desc = L["Congratulate achievements earned by people in your raid."],
						get = function() return db.raid end,
						set = function(_, value) db.raid = value end,
					},
					guild = {
						type = "toggle",
						name = L["Guildmates"],
						desc = L["Congratulate achievements earned by guildmates."],
						get = function() return db.guild end,
						set = function(_, value) db.guild = value end,
					},
					party = {
						type = "toggle",
						name = L["Party Members"],
						desc = L["Congratulate achievements earned by people in your party."],
						get = function() return db.party end,
						set = function(_, value) db.party = value end,
					},
				},
			},
		}
	end
	return options
end