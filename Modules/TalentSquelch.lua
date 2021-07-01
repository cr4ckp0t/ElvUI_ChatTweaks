-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Talent Squelch", "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Talent Squelch"]
Module.namespace = string.gsub(Module.name, " ", "")

local ChatFrame_AddMessageEventFilter = _G["ChatFrame_AddMessageEventFilter"]
local C_Timer_After = C_Timer.After
local ChatFrame_RemoveMessageEventFilter = _G["ChatFrame_RemoveMessageEventFilter"]

local db, options
local defaults = {
	global = {
		squelch = 0,
	}
}

function Module:GetOptions()
	if not options then
		options = {
			Squelch = {
				name = L["Squelch"],
				desc = L["Control when Talented should silence Learned/Unlearned system messages"],
				width = 1.5,
				type = "select",
				values = {
					[0] = L["Never"],
					[1] = L["When Talented Changes Talents"],
					[2] = L["Always"],
				},
				set = function(_, val) 
					db.squelch = val
					Module:InitSquelch()
				end,
				get = function() return db.squelch end
			},
		}
	end
	return options
end

function Module:InitSquelch()
    self:RemoveSquelch()
    local squelchLevel = db.squelch
    if squelchLevel > 1 then self:AddSquelch() end
end

function Module:AddSquelch()
    ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", self.Squelch)
end

function Module:RemoveSquelchDelayed()
    C_Timer_After(1, function() self:RemoveSquelch() end)
end

function Module:RemoveSquelch()
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", self.Squelch)
end

local token = ".+"
local unlearned = ERR_SPELL_UNLEARNED_S:format(token)
local spell = ERR_LEARN_SPELL_S:format(token)
local ability = ERR_LEARN_ABILITY_S:format(token)
local passive = ERR_LEARN_PASSIVE_S:format(token)
function Module.Squelch(self, event, msg, ...)
    if string.match(msg, unlearned) 
        or string.match(msg, spell)
        or string.match(msg, ability)
        or string.match(msg, passive)
    then
        return true
    end

    return false
end

function Module:OnEnable()
	self:InitSquelch()
end

function Module:OnDisable()
	self:UnregisterEvent("CHAT_MSG_SYSTEM")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Silence Learned/Unlearned system messages."]
end
