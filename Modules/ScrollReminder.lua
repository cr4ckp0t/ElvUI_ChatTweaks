-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Scroll Reminder", "AceHook-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Scroll Reminder"]
Module.namespace = string.gsub(Module.name, " ", "")

local CreateFrame = _G["CreateFrame"]
local GetScreenWidth = _G["GetScreenWidth"]

local format = string.format
local buttonsEnabled = false

function Module:CreateBottomButton(frame)
	local button = CreateFrame("Button", nil, frame, "BackdropTemplate")
	button:SetHeight(22)
	button:SetWidth(20)
	button:SetAlpha(0.60)
	button:SetPoint(frame:GetLeft() > (GetScreenWidth() / 2) and "BOTTOMLEFT" or "BOTTOMRIGHT", 0, 0)
	button:SetTemplate("Default", true)
	button:Hide()
	
	local buttontex = button:CreateTexture(nil, "OVERLAY")
	buttontex:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
	buttontex:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	buttontex:SetTexture([[Interface\AddOns\ElvUI_ChatTweaks\Textures\arrowdown.tga]])
	
	button:SetScript("OnClick", function(self) self:GetParent():ScrollToBottom() end)
	button:SetScript("OnEnter", function() button:SetAlpha(1) end)
	button:SetScript("OnLeave", function() button:SetAlpha(0.60) end)
	
	frame.downButton = button
end

function Module:EnableBottomButton()
	if buttonsEnabled then return end
	buttonsEnabled = true
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%d", i)]
		if frame then self:ApplyBottomButton(frame) end
	end
	for index, frame in ipairs(self.TempChatFrames) do
		self:ApplyBottomButton(_G[frame])
	end
end

function Module:DisableBottomButton()
	if not buttonsEnabled then return end
	buttonsEnabled = false
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%d", i)]
		if frame then self:DestroyBottomButton(frame) end
	end
	for index, frame in ipairs(self.TempChatFrames) do
		self:DestroyBottomButton(_G[frame])
	end
end

function Module:ApplyBottomButton(frame)
	if self:IsHooked(frame, "ScrollUp") then return end
	self:Hook(frame, "ScrollUp", true)
	self:Hook(frame, "ScrollToTop", "ScrollUp", true)
	self:Hook(frame, "PageUp", "ScrollUp", true)
	self:Hook(frame, "ScrollDown", true)
	self:Hook(frame, "ScrollToBottom", "ScrollDownForce", true)
	self:Hook(frame, "PageDown", "ScrollDown", true)
	if frame:GetScrollOffset() ~= 0 then frame.downButton:Show() end
end

function Module:DestroyBottomButton(frame)
	self:Unhook(frame, "ScrollUp")
	self:Unhook(frame, "ScrollToTop")
	self:Unhook(frame, "PageUp")
	self:Unhook(frame, "ScrollDown")
	self:Unhook(frame, "ScrollToBottom")
	self:Unhook(frame, "PageDown")
	frame.downButton:Kill()	-- SILENCE!!! I keel you!
end

function Module:ScrollUp(frame)
	frame.downButton:Show()
	frame.downButton:LockHighlight()
end

function Module:ScrollDown(frame)
	if frame:GetScrollOffset() == 0 then
		frame.downButton:Hide()
		frame.downButton:UnlockHighlight()
	end
end

function Module:ScrollDownForce(frame)
	frame.downButton:Hide()
	frame.downButton:UnlockHighlight()
end

function Module:AddMessage(frame, text, ...)
	if frame:GetScrollOffset() > 0 then
		frame.downButton:Show()
		frame.downButton:LockHighlight()
	else
		frame.downButton:Hide()
		frame.downButton:UnlockHighlight()
	end
	return self.hooks[frame].AddMessage(frame, text, ...)
end

function Module:Decorate(frame)
	if not self:IsHooked(frame, "AddMessage") then
		self:RawHook(frame, "AddMessage", true)
	end
	
	if not frame.downButton then
		self:CreateBottomButton(frame)
	end
end

function Module:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%d", i)]
		if frame then
			self:CreateBottomButton(frame)
			self:RawHook(frame, "AddMessage", true)
		end
	end
	for index, frame in ipairs(self.TempChatFrames) do
		self:CreateBottomButton(_G[frame])
		self:RawHook(_G[frame], "AddMessage", true)
	end
	self:EnableBottomButton()
end

function Module:OnDisable()
	self:DisableBottomButton()
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Creates a button to click that will return you to the bottom of the chat frame."]
end
