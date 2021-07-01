-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Who Taunted", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Who Taunted"]
Module.namespace = string.gsub(Module.name, " ", "")

local UnitName = _G["UnitName"]
local CombatLogGetCurrentEventInfo = _G["CombatLogGetCurrentEventInfo"]
local GetServerTime = _G["GetServerTime"]
local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit
local UnitIsPlayer = _G["UnitIsPlayer"]
local UnitInParty = _G["UnitInParty"]
local UnitInRaid = _G["UnitInRaid"]
local GetSpellLink = _G["GetSpellLink"]
local GetSpellInfo = _G["GetSpellInfo"]
local GetClassColor = _G["GetClassColor"]
local IsInRaid = _G["IsInRaid"]
local GetNumGroupMembers = _G["GetNumGroupMembers"]
local UnitIsGroupLeader = _G["UnitIsGroupLeader"]
local UnitIsGroupAssistant = _G["UnitIsGroupAssistant"]
local GetNumSubgroupMembers = _G["GetNumSubgroupMembers"]
local GetChannelName = _G["GetChannelName"]
local GetChatWindowChannels = _G["GetChatWindowChannels"]
local GetChatWindowInfo = _G["GetChatWindowInfo"]
local UnitClass = _G["UnitClass"]

local PlayerName, PlayerRealm = UnitName("player");
local BgDisable = false;
local DisableInPvPZone = false;
local TauntData = {};
local RecentTaunts = {};
local TauntsList = {
	SingleTarget = {
		--Warrior
		355, --Taunt

		--Death Knight
		51399, --Death Grip for Blood (49576 is now just the pull effect)
		56222, --Dark Command

		--Paladin
		62124, --Hand of Reckoning

		--Druid
		6795, --Growl

		--Hunter
		20736, --Distracting Shot

		--Monk
		115546, --Provoke

		--Demon Hunter
		185245, --Torment
	},
	AOE = {
		--Paladin
		204079, --Final Stand
	},
};
local TauntTypes = {
	Normal = "Normal",
	AOE = "AOE",
	Failed = "Failed",
};
local PvPZoneIDs = {
	588, --Ashran
	589, --Ashran
	123, --Wintergrasp
	244, --Tol Barad
	245, --Tol Barad Peninsula
};

Module.OutputTypes = {
	Self = L["Self"],
	Party = L["Party"],
	Raid = L["Raid"],
	RaidWarning = L["Raid Warning"],
	Say = L["Say"],
	Yell = L["Yell"],
};

local db, options
local defaults = {
	global = {
		whotaunted = {
			disable = false,
		},
		DisableInBG = true,
		DisableInPvPZone = true,
		ChatWindow = "",
		HideOwnTaunts = false,
		HideOwnFailedTaunts = false,
		Prefix = true,
		DisplayAbility = true,
		AnounceTaunts = true,
		AnounceTauntsOutput = Module.OutputTypes.Say,
		AnounceAOETaunts = true,
		AnounceAOETauntsOutput = Module.OutputTypes.Say,
		AnounceFails = true,
		AnounceFailsOutput = Module.OutputTypes.Say,
	}
}

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "EnteringWorldOnEvent")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "RegenEnabledOnEvent")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneChangedOnEvent")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CombatLog")
end

function Module:OnEnable()
	db.whotaunted.disable = false
	if (type(tonumber(db.AnounceTauntsOutput)) == "number") or (type(tonumber(db.AnounceAOETauntsOutput)) == "number") or (type(tonumber(db.AnounceFailsOutput)) == "number") then
		db.AnounceTauntsOutput = Module.OutputTypes.Self;
		db.AnounceAOETauntsOutput = Module.OutputTypes.Self;
		db.AnounceFailsOutput = Module.OutputTypes.Self;
	end
end

function Module:OnDisable()
	db.whotaunted.disable = true
	self:UnregisterAllEvents();
	Module:ClearRecentTaunts();
end

