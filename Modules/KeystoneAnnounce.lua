-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Keystone Announce", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Keystone Announce"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

local C_Club_GetGuildClubId = C_Club.GetGuildClubId
local C_Club_GetSubscribedClubs = C_Club.GetSubscribedClubs
local C_Club_GetStreams = C_Club.GetStreams
local C_Club_FocusStream = C_Club.FocusStream
local UnitFullName = _G["UnitFullName"]
local GetContainerNumSlots = _G["GetContainerNumSlots"]
local GetContainerItemID = _G["GetContainerItemID"]
local GetContainerItemLink = _G["GetContainerItemLink"]
local C_Club_SendMessage = C_Club.SendMessage
local IsInGroup = _G["IsInGroup"]
local UIDropDownMenu_Initialize = _G["UIDropDownMenu_Initialize"]
local UIDropDownMenu_CreateInfo = _G["UIDropDownMenu_CreateInfo"]
local UIDropDownMenu_AddButton = _G["UIDropDownMenu_AddButton"]
local UIDropDownMenu_SetSelectedName = _G["UIDropDownMenu_SetSelectedName"]
local UIDropDownMenu_SetText = _G["UIDropDownMenu_SetText"]
local CloseDropDownMenus = _G["CloseDropDownMenus"]

local KeystoneID = 158923 -- m+ keystone id
local keystone = nil
local table1 = nil
local communitys = {}
local communitysLine = {}
local TempName = nil
local TempID = nil
local TempName2 = nil
local TempID2 = nil
local SpamCooldown = nil
local DuringMpRun = nil

local db, options
local defaults = {
	global = {
		inGuild = true,
		inParty = true,
		--inCommunity = false,
		--channelname = "",
		channelid = "",
		lastCooldownCommunity = 0,
		lastCooldownParty = 0,
		lastCooldownGuild = 0,
		SpamCdTime = "30",
		skipResponse = false,
		printedOnce = false,
	}
}

function Module:OnEnable()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("CHALLENGE_MODE_RESET")
	self:RegisterEvent("CHALLENGE_MODE_START")
	self:RegisterEvent("CHALLENGE_MODE_COMPLETED")
	--self:RegisterEvent("INITIAL_CLUBS_LOADED")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnDisable()
	self:UnregisterAllEvents()
end

local function getClubs()
	local GuildClubID = C_Club_GetGuildClubId()
	table1 = C_Club_GetSubscribedClubs(); 
	for in1, da1 in ipairs(table1) do 
		for key, value in pairs(da1) do 		
			if key == "name" then
				TempName = value
			end
			if key == "clubId" then
				TempID = value
			end			
		end
		
		local TEMPTABLE = C_Club_GetStreams(TempID)
		
		for in2, da2 in ipairs(TEMPTABLE) do
			for key, value in pairs(da2) do 			
				if key == "name" then
					TempName2 = value
				end
				if key == "streamId" then
					TempID2 = value
				end				
			end	
						
			if GuildClubID ~= TempID then
				communitysLine = string.format("%s-%s|%s:%s", TempName, TempName2, TempID, TempID2)			
				table.insert(communitys, communitysLine)
			end		
		end
	end
end

local function SetFocus(ClubStreamID)
	local t1 = nil
	local First = nil
	local Second = nil

	if ClubStreamID ~= nil and ClubStreamID ~= "" then
		if ClubStreamID == "ALL" then	
			if table.getn(communitys) == 0 then
				getClubs()
			end		
			for comIndex, comData in ipairs(communitys) do 
				First, Second = comData:match("([^,]+)|([^,]+)")
				clubID, StreamID = Second:match("([^,]+):([^,]+)")	
				t1 = C_Club_FocusStream(clubID, StreamID)
			end
		else
			First, Second = ClubStreamID:match("([^,]+):([^,]+)")	
			t1 = C_Club_FocusStream(First, Second)
		end
	end
end

local function keypost(force, guild, community, streamid)
	local fullName, realm = UnitFullName("player")
	--keystone = nil -- reset Keystone
	for bag = 0, NUM_BAG_SLOTS do
        local numSlots = GetContainerNumSlots(bag)
        for slot = 1, numSlots do
            if (GetContainerItemID(bag, slot) == KeystoneID) then
                local link = GetContainerItemLink(bag, slot)		
				if force or (keystone and keystone ~= link) then
                    local message = string.format("%s-%s: %s", fullName, realm, link)	
					if (community ~= nil) and (streamid ~= nil) then	
						C_Club_SendMessage(community, streamid, message);
						return
					end						
					if guild then
                        SendChatMessage(link, "GUILD")
                    else
                        SendChatMessage(link, "PARTY")
                    end                    
                end
                --keystone = link
                return
            end
        end
    end
end

function Module:MoreEvents()
	if DuringMpRun ~= true then
		if db.inGuild then
			self:RegisterEvent("CHAT_MSG_GUILD")
		else
			self:UnregisterEvent("CHAT_MSG_GUILD")
		end
				
		--[[if db.inCommunity then
			self:RegisterEvent("CLUB_MESSAGE_ADDED")
		else
			self:UnregisterEvent("CLUB_MESSAGE_ADDED")
		end]]
				
		--local inInstance, instanceType = IsInInstance()		
		--local isInstanceGroup = IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
		--local isPartyGroup = IsInGroup()		
				
		if db.inParty then
			self:RegisterEvent("CHAT_MSG_PARTY")
			self:RegisterEvent("CHAT_MSG_PARTY_LEADER")
		else
			self:UnregisterEvent("CHAT_MSG_PARTY")
			self:UnregisterEvent("CHAT_MSG_PARTY_LEADER")
		end
	end
