-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
-- thanks to NinjaFish for the 5.51 fixes! :-)
local Module = ElvUI_ChatTweaks:NewModule("Player Names", "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
local AceTab = LibStub("AceTab-3.0")
Module.name = L["Player Names"]
Module.namespace = string.gsub(Module.name, " ", "")

local gsub = string.gsub
local match = string.match
local find = string.find
local format = string.format
local upper = string.upper
local wipe = table.wipe
local split = strsplit

local localNames = {}
local localClass = {}
local cache = {}
local storedName = {}
local player = UnitName("player")
local kByteString = "%d kb"
local mByteString = "%.2f mb"

local channels = {
	GUILD = {},
	PARTY = {},
	RAID = {}
}
local filterString = "CHAT_MSG_%s"
local filterChannels = {
	"CHANNEL",
	"GUILD",
	"SAY",
	"YELL",
	"OFFICER",
	"EMOTE",
	"INSTANCE_CHAT", -- added in patch 5.1
	"INSTANCE_CHAT_LEADER", -- added in patch 5.1
	"PARTY",
	"PARTY_LEADER",
	"RAID",
	"RAID_LEADER",
	"RAID_WARNING",
	"WHISPER"
}

local db
local options

local defaults = {
	realm = {
		names = {},
		levels = {},
	},
	global = {
		saveData = false,
		nameColoring = "CLASS",
		leftBracket = "[",
		rightBracket = "]",
		levelColor = "DIFF",
		levelLocation = "AFTER",
		bnetBrackets = true,
		separator = ":",
		useTabComplete = true,
		colorSelfInText = true,
		nickColor = {r = 0.627, g = 0.627, b = 0.627},
		emphasizeSelfInText = true,
		noRealNames = false,
		classes = {	
			DRUID = L["Druid"],
			MAGE = L["Mage"],
			PALADIN = L["Paladin"],
			PRIEST = L["Priest"],
			ROGUE = L["Rogue"],
			HUNTER = L["Hunter"],
			SHAMAN = L["Shaman"],
			WARLOCK = L["Warlock"],
			WARRIOR = L["Warrior"],
			DEATHKNIGHT = L["Death Knight"],
			MONK = L["Monk"], -- added in mop
		}
	}
}

local function formatMemory(memory)
	local mult = 10^1
	if memory > 999 then
		local mem = ((memory/1024) * mult) / mult
		return format(mByteString, mem)
	else
		local mem = (memory * mult) / mult
		return format(kByteString, mem)
	end
end

local origUnitClass = UnitClass
local function UnitClass(unit)
	local loc, sys = origUnitClass(unit)
	if sys and Module.db.global.classes[sys] then
		Module.db.global.classes[sys] = loc
		localClass = sys
	end
	return loc, sys
end

local tabComplete
do
	function tabComplete(t, text, pos)
		local word = text:sub(pos)
		if #word == 0 then return end
		local CF = ChatEdit_GetActiveWindow()
		local channel = CF:GetAttribute("chatType")
		if channel == "CHANNEL" then
			channel = select(2, GetChannelName(CF:GetAttribute("channelTarget"))):lower()
		elseif channel == "OFFICER" then
			channel = "GUILD"
		elseif channel == "RAID_WARNING" or channel == "RAID_LEADER" then
			channel = "RAID"
		end
		if channels[channel] then
			for index, _ in pairs(channels[channel]) do
				if index:lower():match("^" .. word:lower()) then
					tinsert(t, index)
				end
			end
		end
		return t
	end
end

local getNameColor
do
	local sq2 = sqrt(2)
	local pi = _G.math.pi
	local cos = _G.math.cos
	local fmod = _G.math.fmod
	local strbyte = _G.strbyte
	local t = {}

	-- http://www.tecgraf.puc-rio.br/~mgattass/color/HSVtoRGB.htm


	local function HSVtoRGB(h, s, v)
	   if ( s == 0 ) then
		  --achromatic=fail
		  t.r = v
		  t.g = v
		  t.b = v
		  if not t.r then t.r = 0 end
		  if not t.g then t.g = 0 end
		  if not t.b then t.b = 0 end
		  return t.r,t.g,t.b
	   end
	   h = h/60
	   local i = floor(h)
	   local i1 = v * (1 - s)
	   local i2 = v * (1 - s * (h - i))
	   local i3 = v * (1 - s * (1 - (h - i)))
	   if i == 0 then
		  --	return v, i3, i1
		  t.r = v
		  t.g = i3
		  t.b = i1
	   elseif i == 1 then
		  --	return i2, v, i1
		  t.r = i2
		  t.g = v
		  t.b = i1
	   elseif i == 2 then
		  --	return i1, v, i3
		  t.r = i1
		  t.g = v
		  t.b = i3
	   elseif i == 3 then
		  --	return i3, i2, v
		  t.r = i3
		  t.g = i2
		  t.b = v
	   elseif i == 4 then
		  --	return i3, i1, v
		  t.r = i3
		  t.g = i1
		  t.b = v
	   elseif i == 5 then
		  --	return v, i1, i2
		  t.r = v
		  t.g = i1
		  t.b = i2
	   else
		  DEFAULT_CHAT_FRAME:AddMessage("Chatter HSVtoRGB failed")
	   end
	   if not t.r then t.r = 0 end
	   if not t.g then t.g = 0 end
	   if not t.b then t.b = 0 end
	   return t.r,t.g,t.b
	end

	function getNameColor(name)
		local seed = 5381 --old seed: 5124
		local h, s, v = 1, 1, 1
		local r, g, b
		for i = 1, #name do
			seed = 33 * seed + strbyte(name, i) --used to use 29 here
		end
		-- h = fmod(seed, 255) / 255
		h = fmod(seed, 360) --changed the HSVtoRGB to acompany this change
		if (h > 220) and (h < 270) then
		   h = h + 60
		end
		t.r, t.g, t.b = HSVtoRGB(h, s, v)

		return t
	end
end

function Module:GetColor(class, isLocal)
	if not class then return end
	
	if Module.debug then
		self:Print(("Class: %s"):format(class))
	end
	
	if isLocal then
		local found = false
		for index, value in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
			if value == class then class = index; found = true; break; end
		end
		if not found then
			for index, value in pairs(LOCALIZED_CLASS_NAMES_MALE) do
				if value == class then class = index; break; end
			end
		end
	end
	local colors = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class:upper()] or RAID_CLASS_COLORS[class:upper()]
	if not colors then
		colors = {r = 1, g = 1, b = 1}
	end
	return ("%02x%02x%02x"):format(colors.r * 255, colors.g * 255, colors.b * 255)
