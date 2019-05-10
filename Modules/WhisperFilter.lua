-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
-- Based on BadBoy_Levels by funkydude
local Module = ElvUI_ChatTweaks:NewModule("Whisper Filter", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Whisper Filter"]
Module.namespace = string.gsub(Module.name, " ", "")

local good, maybe, filterTable = {}, {}, {}
local login = true	-- to only run friends list update on login

local format = string.format

local whispString = L["ElvUI_ChatTweaks: You need to be level %d to whisper me.  Currently you are level %d!"]
local listError = L["You have reached the maximum number of friends, please remove 2 for this module to function properly."]

local db, options
local defaults = {
	global = {
		level = 2,
		dkLevel = 60,
		respond = true,
		mobile = true,
		logging = true,
	}
}

local function SystemFilter(_, _, message)
	if message == ERR_FRIEND_LIST_FULL then
		-- friends list is full
		Module:Print(listError)
		return
	end
	
	-- filter friend add/remove system messages that we'll be doing
	for k in pairs(filterTable) do
		if message == (ERR_FRIEND_ADDED_S):format(k) or message == (ERR_FRIEND_REMOVED_S):format(k) then
			return true
		end
	end
end

local function WhisperFilter(...)
	local player = select(4, ...)
	if UnitIsInMyGuild(player) or good[player] or player:find("%-") or select(8, ...) == "GM" then return end
	
	-- support for realid
	for i = 1, select(2, BNGetNumFriends()) do
		local toons = BNGetNumFriendToons(i)
		for j = 1, toons do
			local _, rName, rGame, rServer = BNGetFriendToonInfo(i, j)
			if rName == player and rGame == "WoW" and rServer == GetRealmName() then
				good[player] = true
				return
			end
		end
	end
	
	local f, id, guid = ..., select(13, ...), select(14, ...)
	local _, class = GetPlayerInfoByGUID(guid)
	-- determine level to be filtered
	local level = db.level and db.level + 1 or 2
	-- level is different for death knights since they start at level 55
	if class == "DEATHKNIGHT" then level = db.dkLevel and db.dkLevel + 1 or 56 end
	if not maybe[player] then maybe[player] = {} end
	-- one table per chat frame, in case multiple are used
	f = f:GetName()
	if IsAddOnLoaded("WIM") and not f:find("WIM") then return true end	-- compatibility for WIM
	if not maybe[player][f] then maybe[player][f] = {} end
	maybe[player][f][id] = {}
	local n = IsAddOnLoaded("WIM") and 2 or 0	-- more WIM compatibility
	for i = 1, select("#", ...) do
		-- store all the chat arguments incase we need to add it back (if it's a new good guy)
		maybe[player][f][id][i] = select(i + n, ...)
	end
	
	-- don't try to add a player to friends several times for 1 whisper (registered to more than 1 chat frame)
	if not filterTable[player] or filterTable[player] ~= level then
		filterTable[player] = level
		AddFriend(player, true)
	end
	return true
end

local function WhisperInformFilter(_, _, message, player)
	if good[player] then return end
	if filterTable[player] and message:find("^ElvUI_ChatTweaks.*" .. filterTable[player]) then return true end
	good[player] = true
end

function Module:PLAYER_LOGIN(self, event, ...)
	ShowFriends()	-- force a friendlist update
	good[UnitName("player")] = true	-- add ourself to safe list
end

function Module:FRIENDLIST_UPDATE(self, event, ...)
	if not login then
		login = true
		for i = 1, GetNumFriends() do
			local n = GetFriendInfo(i)
			if n then good[n] = true end
		end
		return
	end
	
	for i = 1, GetNumFriends() do
		local player, level = GetFriendInfo(i)
		if not player then
			ShowFriends()
		else
			if maybe[player] then
				RemoveFriend(player, true)
				if type(level) ~= "number" then
					-- something happened
					self:Print(format(L["Level wasn't a number, tell Lockslap. Level was |cffff0000%s|r!"], level))
					return
				end
				
				-- a mobile user
				-- NOTE: this is not an ideal method, but I can't figure out a way to determine if the whisper
				--		 is from a mobile user, so the best I can tell the level is 0 for a mobile user.
				if level == 0 then
					if db.mobile then
						-- whisper is allowed
						good[player] = true
						for _, v in pairs(maybe[player]) do
							for _, p in pairs(v) do
								if IsAddOnLoaded("WIM") then
									WIM.modules.WhisperEngine:CHAT_MSG_WHISPER(unpack(p))
								else
									ChatFrame_MessageEventHandler(unpack(p))
								end
								wipe(p)
							end
							wipe(v)
						end
					else
						-- block the whisper
						-- send a response
						if db.respond then
							SendChatMessage(whispString:format(filterTable[player], level), "WHISPER", nil, player)
						end
						
						-- log the event
						if db.logging and Module.log:IsEnabled() then
							Module.log:AddToLog("whisper", "CHAT_MSG_WHISPER", player, (L["Blocked Whisper from %s"]):format(player))
						end
						
						for _, v in pairs(maybe[player]) do
							for _, p in pairs(v) do
								wipe(p)
							end
							wipe(v)
						end
					end
				end
				
				if level < filterTable[player] then
					if db.respond then
						SendChatMessage(whispString:format(filterTable[player], level), "WHISPER", nil, player)
					end
					
					if db.logging and Module.log:IsEnabled() then
						Module.log:AddToLog("whisper", "CHAT_MSG_WHISPER", player, (L["Blocked Whisper from %s"]):format(player))
					end
					
					for _, v in pairs(maybe[player]) do
						for _, p in pairs(v) do
							wipe(p)
						end
						wipe(v)
					end
				else
					good[player] = true
					for _, v in pairs(maybe[player]) do
						for _, p in pairs(v) do
							if IsAddOnLoaded("WIM") then
								WIM.modules.WhisperEngine:CHAT_MSG_WHISPER(unpack(p))
							else
								ChatFrame_MessageEventHandler(unpack(p))
							end
							wipe(p)
						end
						wipe(v)
					end
				end
				wipe(maybe[player])
				maybe[player] = nil
			end
		end
	end
end

Module:RegisterEvent("PLAYER_LOGIN")
Module:RegisterEvent("FRIENDLIST_UPDATE")

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", SystemFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", WhisperFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", WhisperInformFilter)
	Module.log = ElvUI_ChatTweaks:GetModule("Spam Log")
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", SystemFilter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", WhisperFilter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", WhisperInformFilter)
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
	return L["Filter whispers based on the sender's level."]
end

function Module:GetOptions()
	if not options then
		options = {
			level = {
				type = "range",
				order = 13,
				name = L["Minimum Level"],
				desc = L["Minimum level for a non-Death Knight to be in order to whisper you."],
				get = function() return db.level end,
				set = function(_, value) db.level = value end,
				min = 1, max = GetMaxPlayerLevel(), step = 1,
			},
			dkLevel = {
				type = "range",
				order = 14,
				name = L["Minimum DK Level"],
				desc = L["Minimum level for a Death Knight to be in order to whisper you."],
				get = function() return db.dkLevel end,
				set = function(_, value) db.dkLevel = value end,
				min = 55, max = GetMaxPlayerLevel(), step = 1,
			},
			dummy = {
				type = "description",
				order = 15,
				width = "normal",
				name = "",
			},
			respond = {
				type = "toggle",
				order = 16,
				name = L["Respond to Whispers"],
				desc = L["Respond to whispers notifying them that they don't meet the level requirement."],
				get = function() return db.respond end,
				set = function(_, value) db.respond = value end,
			},
			mobile = {
				type = "toggle",
				order = 17,
				name = L["Allow Mobile Users"],
				desc = L["Allow users of the WoW's mobile app to whisper you."],
				get = function() return db.mobile end,
				set = function(_, value) db.mobile = value end,
			},
			logging = {
				type = "toggle",
				order = 18,
				name = L["Enable Logging"],
				desc = L["Toggle logging anything found to the Spam Log module."],
				get = function() return db.logging end,
				set = function(_, value) db.logging = value end,
			},
		}
	end
	return options
end