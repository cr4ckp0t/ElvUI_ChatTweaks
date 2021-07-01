-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Who Whispered Me", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Who Whispered Me"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

local GetNumFriends = _G["GetNumFriends"]
local GetFriendInfo = _G["GetFriendInfo"]
local GetNumGuildMembers = _G["GetNumGuildMembers"]
local GetGuildRosterInfo = _G["GetGuildRosterInfo"]
local SendWho = _G["SendWho"]

local format = string.format

local wsCMD = L["|cff00ff00%s|r %s"]

local lastplayers = {};

totallastplayers = {};

entries = 0;
local newWhisp = true;

local db, options
local defaults = {
	global = {
		friendWhisp = true,
		guildWhisp = true,
	}
}

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_WHISPER")
	self:RegisterChatCommand("ws", function() self:WhisperStats() end)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnDisable()
	self:UnregisterEvent("CHAT_MSG_WHISPER")
	self:UnregisterChatCommand("ws")
end

function Module:CHAT_MSG_WHISPER(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
	if totallastplayers["entries"] ~= nil then
	  local total = 0;
		totallastplayers["entries"] = nil;
		for k, v in pairs(totallastplayers) do
			total = total+1;
		end
	  entries = total;
	end
	name = arg3;

	if totallastplayers[name.."SentCount"] ~= nil then
	  if totallastplayers[name] == nil then
		totallastplayers[name] = totallastplayers[name.."SentCount"];
	  end
		totallastplayers[name.."SentCount"] = nil;
	end

	if(totallastplayers[name] == nil) then

		if(entries == nil) or entries == 0 then
		  entries = 1;
		else
		  entries = entries+1;
		end

	  totallastplayers[name] = 1;

	else
	  totallastplayers[name] = totallastplayers[name]+1;
	end

  --newWhisp = true; -- Its a 'new whisperer'
	if not db.friendWhisp then -- if I want to not see friends whod
		for i = 1, GetNumFriends() do -- get friends names(friends 1-# of friends)
			if GetFriendInfo(i) == name then -- They are on friends list
				newWhisp = false; -- Not a whisper I want to see
				break
			else -- Not on friends list
			end --if GetFriendInfo
		end -- end for loop
	end --end if/else(if FriendsWhisper == OFF)

    if not db.guildWhisp then -- I dont want to see guild members whod
		for i = 1, GetNumGuildMembers(1) do
			if GetGuildRosterInfo(i) == name then
				newWhisp = false;
				break
			end -- end if on guild roster
		end --end for loop
	end --end if guildWhisp

	 if newWhisp == true then
		if not lastplayers[name] then
			SendWho(name);
			lastplayers[name] = true;
		end
	end --new whisper
	newWhisp = true;
end

function Module:WhisperStats()
	if entries == 0 then
		ElvUI_ChatTweaks:Print("You have never been whispered!");
	else
		local highest = -1;
		local index = nil;
		for k, v in pairs(totallastplayers) do
			if v > highest then
				highest = v;
				index = k;
			end
		end
		ElvUI_ChatTweaks:Print(""..entries.." people have whispered you!");
		ElvUI_ChatTweaks:Print("The player who has whispered you the most is: " .. index ..". They have whispered you ".. highest.." times!");
	end
end

function Module:GetOptions()
	if not options then
		options = {
			friendWhisp = {
				order = 15,
				type = "toggle",
				name = L["Friends Whispers"],
				desc = L["Enables the whoing of friends."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
			guildWhisp = {
				order = 16,
				type = "toggle",
				name = L["Guild Whispers"],
				desc = L["Enables the whoing of Guildmates."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Instantly send the information of whom whispered you.\n\n"] .. format(wsCMD, "/ws", L["Show how many whispers, you've received this session."])
end
