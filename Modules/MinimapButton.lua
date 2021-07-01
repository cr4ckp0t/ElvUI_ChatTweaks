-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local E, _, V, P, G = unpack(ElvUI)
local AB = E:GetModule("ActionBars")
local Module = ElvUI_ChatTweaks:NewModule("Minimap Button", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Minimap Button"]
Module.namespace = string.gsub(Module.name, " ", "")

local unpack = _G["unpack"]
local IsShiftKeyDown = _G["IsShiftKeyDown"]
local StaticPopup_Show = _G["StaticPopup_Show"]
local IsControlKeyDown = _G["IsControlKeyDown"]
local IsAltKeyDown = _G["IsAltKeyDown"]
local ReloadUI = _G["ReloadUI"]

local db
local defaults = {
	global = {
		minimap = {
			hide = false,
		}
	}
}

local LDB = LibStub("LibDataBroker-1.1"):NewDataObject(ElvUI_ChatTweaks.addonName, {
	type = "launcher",
	text = ElvUI_ChatTweaks.addonName,
	icon = ElvUI_ChatTweaks.Icon,
	OnClick = function(_, button)
		if button == "LeftButton" then
			if IsShiftKeyDown() then
				StaticPopup_Show("ECT_ENABLE_ALL")
			elseif IsControlKeyDown() then
				E:ToggleOptionsUI()
			elseif IsAltKeyDown() then
				ReloadUI()
			else
				ElvUI_ChatTweaks:ToggleConfig()
			end
		elseif button == "RightButton" then
			if IsShiftKeyDown() then
				StaticPopup_Show("ECT_DISABLE_ALL")
			elseif IsControlKeyDown() then
				E:ToggleMoveMode()
			elseif IsAltKeyDown() then
				AB:ActivateBindMode()
			else
				ElvUI_ChatTweaks:PrintHelp()
			end
		end
	end,
	OnTooltipShow = function(tooltip)
		local active, inactive, total = ElvUI_ChatTweaks:GetModuleStatus()
		-- build the tooltip
		tooltip:ClearLines()
		tooltip:AddLine((L["%sElvUI Chat Tweaks|r by |cff0070deCrackpotx|r"]):format(ElvUI_ChatTweaks.hexColor))
		tooltip:AddLine(" ")
		
		-- module info
		tooltip:AddDoubleLine(L["Active Modules"], active, 1, 1, 1, 0, 1, 0)
		tooltip:AddDoubleLine(L["Inactive Modules"], inactive, 1, 1, 1, 1, 0, 0)
		tooltip:AddDoubleLine(L["Total Modules"], total, 1, 1, 1, 1, 1, 0)
		tooltip:AddLine(" ")
		
		-- hints
		tooltip:AddDoubleLine(L["Left Click"], L["Open Config"], 1, 1, 1, 1, 1, 0)
		tooltip:AddDoubleLine(L["Right Click"], L["Command Help"], 1, 1, 1, 1, 1, 0)
		tooltip:AddDoubleLine(L["Shift + Left Click"], L["Enable All Modules"], 1, 1, 1, 1, 1, 0)
		tooltip:AddDoubleLine(L["Shift + Right Click"], L["Disable All Modules"], 1, 1, 1, 1, 1, 0)
		tooltip:AddDoubleLine(L["Control + Left Click"], L["Open ElvUI Config"], 1, 1, 1, 1, 1, 0)
		tooltip:AddDoubleLine(L["Control + Right Click"], L["Toggle Anchors"], 1, 1, 1, 1, 1, 0)
		tooltip:AddDoubleLine(L["Alt + Left Click"], L["ReloadUI"], 1, 1, 1, 1, 1, 0)
		tooltip:AddDoubleLine(L["Alt + Right Click"], L["Toggle Actionbar Keybinds"], 1, 1, 1, 1, 1, 0)
		
		tooltip:Show()		
	end,
})

local LDBI = LibStub("LibDBIcon-1.0")

function Module:OnEnable()
	db.minimap.hide = false
	LDBI:Show(ElvUI_ChatTweaks.addonName)
end

function Module:OnDisable()
	db.minimap.hide = true
	LDBI:Hide(ElvUI_ChatTweaks.addonName)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	Module.debug = ElvUI_ChatTweaks.db.global.debugging
	LDBI:Register(ElvUI_ChatTweaks.addonName, LDB, db.minimap)
end

function Module:Info()
	return L["Adds a minimap button.\n\n|cffffff00To disable the button, simply disable this module.|r"]
end