end

function Module:WipeCache()
	wipe(cache)
end

function Module:UpdateSaveData(v)
	if v then
		for k, v in pairs(localNames) do
			Module.db.realm.names[k] = v
		end
	end
end

local function fixLogin(head, id, misc, who, extra, colon)
	local left, right = "", ""
	if not Module.db.global.bnetBrackets then
		left = Module.db.global.leftBracket or "["
		right = Module.db.global.rightBracket or "]"
	end
	return head .. id .. misc .. left .. who .. right .. extra .. (misc:match("BN_INLINE_TOAST_ALERT")) and "" or colon
end

local function changeBNetName(misc, id, moreMisc, fakeName, tag, colon)
	local _, charName, _, _, _, _, _, english = BNGetToonInfo(id)
	local left, right = "", ""
	if chatName and charName ~= "" then
		if storedName then storedName[id] = charName end
		fakeName = Module.db.global.noRealNames and charName or fakeName
	else
		if Module.db.global.noRealNames and storedName and storedName[id] then
			fakeName = storedName[id]
			storedName[id] = nil
		end
	end
	
	if moreMisc:match("BN_INLINE_TOAST_ALERT") then
		misc = misc:sub(1, -2)
	end
	
	if not Module.db.global.bnetBrackets then
		left = Module.db.global.leftBracket
		right = Module.db.global.rightBracket
	end
	
	if english and english ~= "" then
		if not fakeName:match("|cff") then
			if Module.db.global.nameColoring == "CLASS" then
				fakeName = "|cff" .. Module:GetColor(english) .. fakeName .. "|r"
			elseif Module.db.global.nameColoring == "NAME" then
				fakeName = Module:ColorName(fakeName)
			end
		end
	end
	return misc .. id .. moreMisc .. left .. fakeName .. right .. tag .. ":"
end