function Module:CombatLog(self, event, ...)
	local timestamp, subEvent, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2, spellID, spellName, spellSchool, extraSpellID, extraSpellName, extraSpellSchool, auraType = CombatLogGetCurrentEventInfo();
	Module:DisplayTaunt(subEvent, srcName, spellID, dstName, extraSpellID, GetServerTime());
end

function Module:EnteringWorldOnEvent(event, ...)
	local inInstance, instanceType = IsInInstance();
	if (inInstance == true) and (instanceType == "pvp") and (db.DisableInBG == true) then
		BgDisable = true;
	else
		BgDisable = false;
	end
	Module:ClearRecentTaunts();
end

function Module:RegenEnabledOnEvent(event, ...)
	Module:ClearRecentTaunts();
end

function Module:ZoneChangedOnEvent(event, ...)
	local mapID = C_Map_GetBestMapForUnit("player");
	if (Module:IsPvPZone(mapID) == true) and (db.DisableInPvPZone == true) then
		DisableInPvPZone = true;
	else
		DisableInPvPZone = false;
	end
end

function Module:DisplayTaunt(Event, Name, ID, Target, FailType, Time)
	if (Event) and (Name) and (ID) and (Time) and (Module:IsRecentTaunt(Name, ID, Time) == false) then
		if (db.whotaunted.disable == false) and (BgDisable == false) and (DisableInPvPZone == false) and (UnitIsPlayer(Name)) and ((UnitInParty("player")) or (UnitInRaid("player"))) and ((UnitInParty(Name)) or (UnitInRaid(Name))) then
			local OutputMessage = nil;
			local IsTaunt, TauntType;
			local OutputType;

			--Ignore Death Grip Pull Effect for non-Blood Specs
			if (ID == 49576) then
				return;
			end

			if (Event == "SPELL_AURA_APPLIED") then
				IsTaunt, TauntType = Module:IsTaunt(ID);
				if (not Target) or (not IsTaunt) or ((TauntType == TauntTypes.Normal) and (db.AnounceTaunts == false)) or ((TauntType == TauntTypes.AOE) and (db.AnounceAOETaunts == false)) or ((db.HideOwnTaunts == true) and (Name == PlayerName)) then
					return;
				end
				OutputType = Module:GetOutputType(TauntType);
				local Spell = GetSpellLink(ID);
				if (not Spell) then
					Spell = GetSpellInfo(ID);
				end

				if (TauntType == TauntTypes.Normal) then
					OutputMessage = Module:OutputMessageNormal(Name, Target, Spell, OutputType);
				elseif (TauntType == TauntTypes.AOE) then
					OutputMessage = Module:OutputMessageAOE(Name, Target, Spell, ID, OutputType);
				end
			elseif (Event == "SPELL_CAST_SUCCESS") then
				IsTaunt, TauntType = Module:IsTaunt(ID);
				if (not Target) or (not IsTaunt) or (TauntType == TauntTypes.Normal) or ((TauntType == TauntTypes.AOE) and (db.AnounceAOETaunts == false)) or ((db.HideOwnTaunts == true) and (Name == PlayerName)) then
					return;
				end
				OutputType = Module:GetOutputType(TauntType);
				local Spell = GetSpellLink(ID);
				if (not Spell) then
					Spell = GetSpellInfo(ID);
				end

				if (TauntType == TauntTypes.Normal) then
					OutputMessage = Module:OutputMessageNormal(Name, Target, Spell, OutputType);
				elseif (TauntType == TauntTypes.AOE) then
					OutputMessage = Module:OutputMessageAOE(Name, Target, Spell, ID, OutputType);
				end
			elseif (Event == "SPELL_MISSED") then
				IsTaunt, TauntType = Module:IsTaunt(ID);
				if (not Target) or (not FailType) or (not IsTaunt) or ((TauntType == TauntTypes.Normal) and (db.AnounceTaunts == false)) or ((TauntType == TauntTypes.AOE) and (db.AnounceAOETaunts == false)) or ((db.HideOwnTaunts == true) and (Name == PlayerName)) then
					return;
				end
				TauntType = TauntTypes.Failed;
				OutputType = Module:GetOutputType(TauntType);
				local Spell = GetSpellLink(ID);
				if (not Spell) then
					Spell = GetSpellInfo(ID);
				end
				OutputMessage = Module:OutputMessageFailed(Name, Target, Spell, ID, OutputType, FailType);
			else
				return;
			end
			if (OutputMessage) and (TauntType) then
				if (OutputType ~= Module.OutputTypes.Self) then
					if (db.Prefix == true) then
						OutputMessage = L["<ElvUI_CTC>"].." "..OutputMessage;
					end
				end
				Module:AddRecentTaunt(Name, ID, Time);
				Module:OutPut(OutputMessage:trim(), OutputType);
			end
		end
	end
