-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Achievement Filter", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Achievement Filter"]
Module.namespace = string.gsub(Module.name, " ", "")

local format 	= string.format

local db, options
local defaults = {
	global = {
		guild = false,
		nearby = true,
		byLevel = true,
		level = 85,
	}
}

local achievement = format(ACHIEVEMENT_BROADCAST, "(.+)", ".+")
local playerLink = ("|Hplayer:%s|h[%s]|h"):format("(.+)", ".+")

local function DoFilter(self, event, message)
	if not message or (not db.guild and not db.nearby) then return end
	
	-- guild achievements
	if db.guild and event == "CHAT_MSG_GUILD_ACHIEVEMENT" and message:match(achievement) then
		if not db.byLevel then
			if Module.debug then Module:Print(message) end
			return true
		else
			-- determine level and filter
			local name = message:match(achievement)
			if not name then return true end -- can't pull name, so just filter
			if name:match(playerLink) then
				local temp = name:match(playerLink)
				name = temp
			end
			local level = UnitLevel(name)
			
			-- debugging
			if Module.debug then Module:Print((L["Level: |cffffff00%s|r, Message: |cffffff00%s|r"]):format(level, message)) end
			
			-- UnitLevel will return -1 if the character we queried is > 10 levels higher than the player
			if level == -1 then
				return true
			elseif level < db.level then
				return true
			else
				return false
			end
		end
	elseif db.nearby and event == "CHAT_MSG_ACHIEVEMENT" and message:match(achievement) then
		if not db.byLevel then
			if Module.debug then Module:Print(message) end
			return true	
		else
			-- determine level and filter
			local name = message:match(achievement)
			if not name then return true end -- can't pull name, so just filter
			if name:match(playerLink) then
				local temp = name:match(playerLink)
				name = temp
			end
			local level = UnitLevel(name)
			
			-- debugging
			if Module.debug then Module:Print((L["Level: |cffffff00%s|r, Message: |cffffff00%s|r"]):format(level, message)) end
			
			-- UnitLevel will return -1 if the character we queried is > 10 levels higher than the player
			if level == -1 then
				return true
			elseif level < db.level then
				return true
			else
				return false
			end
		end
	end
	
	return false
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", DoFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_ACHIEVEMENT", DoFilter)
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", DoFilter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_ACHIEVEMENT", DoFilter)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Filter achievement message spam!"]
end

function Module:GetOptions()
	if not options then
		options = {
			guild = {
				type = "toggle",
				order = 13,
				name = L["Filter Guild Achievements"],
				desc = L["Filter achievements earned by guildmates."],
				get = function() return db.guild end,
				set = function(_, value) db.guild = value end,
			},
			nearby = {
				type = "toggle",
				order = 14,
				name = L["Filter Nearby Achievements"],
				desc = L["Filter achievements earned by nearby people."],
				get = function() return db.nearby end,
				set = function(_, value) db.nearby = value end,
			},
			levelOptions = {
				type = "group",
				order = 100,
				guiInline = true,
				name = L["Filter by Player Level"],
				args = {
					byLevel = {
						type = "toggle",
						order = 1,
						name = L["Use Level Threshold"],
						desc = L["Only filter achievements earned by players below a certain level."],
						get = function() return db.byLevel end,
						set = function(_, value) db.byLevel = value end,
					},
					level = {
						type = "range",
						order = 2,
						name = L["Minimum Level"],
						desc = L["Minimum level required for an achievement to not be filtered."],
						disabled = function() return not db.byLevel end,
						get = function() return db.level end,
						set = function(_, value) db.level = value end,
						min = 1, max = GetMaxPlayerLevel(), step = 1,
					}
				}
			}
		}
	end
	return options
end