local function changeName(header, name, extra, count, display, body)
	if name == player then
		if emphasizeSelfInText then
			body = body:gsub("(" .. player .. ")", "|cffffff00>|r%1|cffffff00<|r"):gsub("(" .. player:lower() .. ")", "|cffffff>|r%1|cffffff00<|r")
		end
		if colorSelfInText then
			body = body:gsub("(" .. player .. ")", "|cffff0000%1|r"):gsub("(" .. player:lower() .. ")", "|cffff0000%1|r")
		end	
	end
	
	if not display:match("|cff") then
		display = Module:ColorName(name)
	end
	
	cache[name] = display
	
	local level
	local tab = Module.db.realm.names[name] or localNames[name]
	if tab then
		level = Module.db.global.includeLevel and tab.level or nil
	end
	
	if level and (level ~= MAX_PLAYER_LEVEL or not Module.db.global.excludeMaxLevel) then
		if Module.db.global.levelColor == "DIFF" then
			local color = GetQuestDifficultyColor(level)
			level = ("|cff%02x%02x%02x%s|r"):format(color.r * 255, color.g * 255, color.b * 255, level)
		elseif Module.db.global.levelColor == "CLASS" and display:match("|cff......") then
			level = gsub(display, "((|cff......).-|r)", function(string, color)
				return format("%s%s|r", color, level)
			end)
		end
		display = ("%s%s%s"):format(Module.db.global.levelLocation == "BEFORE" and level or display, Module.db.global.separator, Module.db.global.levelLocation == "AFTER" and level or display)
	end
	
	return ("|Hplayer:%s%s%s|h%s%s%s|h%s"):format(name, extra, count, Module.db.global.leftBracket, display, Module.db.global.rightBracket, body)
end

local function capitalize(str)
    return str:gsub("^%l", upper)
end

function Module:ColorName(name)
	local class
	local tab = Module.db.realm.names[name] or localNames[name]
	if tab then class = tab.class end
	
	if cache[name] then
		name = cache[name]
	else
		if Module.db.global.nameColoring ~= "NONE" then
			local color = Module.db.global.nickColor
			if Module.db.global.nameColoring == "CLASS" then
				color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class:upper()] or (class and RAID_CLASS_COLORS[class:upper()] or Module.db.global.nickColor)
			elseif coloring == "NAME" then
				color = getNameColor(name)
			end
			name = ("|cff%02x%02x%02x%s|r"):format(color.r * 255, color.g * 255, color.b * 255, name)
		end
	end
	return name
end

function Module:AddMessage(frame, text, ...)
	if text and type(text) == "string" then
		text = text:gsub("(|Hplayer:([^|:]+)([:%d+]*)([^|]*)|h%[([^%]]+)%]|h)(.-)$", changeName)
		text = text:gsub("(|HBNplayer:%S-|k:)(%d-)(:%S-|h)%[(%S-)%](|?h?)(:?)", changeBNetName)
		text = text:gsub("(|HBNplayer%S-|k)(%d-)(:%S-BN_INLINE_TOAST_ALERT%S-|h)%[(%S-)%](|?h?)(:?)", fixLogin)
	end
	return self.hooks[frame].AddMessage(frame, text, ...)
end

function Module:FRIENDLIST_UPDATE(event)
	for i = 1, GetNumFriends() do
		local name, level, class = GetFriendInfo(i)
		if class then
			self:AddPlayer(name, localClass[class], level, Module.db.global.saveFriends)
		end
	end
end

function Module:GUILD_ROSTER_UPDATE(event)
	if not IsInGuild() then return end
	wipe(channels.GUILD)
	for i = 1, GetNumGuildMembers() do
		local name, _, _, level, _, _, _, _, online, _, class, _, _, isMobile = GetGuildRosterInfo(i)
		if online and not isMobile then
			channels.GUILD[name] = name
		end
		if not isMobile then self:AddPlayer(name, class, level, Module.db.global.saveGuild) end
	end
end

function Module:GROUP_ROSTER_UPDATE(event)
	wipe(channels.PARTY)
	wipe(channels.RAID)
	
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local name, _, _, level, _, class = GetRaidRosterInfo(i)
			if name and level and class then
				channels.RAID[name] = true
				self:AddPlayer(name, class, level, Module.db.global.saveGroup)
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local unit = ("party%d"):format(i)
			local name = UnitName(unit)
			local _, class = UnitClass(unit)
			local level = UnitLevel(unit)
			channels.PARTY[name] = true
			self:AddPlayer(name, class, level, Module.db.global.saveGroup)
		end
	end
end

function Module:PLAYER_TARGET_CHANGED(event)
	if not UnitExists("target") or not UnitIsPlayer("target") or not UnitIsFriend("player", "target") then return end
	local _, class = UnitClass("target")
	local name, level = UnitName("target"), UnitLevel("target")
	self:AddPlayer(name, class, level, Module.db.global.saveTarget)
