-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
-- Based on BadBoy by funkydude
local Module = ElvUI_ChatTweaks:NewModule("Battle.net Spam", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Battle.net Spam"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		logging = true,
	}
}

local function FindSpam(message, find, points, change)
	return message:find(find) and points + change or points
end

local function IsSpam(message, num)
	-- automatic spam list
	for i = 1, #Module.spam.instantReport do
		if message:find(Module.spam.instantReport[i]) then
			return true
		end
	end
	
	local points, phishPoints = num, num
	for i = 1, #Module.spam.whiteList do
		points = FindSpam(message, Module.spam.whiteList[i], points, -2)
		phishPoints = FindSpam(message, Module.spam.whiteList[i], phishPoints, -2)
	end
	
	for i = 1, #Module.spam.common do
		points = FindSpam(message, Module.spam.common[i], points, 1)
	end
	
	for i = 1, #Module.spam.heavy do
		points = FindSpam(message, Module.spam.heavy[i], points, 2)
	end
	
	for i = 1, #Module.spam.heavyRestricted do
		if message:find(Module.spam.heavyRestricted[i]) then
			points = points + 2
			phishPoints = phishPoints + 2
			break
		end
	end
	
	for i = 1, #Module.spam.phishing do
		phishPoints = FindSpam(message, Module.spam.phishing[i], phishPoints, 1)
	end
	
	-- >3 points for either means its spam
	if points > 3 or phishPoints > 3 then return true end
end

function Module:CHAT_MSG_BN_INLINE_TOAST_ALERT(event, bnEvent, ...)
	if bnEvent == "FRIEND_PENDING" then
		for i = BNGetNumFriendInvites(), 1, -1 do
			local id, player, _, message = BNGetFriendInviteInfo(i)
			if type(message) == "string" then
				local orig = message
				message = message:lower()
				
				-- strip spaces, symbols, etc.
				message = message:gsub("[“”%*%-%(%)\"`'_%+#%%%^&;:~{} ]+", "")
				message = message:gsub("¨", "")
				message = message:gsub("”", "")
				message = message:gsub("“", "")
				
				-- they like to replace English letters with UTF-8 "equivalents" to avoid detection
				if message:find("[аàáäâãåсçеèéëёêìíïîΜмоòóöōôõùúüû]+") then
					for index, value in pairs(Module.spam.replacements) do
						message = message:gsub(index, value)
					end
				end
				
				-- check for spam, and react accordingly
				if IsSpam(message, 0) then
					self:Print((L["Battle.net invite from %s%s|r blocked!"]):format(ElvUI_ChatTweaks.hexColor, player))
					BNReportFriendInvite(id, "SPAM", "")
					
					if db.logging and self.log:IsEnabled() then
						Module.log:AddToLog("bnet", "CHAT_MSG_BN_INVITE", player, orig)
					end
				end
			end
		end
	end
end

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_BN_INLINE_TOAST_ALERT")
	self.log = ElvUI_ChatTweaks:GetModule("Spam Log")
	self.spam = ElvUI_ChatTweaks:GetModule("Spam Filter")
end

function Module:OnDisable()
	self:UnregisterEvent("CHAT_MSG_BN_INLINE_TOAST_ALERT")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetDefaults()
	return defaults
end

function Module:Info()
	return L["Blocks Battle.net friend requests from spammers."]
end

function Module:GetOptions()
	if not options then
		options = {
			logging = {
				type = "toggle",
				order = 13,
				name = L["Enable Logging"],
				desc = L["Toggle logging anything found to the Spam Log module."],
				get = function() return db.logging end,
				set = function(_, value) db.logging = value end,
			},
		}
	end
	return options
end