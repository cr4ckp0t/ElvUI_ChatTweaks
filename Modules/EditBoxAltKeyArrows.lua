-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("EditBox Alt Key Arrows", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["EditBox Alt Key Arrows"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		useAlt = "disabled",
	}
}

function Module:UpdateEditBoxes(value)
	for _, fName in pairs(CHAT_FRAMES) do
		local frame = _G[("%sEditBox"):format(fName)]
		if not frame then break end
		frame:SetAltArrowKeyMode(value)
	end
end

function Module:OnEnable()
	self:UpdateEditBoxes(db.useAlt == "enabled" and 1 or nil)
end

function Module:OnDisable()
	self:UpdateEditBoxes(nil)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			useAlt = {
				type = "select",
				order = 13,
				name = L["Use Alt Key"],
				desc = L["Require the alt key to be pressed to use the arrow keys on editboxes."],
				values = {
					["enabled"] = L["Enabled"],
					["disabled"] = L["Disabled"],
				},
				get = function() return db.useAlt end,
				set = function(_, value)
					db.useAlt = value
					Module:UpdateEditBoxes(db.useAlt == "enabled" and 1 or nil)
				end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Toggle the requirement of the Alt key to be pressed to use arrow keys to navigate an editbox."]
end