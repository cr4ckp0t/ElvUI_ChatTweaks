-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local E, _, _, _, _ = unpack(ElvUI)
local Module = ElvUI_ChatTweaks:NewModule("Hover Links", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Hover Links"]
Module.namespace = string.gsub(Module.name, " ", "")
Module.showingTip = false

local match = string.match

-- the link types we'll interract with
local linkTypes = {
	item = true,
	enchant = true,
	spell = true,
	quest = true,
	achievement = true,
	currency = true
}

function Module:OnHyperlinkEnter(frame, link)
	-- get the link type using regex
	local lType = match(link, "^(.-):")
	
	if linkTypes[lType] then
		-- show the tooltip
		self.showingTip = true
		ShowUIPanel(GameTooltip)
		GameTooltip:SetOwner(E.UIParent, "ANCHOR_CURSOR")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end

function Module:OnHyperlinkLeave(frame, link)
	if self.showingTip then
		-- hide the tooltip
		self.showingTip = false
		GameTooltip:Hide()
	end
end

function Module:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame" .. i]
		self:HookScript(Frame, "OnHyperlinkEnter", OnHyperlinkEnter)
		self:HookScript(Frame, "OnHyperlinkLeave", OnHyperlinkLeave)
	end
end

function Module:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame" .. i]
		self:Unhook(Frame, "OnHyperlinkEnter")
		self:Unhook(Frame, "OnHyperlinkLeave")
	end
end

function Module:Info()
	return L["Display a tooltip by hovering over a link in chat."]
end