end

function Module:UPDATE_MOUSEOVER_UNIT(event)
	if not UnitExists("mouseover") or not UnitIsPlayer("mouseover") or not UnitIsFriend("player", "mouseover") then return end
	local _, class = UnitClass("mouseover")
	local name, level = UnitName("mouseover"), UnitLevel("mouseover")
	self:AddPlayer(name, class, level, Module.db.global.saveTarget)
end

function Module:WHO_LIST_UPDATE(event)
	if GetNumWhoResults() <= 3 or Module.db.global.saveAllWho then
		for i =1, GetNumWhoResults() do
			local name, _, level, _, _, _, class = GetWhoInfo(i)
			if class then
				self:AddPlayer(name, class, level, Module.db.global.saveWho)
			end
		end
	end
end

function Module:CHAT_MSG_CHANNEL_JOIN(event, _, name, _, _, _, _, _, _, channel)
	channels[channel:lower()] = channels[channel:lower()] or {}
	channels[channel:lower()][name] = true
end

function Module:CHAT_MSG_CHANNEL_LEAVE(event, _, name, _, _, _, _, _, _, channel)
	if not channels[channel:lower()] then return end
	channels[channel:lower()][name] = nil
end
	
function Module:AddPlayer(name, class, level, save)
	if name and class and class ~= UNKNOWN then
		if save or Module.db.realm.names[name] then
			Module.db.realm.names[name] = Module.db.realm.names[name] or {}
			Module.db.realm.names[name].class = class
			if level and level ~= 0 then
				Module.db.realm.names[name].level = level
			end
		else
			localNames[name] = localNames[name] or {}
			localNames[name].class = class
			if level and level ~= 0 then
				localNames[name].level = level
			end
		end
		cache[name] = nil
	end
end

function Module:Decorate(frame)
	if not self:IsHooked(frame, "AddMessage") then
		self:RawHook(frame, "AddMessage", true)
	end
end

function Module:OnEnable()
	self:RegisterEvent("GROUP_ROSTER_UPDATE")
	self:RegisterEvent("WHO_LIST_UPDATE")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("CHAT_MSG_SYSTEM", "WHO_LIST_UPDATE")
	self:RegisterEvent("FRIENDLIST_UPDATE")
	self:RegisterEvent("GUILD_ROSTER_UPDATE")
	self:RegisterEvent("CHAT_MSG_CHANNEL_JOIN")
	self:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE")
	self:RegisterEvent("CHAT_MSG_CHANNEL", "CHAT_MSG_CHANNEL_JOIN")
	
	if IsInGuild() then GuildRoster() end
	self:GROUP_ROSTER_UPDATE()
	
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%d", i)]
		if frame ~= COMBATLOG then self:RawHook(frame, "AddMessage", true) end
	end
	for index, frame in ipairs(self.TempChatFrames) do
		local cf = _G[frame]
		self:RawHook(cf, "AddMessage", true)
	end
	
	if Module.db.global.useTabComplete then
		AceTab:RegisterTabCompletion("ElvUI_ChatTweaks", nil, tabComplete)
	end
	
	if CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS.RegisterCallback then
		CUSTOM_CLASS_COLORS:RegisterCallback(wipeCache)
	end
	
	if Module.db.global.noRealNames then
		local _, n = BNGetNumFriends()
		for i = 1, n do
			local _, _, _, toon, id = BNGetFriendInfo(i)
			storedName[id] = toon
		end
	end
	
	options.save.args.notice.name = format(L["\n\n|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.\n\nAddon Usage: |cff00ff00%s|r"], formatMemory(GetAddOnMemoryUsage("ElvUI_ChatTweaks")))
end