end

function Module:IsTaunt(SpellID)
	local IsTaunt, TauntType = false, "";
	for k, v in pairs(TauntsList.SingleTarget) do
		if (GetSpellInfo(v) == GetSpellInfo(SpellID)) then
			IsTaunt, TauntType = true, TauntTypes.Normal;
			break;
		end
	end
	for k, v in pairs(TauntsList.AOE) do
		if (GetSpellInfo(v) == GetSpellInfo(SpellID)) then
			IsTaunt, TauntType = true, TauntTypes.AOE;
			break;
		end
	end
	return IsTaunt, TauntType;
end

function Module:IsPvPZone(MapID)
	local IsPvPZone = false;
	if (MapID) and (type(MapID) == "number") then
		for k, v in pairs(PvPZoneIDs) do
			if (MapID == v) then
				IsPvPZone = true;
				break;
			end
		end
	end
	return IsPvPZone;
end

function Module:AddRecentTaunt(TauntName, TauntID, TauntTime)
	if (TauntName) and (TauntID) and (TauntTime) and (type(TauntTime) == "number") then
		table.insert(RecentTaunts,{
			Name = TauntName,
			ID = TauntID,
			TimeStamp = TauntTime,
		});
	end
end

function Module:IsRecentTaunt(TauntName, TauntID, TauntTime)
	local IsRecentTaunt = false;

	if (TauntName) and (TauntID) and (TauntTime) and (type(TauntTime) == "number") then
		for k, v in pairs(RecentTaunts) do
			if (RecentTaunts[k].Name == TauntName) and (GetSpellInfo(RecentTaunts[k].ID) == GetSpellInfo(TauntID)) and (RecentTaunts[k].TimeStamp == TauntTime) then
				IsRecentTaunt = true;
				break;
			end
		end
	end

	return IsRecentTaunt;
end

function Module:ClearRecentTaunts()
	RecentTaunts = table.wipe(RecentTaunts);
end

function Module:OutputMessageNormal(Name, Target, Spell, OutputType)
	local OutputMessage = nil;

	OutputMessage = "lc1"..Name.."lr1 "..L["taunted"].." "..Target;
	if (db.DisplayAbility == true) then
		OutputMessage = OutputMessage.." "..L["using"].." "..Spell..".";
	else
		OutputMessage = OutputMessage..".";
	end

	if (OutputType == Module.OutputTypes.Self) then
		OutputMessage = OutputMessage:gsub("lc1", "|c"..Module:GetClassColor(Name)):gsub("lr1", "|r");
	else
		OutputMessage = OutputMessage:gsub("lc1", ""):gsub("lr1", "");
	end

	return OutputMessage;
end

