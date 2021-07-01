-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Item Level Link", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Item Level Link"]
Module.namespace = string.gsub(Module.name, " ", "")

local CreateFrame = _G["CreateFrame"]
local GetItemInfo = _G["GetItemInfo"]
local ChatFrame_AddMessageEventFilter = _G["ChatFrame_AddMessageEventFilter"]
local ChatFrame_RemoveMessageEventFilter = _G["ChatFrame_RemoveMessageEventFilter"]

local _G = _G
local select, tonumber = select, tonumber
local gsub, find, match = gsub, string.find, string.match
local CreateFrame = CreateFrame
local GetItemInfo = GetItemInfo
local GetAchievementInfo = GetAchievementInfo
local GetSpellInfo = GetSpellInfo
local GetCursorPosition = GetCursorPosition
local C_ChallengeMode_GetMapUIInfo = C_ChallengeMode.GetMapUIInfo
local strsplit = strsplit
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS

-- constants borrowed from PersonalLootHelper
local PLH_RELIC_TOOLTIP_TYPE_PATTERN = _G.RELIC_TOOLTIP_TYPE:gsub('%%s', '(.+)')
local PLH_ITEM_LEVEL_PATTERN = _G.ITEM_LEVEL:gsub('%%d', '(%%d+)')

local frame = CreateFrame("Frame", "ItemLinkLevel");
frame:RegisterEvent("PLAYER_LOGIN");
local tooltip
local socketTooltip

local db, options
local defaults = {
	global = {
		show_subtype = true,
		subtype_short_format = false,
		show_equiploc = true,
		show_ilevel = true,
		trigger_loots = true,
		trigger_chat = true,
		trigger_quality = 3,
	}
}

-- Inhibit Regular Expression magic characters ^$()%.[]*+-?)
local function EscapeSearchString(str)
	return str:gsub("(%W)","%%%1")
end

local function CreateEmptyTooltip()
    local tip = CreateFrame('GameTooltip')
	local leftside = {}
	local rightside = {}
	local L, R
	for i = 1, 6 do
		L, R = tip:CreateFontString(), tip:CreateFontString()
		L:SetFontObject(GameFontNormal)
		R:SetFontObject(GameFontNormal)
		tip:AddFontStrings(L, R)
		leftside[i] = L
		rightside[i] = R
	end
	tip.leftside = leftside
	tip.rightside = rightside
	return tip
end

local function PLH_GetRelicType(item)
	local relicType = nil
	
	if item ~= nil then
		tooltip = tooltip or CreateEmptyTooltip()
		tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
		tooltip:ClearLines()
		tooltip:SetHyperlink(item)
		local t = tooltip.leftside[2]:GetText()

		local index = 1
		local t
		while not relicType and tooltip.leftside[index] do
			t = tooltip.leftside[index]:GetText()
			if t ~= nil then
				relicType = t:match(PLH_RELIC_TOOLTIP_TYPE_PATTERN)				
			end
			index = index + 1
		end

		tooltip:Hide()
	end
	
	return relicType
end

local function PLH_GetRealILVL(item)
	local realILVL = nil
	
	if item ~= nil then
		tooltip = tooltip or CreateEmptyTooltip()
		tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
		tooltip:ClearLines()
		tooltip:SetHyperlink(item)
		local t = tooltip.leftside[2]:GetText()
		if t ~= nil then
--			realILVL = t:match('Item Level (%d+)')
			realILVL = t:match(PLH_ITEM_LEVEL_PATTERN)
		end
		-- ilvl can be in the 2nd or 3rd line dependng on the tooltip; if we didn't find it in 2nd, try 3rd
		if realILVL == nil then
			t = tooltip.leftside[3]:GetText()
			if t ~= nil then
--				realILVL = t:match('Item Level (%d+)')
				realILVL = t:match(PLH_ITEM_LEVEL_PATTERN)
			end
		end
		tooltip:Hide()
		
		-- if realILVL is still nil, we couldn't find it in the tooltip - try grabbing it from getItemInfo, even though
		--   that doesn't return upgrade levels
		if realILVL == nil then
			_, _, _, realILVL, _, _, _, _, _, _, _ = GetItemInfo(item)
		end
	end
	
	if realILVL == nil then
		return 0
	else		
		return tonumber(realILVL)
	end
end

local function ItemHasSockets(itemLink)
	local result = false
	socketTooltip = socketTooltip or CreateFrame("GameTooltip", "ItemLinkLevelSocketTooltip", nil, "GameTooltipTemplate")
	socketTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
	socketTooltip:ClearLines()
	for i = 1, 30 do
		local texture = _G[socketTooltip:GetName().."Texture"..i]
		if texture then
			texture:SetTexture(nil)
		end
	end
	socketTooltip:SetHyperlink(itemLink)
	for i = 1, 30 do
		local texture = _G[socketTooltip:GetName().."Texture"..i]
		local textureName = texture and texture:GetTexture()

		if textureName then
			local canonicalTextureName = string.gsub(string.upper(textureName), "\\", "/")
			result = string.find(canonicalTextureName, EscapeSearchString("ITEMSOCKETINGFRAME/UI-EMPTYSOCKET-"))
		end
	end
	return result
