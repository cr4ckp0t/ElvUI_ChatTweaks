-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Datatext", "AceConsole-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Datatext"]
Module.namespace = string.gsub(Module.name, " ", "")

local E, _, V, P, G, _ = unpack(ElvUI)
local DT = E:GetModule("DataTexts")
local datatext

local join = string.join

local db, options
local defaults = {
	global = {
		display = "enabled",
		showTotal = true,
	}
}

local displayNoTotal = ""
local displayTotal = ""

function Module:UpdateDisplay()
	if db.display == "all" then
		local _, _, total = ElvUI_ChatTweaks:GetModuleStatus(true)
		datatext.text:SetFormattedText(displayNoTotal, L["Chat Tweaks"], total)
	else
		if db.showTotal then
			local active, inactive, total = ElvUI_ChatTweaks:GetModuleStatus()
			datatext.text:SetFormattedText(displayTotal, L["Chat Tweaks"], db.display == "enabled" and active or inactive, total)
		else
			local active, inactive, _ = ElvUI_ChatTweaks:GetModuleStatus()
			datatext.text:SetFormattedText(displayNoTotal, L["Chat Tweaks"], db.display == "enabled" and active or inactive)
		end
	end
end


function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	Module.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds an ElvUI datatext for this addon."]
end

function Module:GetOptions()
	if not options then
		options = {
			display = {
				type = "select",
				order = 13,
				name = L["Datatext Display"],
				desc = L["What to show on the datatext."],
				values = {
					["all"] = L["All Modules"],
					["enabled"] = L["Enabled Modules"],
					["disabled"] = L["Disabled Modules"],
				},
				get = function() return db.display end,
				set = function(_, value) db.display = value; Module:UpdateDisplay(); end,
			},
			showTotal = {
				type = "toggle",
				order = 14,
				width = "double",
				name = L["Total Modules"],
				desc = L["Show the total number of modules on the datatext."],
				disabled = function() return db.display == "all" end,
				get = function() return db.showTotal end,
				set = function(_, value) db.showTotal = value; Module:UpdateDisplay(); end,
			},
		}
	end
	return options
end

-- datatext functions
local function OnEvent(self, event, ...)
	datatext = self
	Module:UpdateDisplay()
end

local function Click(self, button)
	if button == "LeftButton" then
		if not IsShiftKeyDown() then
			ElvUI_ChatTweaks:ToggleConfig()
		else
			-- enable all modules
			StaticPopup_Show("ECT_ENABLE_ALL")
		end
	elseif button == "RightButton" then
		if not IsShiftKeyDown() then
			ElvUI_ChatTweaks:PrintHelp()
		else
			-- disable all modules
			StaticPopup_Show("ECT_DISABLE_ALL")
		end
	end
end

local function OnEnter(self)
	local active, inactive, total = ElvUI_ChatTweaks:GetModuleStatus()

	-- setup the anchor and such
	DT:SetupTooltip(self)
	
	-- build the tooltip
	DT.tooltip:ClearLines()
	DT.tooltip:AddLine((L["%sElvUI Chat Tweaks|r by |cff9382c9Lockslap|r"]):format(ElvUI_ChatTweaks.hexColor))
	DT.tooltip:AddLine(" ")
	
	-- module info
	DT.tooltip:AddDoubleLine(L["Active Modules"], active, 1, 1, 1, 0, 1, 0)
	DT.tooltip:AddDoubleLine(L["Inactive Modules"], inactive, 1, 1, 1, 1, 0, 0)
	DT.tooltip:AddDoubleLine(L["Total Modules"], total, 1, 1, 1, 1, 1, 0)
	DT.tooltip:AddLine(" ")
	
	-- datatext hints
	DT.tooltip:AddDoubleLine(L["Left Click"], L["Open Config"], 1, 1, 1, 1, 1, 0)
	DT.tooltip:AddDoubleLine(L["Right Click"], L["Command Help"], 1, 1, 1, 1, 1, 0)
	DT.tooltip:AddDoubleLine(L["Shift + Left Click"], L["Enable All Modules"], 1, 1, 1, 1, 1, 0)
	DT.tooltip:AddDoubleLine(L["Shift + Right Click"], L["Disable All Modules"], 1, 1, 1, 1, 1, 0)
	
	DT.tooltip:Show()
end

local function OnLeave(self)
	DT.tooltip:Hide()
end

local function ValueColorUpdate(hex, r, g, b)
	displayNoTotal = join("", "|cffffffff%s:|r ", hex, "%d|r")
	displayTotal = join("", "|cffffffff%s:|r ", hex, "%d|r/", hex, "%d|r")
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

-- register the datatext w/ elvui
DT:RegisterDatatext("Chat Tweaks", {"PLAYER_ENTERING_WORLD"}, OnEvent, nil, Click, OnEnter, OnLeave)