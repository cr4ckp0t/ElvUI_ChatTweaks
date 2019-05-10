-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Text Justification", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Text Justification"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db
local options
local defaults = {
	global = {}
}

function Module:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%d", i)]
		frame:SetJustifyH(db[format("FRAME_%d", i)] or "LEFT")
	end
end

function Module:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%d", i)]
		frame:SetJustifyH("LEFT")
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Lets you set the justification of text in your chat frames."]
end

function Module:GetOptions()
	if not options then
		options = {
			resetJustification = {
				type = "execute",
				order = 100,
				width = "full",
				name = L["Reset Text Justitification"],
				desc = L["Reset ChatFrame text justifications to defaults (left)."],
				func = function()
					for i = 1, NUM_CHAT_WINDOWS do
						local opt, frame = format("FRAME_%d", i), _G[format("ChatFrame%d", i)]
						frame:SetJustifyH("LEFT")
						db[opt] = "LEFT"
					end
				end
			}
		}
		
		for i = 1, NUM_CHAT_WINDOWS do
			local chat, frame = format("FRAME_%d", i), _G[format("ChatFrame%d", i)]
			options[chat] = {
				type = "select",
				order = 12 + i,
				name = format(L["ChatFrame %d"], i),
				desc = format(L["Text justification for ChatFrame %d."], i),
				values = {
					LEFT = L["Left"],
					RIGHT = L["Right"],
					CENTER = L["Center"],
				},
				get = function() return db[chat] or "LEFT" end,
				set = function(_, value)
					db[chat] = value
					frame:SetJustifyH(value)
				end
			}
		end
	end
	return options
end