function Module:OutputMessageAOE(Name, Target, Spell, ID, OutputType)
	local OutputMessage = nil;

	OutputMessage = "lc1"..Name.."lr1 "..L["AOE"].." "..L["taunted"];
	if (db.DisplayAbility == true) then
		OutputMessage = OutputMessage.." "..L["using"].." "..Spell..".";
	else
		OutputMessage = OutputMessage..".";
	end

	if (OutputType == Module.OutputTypes.Self) then
		OutputMessage = OutputMessage:gsub("lc1", "|c"..Module:GetClassColor(Name)):gsub("lr1", "|r"):gsub("lc2", "|c"..Module:GetClassColor(Target)):gsub("lr2", "|r");
	else
		OutputMessage = OutputMessage:gsub("lc1", ""):gsub("lr1", ""):gsub("lc2", ""):gsub("lr2", "");
	end

	return OutputMessage;
end

function Module:OutputMessageFailed(Name, Target, Spell, ID, OutputType, FailType)
	local OutputMessage = nil;

	OutputMessage = "lc1"..Name..L["'s"].."lr1 "..L["taunt"];
	if (db.DisplayAbility == true) then
		OutputMessage = OutputMessage.." "..Spell;
	end
	OutputMessage = OutputMessage.." "..L["against"].." "..Target.." lc2"..string.upper(L["Failed:"].." "..FailType).."lr2!";

	if (OutputType == Module.OutputTypes.Self) then
		OutputMessage = OutputMessage:gsub("lc1", "|c"..Module:GetClassColor(Name)):gsub("lr1", "|r"):gsub("lc2", "|c00FF0000"):gsub("lr2", "|r");
	else
		OutputMessage = OutputMessage:gsub("lc1", ""):gsub("lr1", ""):gsub("lc2", ""):gsub("lr2", "");
	end

	return OutputMessage;
end

function Module:OutPut(msg, output, dest)
	if (not output) or (output == "") then
		output = Module.OutputTypes.Self;
	end
	if (msg) then
		if (string.lower(output) == "raid") then
			if (IsInRaid()) and (GetNumGroupMembers() >= 1) then
				ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "RAID");
			end
		elseif (string.lower(output) == "raidwarning") or (string.lower(output) == "rw") then
			if (IsInRaid()) and (GetNumGroupMembers() >= 1) then
				local isLeader = UnitIsGroupLeader("player");
				local isAssistant = UnitIsGroupAssistant("player");
				if ((isLeader) and (isLeader == true)) or ((isAssistant) and (isAssistant == true)) then
					ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "RAID_WARNING");
				else
					ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "RAID");
				end
			end
		elseif (string.lower(output) == "party") then
			local isInParty = UnitInParty("player");
			if (isInParty) and (isInParty == true) and (GetNumSubgroupMembers() >= 1) then
				ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "PARTY");
			end
		elseif (string.lower(output) == "say") then
			ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "SAY");
		elseif (string.lower(output) == "yell") then
			ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "YELL");
		elseif (string.lower(output) == "whisper") and (dest) then
			ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "WHISPER", nil, dest);
		elseif (string.lower(output) == "guild") then
			ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "GUILD");
		elseif (string.lower(output) == "officer") then
			ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "OFFICER");
		elseif (string.lower(output) == "channel") and (dest) and (Module:IsChatChannel(dest) == true) then
			local id, name = GetChannelName(dest);
			if (id > 0) and (name ~= nil) then
				ChatThrottleLib:SendChatMessage("NORMAL", "Module", tostring(msg), "CHANNEL", nil, id);
			end
		elseif (string.lower(output) == "print") or (string.lower(output) == "self") then
			if (Module:IsChatWindow(db.ChatWindow) == true) then
				Module:PrintToChatWindow(tostring(msg), db.ChatWindow)
			else
				db.ChatWindow = "";
				Module:Print(tostring(msg));
			end
		end
	end
end

function Module:GetOutputType(TauntType)
	local OutputType = Module.OutputTypes.Self;
	if (TauntType == TauntTypes.Normal) then
		OutputType = db.AnounceTauntsOutput;
	elseif (TauntType == TauntTypes.AOE) then
		OutputType = db.AnounceAOETauntsOutput;
	elseif (TauntType == TauntTypes.Failed) then
		OutputType = db.AnounceFailsOutput;
	end
	return OutputType;
end