end

local function Filter(self, event, message, user, ...)
	for itemLink in message:gmatch("|%x+|Hitem:.-|h.-|h|r") do
		local itemName, _, quality, _, _, itemType, itemSubType, _, itemEquipLoc, _, _, itemClassId, itemSubClassId = GetItemInfo(itemLink)
		if (quality ~= nil and quality >= db.trigger_quality and (itemClassId == LE_ITEM_CLASS_WEAPON or itemClassId == LE_ITEM_CLASS_GEM or itemClassId == LE_ITEM_CLASS_ARMOR)) then
			local itemString = string.match(itemLink, "item[%-?%d:]+")
			local _, _, color = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
			local iLevel = PLH_GetRealILVL(itemLink)
			
			local attrs = {}
			if (db.show_subtype and itemSubType ~= nil) then
				if (itemClassId == LE_ITEM_CLASS_ARMOR and itemSubClassId == 0) then
				-- don't display Miscellaneous for rings, necks and trinkets
				elseif (itemClassId == LE_ITEM_CLASS_ARMOR and itemEquipLoc == "INVTYPE_CLOAK") then
				-- don't display Cloth for cloaks
				else
					if (db.subtype_short_format) then 
						table.insert(attrs, itemSubType:sub(0, 1)) 
					else 
						table.insert(attrs, itemSubType) 
					end
				end
				if (itemClassId == LE_ITEM_CLASS_GEM and itemSubClassId == LE_ITEM_ARMOR_RELIC) then 
					local relicType = PLH_GetRelicType(itemLink)
					table.insert(attrs, relicType)
				end
			end
			if (db.show_equiploc and itemEquipLoc ~= nil and _G[itemEquipLoc] ~= nil) then table.insert(attrs, _G[itemEquipLoc]) end
			if (db.show_ilevel and iLevel ~= nil) then 
				local txt = iLevel
				if (ItemHasSockets(itemLink)) then txt = txt .. "+S" end
				table.insert(attrs, txt)
			end
			
			local newItemName = itemName.." ("..table.concat(attrs, " ")..")"
			local newLink = "|cff"..color.."|H"..itemString.."|h["..newItemName.."]|h|r"
			
			message = string.gsub(message, EscapeSearchString(itemLink), newLink)
		end
	end
	return false, message, user, ...
end

function Module:OnEnable()
	if db.trigger_loots then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", Filter);
	end
	
	if db.trigger_chat then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", Filter);
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_BATTLEGROUND", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_EMOTE", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_GUILD", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_OFFICER", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PARTY", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PARTY_LEADER", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID_LEADER", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID_WARNING", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", Filter);
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_LOOT", Filter);
end

function Module:GetOptions()
	if not options then
		options = {
			show_subtype = {
				order = 15,
				type = "toggle",
				name = L["Show Armor Type"],
				desc = L["Display armor/weapon type (Plate, Leather, ...)"],
				get = function(item) return db[item[#item]] end,
				set = function(item, value) db[item[#item]] = value end,
			},
			subtype_short_format = {
				order = 16,
				type = "toggle",
				name = L["Short Format"],
				desc = L["Short format (P for plate, L for leather, ...)"],
				get = function(item) return db[item[#item]] end,
				set = function(item, value) db[item[#item]] = value end,
			},
			show_equiploc = {
				order = 17,
				type = "toggle",
				name = L["Equip Location"],
				desc = L["Display equip location (Head, Trinket, ...)"],
				get = function(item) return db[item[#item]] end,
				set = function(item, value) db[item[#item]] = value end,
			},
			show_ilevel = {
				order = 18,
				type = "toggle",
				name = L["Item Level"],
				desc = L["Display item level"],
				get = function(item) return db[item[#item]] end,
				set = function(item, value) db[item[#item]] = value end,
			},
			trigger_loots = {
				order = 19,
				type = "toggle",
				name = L["Trigger Loots"],
				desc = L["Display itemlevellinks when someone loots an item."],
				get = function(item) return db[item[#item]] end,
				set = function(item, value) db[item[#item]] = value end,
			},
			trigger_chat = {
				order = 20,
				type = "toggle",
				name = L["Trigger Chat"],
				desc = L["Display itemlevellinks when someone links an item in chat."],
				get = function(item) return db[item[#item]] end,
				set = function(item, value) db[item[#item]] = value end,
			},
			trigger_quality = {
				order = 21,
				type = "range",
				name = L["Quality"],
				desc = L["Filter what item quality should be displayed in chat.\n|cfff960d9Quality steps: 0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary & 6 = Artifact|r"],
				min = 0, max = 6, step = 1,
				get = function(item) return db[item[#item]] end,
				set = function(item, value) db[item[#item]] = value end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Adds itemlevel to linked items in chat messages."]
end
