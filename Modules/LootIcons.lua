-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Loot Icons", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Loot Icons"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		orientation = "left",
		size = 12,
	}
}

local function AddLootIcons(self, event, message, ...)
	local function IconForLink(link)
		local texture = GetItemIcon(link)
		return (db.orientation == "left") and "\124T" .. texture .. ":" .. db.size .. "\124t" .. link or link .. "\124T" .. texture .. ":" .. db.size .. "\124t"
	end
	message = message:gsub("(\124c%x+\124Hitem:.-\124h\124r)", IconForLink)
	return false, message, ...
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			orientation = {
				type = "select",
				order = 13,
				name = L["Icon Orientation"],
				desc = L["Icon to the left or right of the item link."],
				values = {
					["left"]	= L["Left"],
					["right"]	= L["Right"],
				},
				get = function() return db.orientation end,
				set = function(_, value) db.orientation = value end,
			},
			size = {
				type = "range",
				order = 14,
				name = L["Icon Size"],
				desc = L["The size of the icon in the chat frame."],
				get = function() return db.size end,
				set = function(_, value) db.size = value end,
				min = 8, max = 32, step = 1,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Add item icons to loot received messages."]
end