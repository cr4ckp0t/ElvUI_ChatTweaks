-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Combat Log Remover", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Combat Log Remover"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnEnable()
	self:CloseCombatChatFrame();
end

function Module:OnDisable()
	self:OpenCombatChatFrame();
end

function Module:OpenCombatChatFrame()
	-- COMBATLOG is the Combat Log frame, set in Blizzard_CombatLog.lua
	-- COMBAT_LOG is the name of the frame, set in GlobalStrings.lua

	-- Really need to be using COMBATLOG, however it's not loaded at this point so we use ChatFrame2
	ChatFrame2.isDocked = nil;

	if (not ChatFrame2.isDocked and not ChatFrame2:IsShown()) then
		FCF_OpenNewWindow(COMBAT_LOG);
	end
end

function Module:CloseCombatChatFrame()
	if (ChatFrame2.isDocked or ChatFrame2:IsShown()) then
		FCF_Close(ChatFrame2);
	end

	-- This fools FCF_OpenNewWindow into thinking the chatframe exists and skips to the next open chatframe
	ChatFrame2.isDocked = 1;
end

function Module:Info()
	return L["Removes the combat log chattab from the chat window."]
end
