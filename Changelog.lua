local E, _, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)

-- Cache global variables
-- Lua functions
local format, gmatch, gsub, find, sub = string.format, string.gmatch, string.gsub, string.find, string.sub
local tinsert = table.insert
local pairs, tostring = pairs, tostring
-- WoW API / Variables
local CreateFrame = CreateFrame
local SOUNDKIT = SOUNDKIT
local PlaySound = PlaySound
local CLOSE = CLOSE

-- Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: ElvUI_ChatTweaksDB, UISpecialFrames, CTCChangeLog, DISABLED_FONT_COLOR

local ChangeLogData = {
	"Changes:",
		"• Bumped .toc for 8.1.",
		"• Added Talent Squelch, this will hide chat msg when changing talents.",
		-- "• ",
		
	--"Notes:",
		-- "• ",
		-- "• ",
		-- "• ",
}

local function ModifiedString(string)
	local count = find(string, ":")
	local newString = string

	if count then
		local prefix = sub(string, 0, count)
		local suffix = sub(string, count + 1)
		local subHeader = find(string, "•")

		if subHeader then newString = tostring("|cFFFFFF00".. prefix .. "|r" .. suffix) else newString = tostring("|cFFFFFFFF" .. prefix .. "|r" .. suffix) end
	end

	for pattern in gmatch(string, "('.*')") do newString = newString:gsub(pattern, "|cFFFF8800" .. pattern:gsub("'", "") .. "|r") end
	return newString
end

local function GetChangeLogInfo(i)
	for line, info in pairs(ChangeLogData) do
		if line == i then return info end
	end
end

function ElvUI_ChatTweaks:CreateChangelog()
	local frame = CreateFrame("Frame", "CTCChangeLog", E.UIParent)
	frame:SetPoint("CENTER")
	frame:SetSize(445, 300)
	frame:SetTemplate("Transparent")
	if IsAddOnLoaded("ElvUI_KlixUI") or IsAddOnLoaded("ElvUI_MerathilisUI") then
		frame:Styling()
	elseif IsAddOnLoaded("ElvUI_BenikUI") then
		frame:Style("Inside")
	end
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:SetClampedToScreen(true)

	local icon = CreateFrame("Frame", nil, frame)
	icon:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 3)
	icon:SetSize(20, 20)
	icon:SetTemplate("Transparent")
	if IsAddOnLoaded("ElvUI_KlixUI") or IsAddOnLoaded("ElvUI_MerathilisUI") then
		icon:Styling()
	elseif IsAddOnLoaded("ElvUI_BenikUI") then
		icon:Style("Outside")
	end
	icon.bg = icon:CreateTexture(nil, "ARTWORK")
	icon.bg:Point("TOPLEFT", 2, -2)
	icon.bg:Point("BOTTOMRIGHT", -2, 2)
	icon.bg:SetTexture(ElvUI_ChatTweaks.Icon)
	icon.bg:SetBlendMode("ADD")
	
	local title = CreateFrame("Frame", nil, frame)
	title:SetPoint("LEFT", icon, "RIGHT", 3, 0)
	title:SetSize(422, 20)
	title:SetTemplate("Transparent")
	if IsAddOnLoaded("ElvUI_KlixUI") or IsAddOnLoaded("ElvUI_MerathilisUI") then
		title:Styling()
	elseif IsAddOnLoaded("ElvUI_BenikUI") then
		title:Style("Outside")
	end
	title.text = title:CreateFontString(nil, "OVERLAY")
	title.text:SetPoint("CENTER", title, 0, -1)
	title.text:SetFont(E["media"].normFont, 15, "OUTLINE")
	title.text:SetText(L["%sElvUI_ChatTweaks|r - ChangeLog v. %s%s|r"]:format(ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.version))

	local close = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	close:Point("BOTTOM", frame, "BOTTOM", 0, 10)
	close:SetText(L["%sClose|r"]:format(ElvUI_ChatTweaks.hexColor))
	close:SetSize(80, 20)
	close:SetScript("OnClick", function() frame:Hide(); self:Print(L["Hiding Changelog Window"]) end)
	S:HandleButton(close)
	close:Disable()
	frame.close = close

	local countdown = ElvUI_ChatTweaks:CreateText(close, "OVERLAY", 12, nil, "CENTER")
	countdown:SetPoint("LEFT", close.Text, "RIGHT", 3, 0)
	countdown:SetTextColor(DISABLED_FONT_COLOR:GetRGB())
	frame.countdown = countdown

	local offset = 4
	for i = 1, #ChangeLogData do
		local button = CreateFrame("Frame", "Button"..i, frame)
		button:SetSize(375, 16)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -offset)

		if i <= #ChangeLogData then
			local string = ModifiedString(GetChangeLogInfo(i))

			button.Text = button:CreateFontString(nil, "OVERLAY")
			button.Text:SetFont(E["media"].normFont, 11, "OUTLINE")
			button.Text:SetText(string)
			button.Text:SetPoint("LEFT", 0, 0)
		end
		offset = offset + 16
	end
end

function ElvUI_ChatTweaks:CountDown()
	self.time = self.time - 1
	if self.time == 0 then
		CTCChangeLog.countdown:SetText("")
		CTCChangeLog.close:Enable()
		self:CancelAllTimers()
	else
		CTCChangeLog.countdown:SetText(format("(%s)", self.time))
	end
end

function ElvUI_ChatTweaks:ToggleChangeLog()
	if not CTCChangeLog then
		self:CreateChangelog()
	end
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF or 857)
	
	local fadeInfo = {}
	fadeInfo.mode = "IN"
	fadeInfo.timeToFade = 0.5
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = 1
	E:UIFrameFade(CTCChangeLog, fadeInfo)
	
	self.time = 6
	self:CancelAllTimers()
	ElvUI_ChatTweaks:CountDown()
	self:ScheduleRepeatingTimer("CountDown", 1)
	self:Print(L["Showing Changelog Window"])
	GameTooltip:Hide()
end

function ElvUI_ChatTweaks:CheckVersion(self)
	if not ElvUI_ChatTweaksDB["Version"] or (ElvUI_ChatTweaksDB["Version"] and ElvUI_ChatTweaksDB["Version"] ~= ElvUI_ChatTweaks.version) then
		ElvUI_ChatTweaksDB["Version"] = ElvUI_ChatTweaks.version
		ElvUI_ChatTweaks:ToggleChangeLog()
	end
end