function Module:OnDisable()
	self:UnregisterEvent("GROUP_ROSTER_UPDATE")
	self:UnregisterEvent("WHO_LIST_UPDATE")
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:UnregisterEvent("CHAT_MSG_SYSTEM")
	self:UnregisterEvent("FRIENDLIST_UPDATE")
	self:UnregisterEvent("GUILD_ROSTER_UPDATE")
	self:UnregisterEvent("CHAT_MSG_CHANNEL_JOIN")
	self:UnregisterEvent("CHAT_MSG_CHANNEL_LEAVE")
	self:UnregisterEvent("CHAT_MSG_CHANNEL")

	if AceTab:IsTabCompletionRegistered("ElvUI_ChatTweaks") then
		AceTab:UnregisterTabCompletion("ElvUI_ChatTweaks")
	end
	
	if CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS.UnregisterCallback then
		CUSTOM_CLASS_COLORS:UnregisterCallback(wipeCache)
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	for index, value in pairs(self.db.realm.names) do
		if type(value) == "string" then
			self.db.realm.names[index] = {class = v}
		end
	end
	--db = self.Module.db.global.profile
	--Module.db.realm = self.Module.db.realm
	--Module.db.global = self.Module.db.global
	
	for index, value in pairs(self.db.global.classes) do
		localClass[value] = index
	end
	
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Provides options to color player names, add player levels, and add tab completion of player names."]
end

