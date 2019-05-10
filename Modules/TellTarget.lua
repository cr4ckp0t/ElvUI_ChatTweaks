-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Tell Target", "AceHook-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Tell Target"]
Module.namespace = string.gsub(Module.name, " ", "")

local _G = getfenv(0)
local editBoxString = "ChatFrame%dEditBox"

function Module:SendTellToTarget(frame, text, editBox)
	if frame == nil then frame = DEFAULT_CHAT_FRAME end	-- just in case
	
	local name, realm, fullname
	if UnitIsPlayer("target") then
		name, realm = UnitName("target")
		if name then
			-- for cross realm compatibility
			if realm then
				fullname = name .. "-" .. realm	-- i.e: Lockslap-Bleeding Hollow
			else
				fullname = name
			end
		end
	end
	
	-- incase they tried to do it without a valid target selected
	local target = name and name:gsub(" ", "") or L["NoTarget"]
	
	-- debugging
	if Module.debug then Module:Print((L["Target: |cffffff00%s|r"]):format(target)) end
	
	if editBox then
		editBox:SetAttribute("chatType", "WHISPER")
		editBox:SetAttribute("tellTarget", target)
		editBox:SetText(text)
		ChatEdit_UpdateHeader(editBox)
	else
		ChatFrame_SendTell(target, frame)
	end
end

function Module:OnTextChanged(editBox, ...)
	local command, message = editBox:GetText():match("^(/%S+)%s(.*)$")
	if command == "/tt" or command == L["/tt"] then
		self:SendTellToTarget(editBox.chatFrame, message, editBox)
	end
	self.hooks[editBox].OnTextChanged(editBox, ...)	-- make sure to allow other addons to hook this script
end

function Module:OnEnable()
	for i = 1, 10 do
		local edit = _G[editBoxString:format(i)]
		if edit and not self:IsHooked(edit, "OnTextChanged") then
			self:HookScript(edit, "OnTextChanged")
		end
	end
end

function Module:OnDisable()
	for i = 1, 10 do
		local edit = _G[editBoxString:format(i)]
		if edit and self:IsHooked(edit, "OnTextChanged") then
			self:Unhook(edit, "OnTextChanged")
		end
	end
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds tell target slash command, |cff00ff00/tt|r."]
end