-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Minimap Button", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Minimap Button"]
Module.namespace = string.gsub(Module.name, " ", "")

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
	icon = [[Interface\Addons\ElvUI_ChatTweaks\Textures\icon.tga]],
	OnClick = function(_, button)
		if button == "LeftButton" then
			if not IsShiftKeyDown() then
				ElvUI_ChatTweaks:ToggleConfig()
			else
				StaticPopup_Show("ECT_ENABLE_ALL")
			end
		elseif button == "RightButton" then
			if not IsShiftKeyDown() then
				ElvUI_ChatTweaks:PrintHelp()
			else
				StaticPopup_Show("ECT_DISABLE_ALL")
			end
		end
	end,
	OnTooltipShow = function(tooltip)
		local active, inactive, total = ElvUI_ChatTweaks:GetModuleStatus()
		-- build the tooltip
		tooltip:ClearLines()
		tooltip:AddLine((L["%sElvUI Chat Tweaks|r by |cff9382c9Lockslap|r"]):format(ElvUI_ChatTweaks.hexColor))
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