function Module:IsChatChannel(ChannelName)
	local IsChatChannel = false;
	for i = 1, NUM_CHAT_WINDOWS, 1 do
		for k, v in pairs({ GetChatWindowChannels(i) }) do
			if (string.lower(tostring(v)) == string.lower(tostring(ChannelName))) then
				IsChatChannel = true;
				break;
			end
		end
		if (IsChatChannel == true) then
			break;
		end
	end
	return IsChatChannel;
end

function Module:GetChatWindows()
	local ChatWindows = {};
	for i = 1, NUM_CHAT_WINDOWS, 1 do
		local name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(i);
		if (name) and (tostring(name) ~= COMBAT_LOG) and (name:trim() ~= "") then
			ChatWindows[tostring(name)] = tostring(name);
		end
	end
	return ChatWindows;
end

function Module:IsChatWindow(ChatWindow)
	local IsChatWindow = false;
	for i = 1, NUM_CHAT_WINDOWS, 1 do
		local name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(i);
		if (name) and (name:trim() ~= "") and (tostring(name) == tostring(ChatWindow)) then
			IsChatWindow = true;
			break;
		end
	end
	return IsChatWindow;
end

function Module:PrintToChatWindow(message, ChatWindow)
	for i = 1, NUM_CHAT_WINDOWS, 1 do
		local name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(i);
		if (name) and (name:trim() ~= "") and (tostring(name) == tostring(ChatWindow)) then
			Module:Print(_G["ChatFrame"..i], tostring(message));
		end
	end
end

function Module:GetClassColor(Unit)
	local localizedclass = nil;
	local ClassColor = nil;
	if (Unit) then
		localizedclass = UnitClass(Unit);
		if (localizedclass) then
			if (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["DEATHKNIGHT"])) then
				ClassColor = "00C41F3B";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["DRUID"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["DRUID"])) then
				ClassColor = "00FF7D0A";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["HUNTER"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["HUNTER"])) then
				ClassColor = "00ABD473";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["MAGE"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["MAGE"])) then
				ClassColor = "0069CCF0";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["MONK"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["MONK"])) then
				ClassColor = "0000FF96";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["PALADIN"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["PALADIN"])) then
				ClassColor = "00F58CBA";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["PRIEST"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["PRIEST"])) then
				ClassColor = "00FFFFFF";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["ROGUE"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["ROGUE"])) then
				ClassColor = "00FFF569";
				elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["DEMONHUNTER"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["DEMONHUNTER"])) then
				ClassColor = "00A330C9";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["SHAMAN"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["SHAMAN"])) then
				ClassColor = "002459FF";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["WARLOCK"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["WARLOCK"])) then
				ClassColor = "009482CA";
			elseif (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_MALE["WARRIOR"])) or (string.lower(localizedclass) == string.lower(LOCALIZED_CLASS_NAMES_FEMALE["WARRIOR"])) then
				ClassColor = "00C79C6E";
			end
		end
	end

	if (ClassColor == nil) then
		ClassColor = "00FFFFFF";
	end

	return ClassColor;
end

