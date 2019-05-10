-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Addon Messages", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Addon Messages"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		frame = "ChatFrame3",
	}
}

function Module:CHAT_MSG_ADDON(event, arg1, arg2, arg3, arg4)
	if _G[db.frame] then
		_G[db.frame]:AddMessage(("[|cffffff40%s|r][|cffa0a0a0%s|r][|cff40ff40%s|r][|cff4040ff%s|r]"):format(arg1, arg2, arg3, arg4))
	end
end

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_ADDON")
end

function Module:OnDisable()
	self:RegisterEvent("CHAT_MSG_ADDON")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			frame = {
				type = "select",
				order = 13,
				name = L["Output Frame"],
				desc = L["Frame to send the addon messages to."],
				values = function()
					local frames = {}
					for i = 1, 18 do
						local cf = _G[("ChatFrame%d"):format(i)]
						if cf ~= COMBATLOG then
							frames[("ChatFrame%d"):format(i)] = ("Chat Frame %d"):format(i)
						end
					end
					return frames
				end,
				get = function() return db.frame end,
				set = function(_, value) db.frame = value end,
			}
		}
	end
	return options
end

function Module:Info()
	return L["Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues."]
end