function Module:GetOptions()
	if not options then
		options = {
			save = {
				type = "group",
				name = L["Save Data"],
				desc = L["Save data between sessions. Will increase memory usage"],
				args = {
					guild = {
						type = "toggle",
						name = L["Guild"],
						desc = L["Save class data from guild between sessions."],
						get = function()
							return Module.db.global.saveGuild
						end,
						set = function(_,  v)
							Module.db.global.saveGuild = v
							Module:UpdateSaveData(v)
						end
					},
					group = {
						type = "toggle",
						name = L["Group"],
						desc = L["Save class data from groups between sessions."],
						get = function()
							return Module.db.global.saveGroup
						end,
						set = function(_,  v)
							Module.db.global.saveGroup = v
							Module:UpdateSaveData(v)
						end
					},
					friend = {
						type = "toggle",
						name = L["Friends"],
						desc = L["Save class data from friends between sessions."],
						get = function()
							return Module.db.global.saveFriends
						end,
						set = function(_,  v)
							Module.db.global.saveFriends = v
							Module:UpdateSaveData(v)
						end
					},
					target = {
						type = "toggle",
						name = L["Target/Mouseover"],
						desc = L["Save class data from target/mouseover between sessions."],
						get = function()
							return Module.db.global.saveTarget
						end,
						set = function(_,  v)
							Module.db.global.saveTarget = v
							Module:UpdateSaveData(v)
						end
					},
					who = {
						type = "toggle",
						name = L["Who"],
						desc = L["Save class data from /who queries between sessions."],
						order = 104,
						get = function()
							return Module.db.global.saveWho
						end,
						set = function(_,  v)
							Module.db.global.saveWho = v
							Module:UpdateSaveData(v)
						end
					},
					saveAllWho = {
						type = "toggle",
						name = L["Save all /who data"],
						desc = L["Will save all data for large /who queries"],
						disabled = function() return not Module.db.global.saveWho end,
						order = 105,
						get = function()
							return Module.db.global.saveAllWho
						end,
						set = function(_,  v)
							Module.db.global.saveAllWho = v
						end
					},
					resetDB = {
						type = "execute",
						name = L["Reset Data"],
						desc = L["Destroys all your saved class/level data"],
						func = function() wipe(Module.db.realm.names) end,
						order = 106,
						confirm = function() return L["Are you sure you want to delete all your saved class/level data?"] end
					},
					notice = {
						type = "description",
						name = L["\n\n|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level."],
						order = 107,
					},
				}
			},
			level = {
				type = "group",
				name = L["Player Level"],
				desc = L["Player level display options."],
				args = {
					includeLevel = {
						type = "toggle",
						name = L["Include level"],
						desc = L["Include the player's level"],
						order = 1,
						get = function() return Module.db.global.includeLevel end,
						set = function(_,  val)
							Module.db.global.includeLevel = val
							Module:WipeCache()
						end
					},
					separator = {
						type = "input",
						order = 2,
						name = L["Separator"],
						desc = L["Character to use between the name and level"],
						disabled = function() return not Module.db.global.includeLevel end,
						get = function() return Module.db.global.separator end,
						set = function(i, v)
							Module.db.global.separator = v
						end
					},
					colorLevelByDifficulty = {
						type = "select",
						name = L["Color Level"],
						desc = L["Select how you want the player's level colored."],
						order = 3,
						values = {
							["DIFF"] = L["Level Difference"],
							["CLASS"] = L["Player Class"],
							["NONE"] = L["None"],
						},
						disabled = function() return not Module.db.global.includeLevel end,
						get = function() return Module.db.global.levelColor end,
						set = function(_,  v)
							Module.db.global.levelColor = v
							Module:WipeCache()
						end,
					},
					excludeMaxLevel = {
						type = "toggle",
						name = L["Exclude max levels"],
						desc = L["Exclude level display for max level characters"],
						order = 4,
						disabled = function() return not Module.db.global.includeLevel end,
						get = function() return Module.db.global.excludeMaxLevel end,
						set = function(_,  val)
							Module.db.global.excludeMaxLevel = val
							Module:WipeCache()
						end,
					},
					levelLocation = {
						type = "select",
						name = L["Level Location"],
						desc = L["Place the level before or after the player's name."],
						values = {
							["BEFORE"] = L["Before"],
							["AFTER"] = L["After"],
						},
						disabled = function() return not Module.db.global.includeLevel end,
						get = function() return Module.db.global.levelLocation end,
						set = function(_, value) Module.db.global.levelLocation = value end,
					}
				}
			},
			leftbracket = {
				type = "input",
				order = 14,
				name = L["Left Bracket"],
				desc = L["Character to use for the left bracket"],
				get = function() return Module.db.global.leftBracket end,
				set = function(i, v)
					Module.db.global.leftBracket = v
					leftBracket = v
				end
			},
			rightbracket = {
				type = "input",
				order = 14,
				name = L["Right Bracket"],
				desc = L["Character to use for the right bracket"],
				get = function() return Module.db.global.rightBracket end,
				set = function(i, v)
					Module.db.global.rightBracket = v
					rightBracket = v
				end
			},
			bnetHeader = {
				type = "header",
				name = L["Battle.Net Options"],
				order = 20
			},
			bnetBrackets = {
				type = "toggle",
				order = 21,
				name = L["RealID Brackets"],
				desc = L["Strip RealID brackets"],
				get = function() return Module.db.global.bnetBrackets end,
				set = function(_, v)
					Module.db.global.bnetBrackets = v
				end,
			},
			bnetRealNames = {
				type = "toggle",
				order = 22,
				name = L["No RealNames"],
				desc = L["Show toon names instead of real names"],
				get = function() return Module.db.global.noRealNames end,
				set = function(_, v)
					Module.db.global.noRealNames = v
				end,
			},
			useTabComplete = {
				type = "toggle",
				order = 19,
				name = L["Use Tab Complete"],
				desc = L["Use tab key to automatically complete character names."],
				get = function() return Module.db.global.useTabComplete end,
				set = function(_,  v)
					Module.db.global.useTabComplete = v
					if v and not AceTab:IsTabCompletionRegistered("ElvUI_ChatTweaks") then
						AceTab:RegisterTabCompletion("ElvUI_ChatTweaks", nil, tabComplete)
					elseif not v and AceTab:IsTabCompletionRegistered("ElvUI_ChatTweaks") then
						AceTab:UnregisterTabCompletion("ElvUI_ChatTweaks")
					end
				end
			},
			colorSelfInText = {
				type = "toggle",
				order = 17,
				name = L["Color self in messages"],
				desc = L["Color own charname in messages."],
				get = function() return Module.db.global.colorSelfInText end,
				set = function(i, v)
					Module.db.global.colorSelfInText = v
					colorSelfInText = v
				end
			},
			emphasizeSelfInText = {
				type = "toggle",
				order = 18,
				name = L["Emphasize Self"],
				desc = L["Add surrounding brackets to own charname in messages."],
				get = function() return Module.db.global.emphasizeSelfInText end,
				set = function(i, v)
					Module.db.global.emphasizeSelfInText = v
					emphasizeSelfInText = v
				end
			},
			colorBy = {
				type = "select",
				order = 13,
				name = L["Color Player Names By..."],
				desc = L["Select a method for coloring player names"],
				values = {
					CLASS = L["Class"],
					NAME = L["Name"],
					NONE = L["None"],
				},
				get = function() return Module.db.global.nameColoring end,
				set = function(_,  val)
					Module.db.global.nameColoring = val
					Module:WipeCache()
				end
			},
			nickColor = {
				type = "color",
				order = 16,
				name = L["Default Name Color"],
				desc = L["The default color to use to color names."],
				get = function() return Module.db.global.nickColor.r, Module.db.global.nickColor.g, Module.db.global.nickColor.b end,
				set = function(_, r, g, b)
					Module.db.global.nickColor.r = r
					Module.db.global.nickColor.g = g
					Module.db.global.nickColor.b = b
				end
			},
		}
	end
	return options
end