end

local function getBoolean(val)
	if val then
		return true
	else
		return false
	end
end

function Module:CHAT_MSG_GUILD()
	local TimeGuild = GetTime()
	local NewTimeGuild = TimeGuild + tonumber(db.SpamCdTime)
	if select(1) == "!ctk" or select(1) == "!keys" then
			if tonumber(db.lastCooldownGuild) < TimeGuild then
				keypost(true,true,nil,nil)
				db.lastCooldownGuild = NewTimeGuild
			end
    end	
end

function Module:CHAT_MSG_PARTY()
	local TimeParty = GetTime()
	local NewTimeParty = TimeParty+tonumber(db.SpamCdTime)
	if select(1) == "!ctk" or select(1) == "!keys" then
		if tonumber(db.lastCooldownParty) < TimeParty then
			keypost(true, nil, nil, nil)
			db.lastCooldownParty = NewTimeParty
		end
    end	
end

function Module:CHAT_MSG_PARTY_LEADER()
	local TimeParty = GetTime()
	local NewTimeParty = TimeParty+tonumber(db.SpamCdTime)
	if select(1) == "!ctk" or select(1) == "!keys" then
		if tonumber(db.lastCooldownParty) < TimeParty then
			keypost(true, nil, nil, nil)
			db.lastCooldownParty = NewTimeParty
		end
    end	
end

function Module:CLUB_MESSAGE_ADDED()
	local clubId, streamId, messageId
	local GuildClubID = C_Club_GetGuildClubId()
	local Time = GetTime()
	local NewTime = Time+tonumber(db.SpamCdTime)
	local Info = C_Club.GetMessageInfo(clubId, streamId, messageId)
	
	if tostring(clubId) ~= tostring(GuildClubID) then
		if tonumber(db.lastCooldownCommunity) < Time then
			if db.channelid ~= "ALL" then
			
				local one1, two1 = db.channelid:match("([^,]+):([^,]+)")
				--SetFocus(db.channelid) -- Temp disabled
				if tostring(clubId) == tostring(one1) then
					if tostring(streamId) == tostring(two1) then
						if Info.content == "!ctk" or Info.content == "!keys" then
							keypost(true, nil, clubId, streamId)
							db.lastCooldownCommunity = NewTime
						end
					end
				end
			else
				if Info.content == "!ctk" or Info.content == "!keys" then
					keypost(true, nil, clubId, streamId)
					db.lastCooldownCommunity = NewTime
				end
			end
		end
	else
		return
	end	
	
end

function Module:INITIAL_CLUBS_LOADED()	
	SetFocus(db.channelid)
end

function Module:PLAYER_ENTERING_WORLD()
	DuringMpRun = false
	Module:MoreEvents()
end

function Module:PLAYER_LOGIN()
	db.lastCooldownCommunity = "0"
	db.lastCooldownParty = "0"
	db.lastCooldownGuild = "0"
end

function Module:CHALLENGE_MODE_RESET()

end

function Module:CHALLENGE_MODE_START()
	DuringMpRun = true
	if db.skipResponse == true then
		self:UnregisterEvent("CHAT_MSG_GUILD")
		self:UnregisterEvent("CHAT_MSG_PARTY")
		self:UnregisterEvent("CHAT_MSG_PARTY_LEADER")
		self:UnregisterEvent("CLUB_MESSAGE_ADDED")
	end	
end

function Module:CHALLENGE_MODE_COMPLETED()
	DuringMpRun = false
	Module:MoreEvents()
end

--[[function Module:UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
	local info = UIDropDownMenu_CreateInfo()
	
	info.text, info.arg1, info.arg2, info.checked = L["AllCommunity"], L["AllCommunity"], "ALL", false
	info.func = self.SetValue
	UIDropDownMenu_AddButton(info, level)
	
	
		if table.getn(communitys) == 0 then
			getClubs()
		end
	
		for in2, da2 in ipairs(communitys) do 
			one, two = da2:match("([^,]+)|([^,]+)")	
			info.func = self.SetValue
			info.text, info.arg1, info.arg2, info.checked = one, one, two, false
			UIDropDownMenu_AddButton(info, level)
			UIDropDownMenu_SetSelectedName(dropDown, db.channelname, true) 
		end
	end)

	function dropDown:SetValue(text, arg1, arg2, checked)
	db.channelname = text
	db.channelid = arg1
	UIDropDownMenu_SetText(dropDown, text)
	CloseDropDownMenus()
	end
end]]

function Module:GetOptions()
	if not options then
		options = {
			inParty = {
				order = 15,
				type = "toggle",
				name = L["Party"],
				desc = L["Activate in 5-man instances."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value; end,
			},
			inGuild = {
				order = 16,
				type = "toggle",
				name = L["Guild"],
				desc = L["Activate in guild."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value; end,
			},
			SpamCdTime = {
				order = 17,
				type = "input",
				name = L["Spam CoolDown"],
				desc = L["Enter a value in seconds."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value; end,
			},
			space1 = {
				order = 18,
				type = "description",
				name = "",
			},
			--[[inCommunity = {
				order = 19,
				type = "toggle",
				name = L["Active in your selected community"],
				--desc = L[""],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value; end,
			},
			channelname = {
				order = 20,
				type = "select",
				name = L["Available communities"],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value; end,
			},]]
			skipResponse = {
				order = 21,
				type = "toggle",
				name = L["Silence in M+"],
				desc = L["Do not reply while in M+ dungeons."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value; end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["This module keeps watch on your chat for certain commands and responds accordingly.\nType |cff00ff96!ctk|r or |cff00ff96!keys|r to pull keystone information."]
end