function Module:GetOptions()
	if not options then
		options = {
			General = {
				order = 30,
				type = "group",
				name = L["General"],
				guiInline = true,
				args = {
					DisableInBG = {
						type = "toggle",
						name = L["Disable in Battlegrounds"],
						desc = L["Disables while you are in a battleground."],
						get = function(info) return db.DisableInBG; end,
						set = function(info, v)
							db.DisableInBG = v;
							Module:EnteringWorldOnEvent();
						end,
						order = 10
					},
					DisableInPvPZone = {
						type = "toggle",
						name = L["Disable in PvP Zones"],
						desc = L["Disables while you are in PvP Zones such as Ashran."],
						get = function(info) return db.DisableInPvPZone; end,
						set = function(info, v)
							db.DisableInPvPZone = v;
							Module:ZoneChangedOnEvent();
						end,
						order = 10
					},
					ChatWindow = {
						type = "select",
						values = Module:GetChatWindows(),
						name = L["Chat Window"],
						desc = L["The chat window taunts will be announced in when the output is set to"].." "..Module.OutputTypes.Self..".",
						get = function(info) return db.ChatWindow; end,
						set = function(info, v) db.ChatWindow = v; end,
						order = 20
					},
					HideOwnTaunts = {
						type = "toggle",
						name = L["Hide Own Taunts"],
						desc = L["Don't show your own taunts."],
						get = function(info) return db.HideOwnTaunts; end,
						set = function(info, v) db.HideOwnTaunts = v; end,
						order = 40
					},
					HideOwnFailedTaunts = {
						type = "toggle",
						name = L["Hide Own Failed Taunts"],
						desc = L["Don't show your own failed taunts."],
						get = function(info) return db.HideOwnFailedTaunts; end,
						set = function(info, v) db.HideOwnFailedTaunts = v; end,
						order = 50
					},
					Prefix = {
						type = "toggle",
						name = L["Include Prefix"],
						desc = L["Include the"].." '"..L["<ElvUI_CTC>"].."' "..L["prefix when a message's output is"].." "..Module.OutputTypes.Party..", "..Module.OutputTypes.Raid..", "..L["etc"]..".",
						get = function(info) return db.Prefix; end,
						set = function(info, v) db.Prefix = v; end,
						order = 60
					},
					DisplayAbility = {
						type = "toggle",
						name = L["Display Ability"],
						desc = L["Display the ability that was used to taunt."],
						get = function(info) return db.DisplayAbility; end,
						set = function(info, v) db.DisplayAbility = v; end,
						order = 70
					},
				},
			},
			Announcements = {
				order = 40,
				type = "group",
				name = L["Announcements"],
				guiInline = true,
				args = {
					AnounceTaunts = {
						type = "toggle",
						name = L["Anounce Taunts"],
						desc = L["Anounce taunts."],
						get = function(info) return db.AnounceTaunts; end,
						set = function(info, v) db.AnounceTaunts = v; end,
						order = 10
					},
					AnounceTauntsOutput = {
						type = "select",
						values = Module.OutputTypes,
						name = L["Anounce Taunts Output:"],
						desc = L["Where taunts will be announced."],
						get = function(info) return db.AnounceTauntsOutput; end,
						set = function(info, v) db.AnounceTauntsOutput = v; end,
						order = 20
					},
					space1 = {
						order = 25,
						type = "description",
						name = "",
					},
					AnounceAOETaunts = {
						type = "toggle",
						name = L["Anounce AOE Taunts"],
						desc = L["Anounce AOE Taunts."],
						get = function(info) return db.AnounceAOETaunts; end,
						set = function(info, v) db.AnounceAOETaunts = v; end,
						order = 30
					},
					AnounceAOETauntsOutput = {
						type = "select",
						values = Module.OutputTypes,
						name = L["Anounce AOE Taunts Output:"],
						desc = L["Where AOE Taunts will be announced."],
						get = function(info) return db.AnounceAOETauntsOutput; end,
						set = function(info, v) db.AnounceAOETauntsOutput = v; end,
						order = 40
					},
					space2 = {
						order = 45,
						type = "description",
						name = "",
					},
					AnounceFails = {
						type = "toggle",
						name = L["Anounce Fails"],
						desc = L["Anounce taunts that fail."],
						get = function(info) return db.AnounceFails; end,
						set = function(info, v) db.AnounceFails = v; end,
						order = 50
					},
					AnounceFailsOutput = {
						type = "select",
						values = Module.OutputTypes,
						name = L["Anounce Fails Output:"],
						desc = L["Where the taunt fails will be announced."],
						get = function(info) return db.AnounceFailsOutput; end,
						set = function(info, v) db.AnounceFailsOutput = v; end,
						order = 60
					},
				},
			},
		}
	end
	return options
end

function Module:Info()
	return L["Announce in chat who taunted."]
end
