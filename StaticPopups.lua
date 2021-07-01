-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)

local ReloadUI = _G["ReloadUI"]

-- ElvUI_ChatTweaks.lua
StaticPopupDialogs["ECT_RLUI"] = {
	text = L["One or more of the changes you have made require you to reload your UI."],
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
}

-- Modules\AltNames.lua
StaticPopupDialogs['MENUITEM_SET_MAIN'] = {
	text = L["Who is %s's main?"],
	button1		= ACCEPT,
	button2		= CANCEL,
	hasEditBox = 1,
	maxLetters = 24,
	exclusive = 0,
	preferredIndex = 3,
	OnShow = function(frame)
		_G[frame:GetName().."EditBox"]:SetFocus()
	end,
	OnHide = function(frame)
		if ( _G[frame:GetName().."EditBox"]:IsShown() ) then
			_G[frame:GetName().."EditBox"]:SetFocus();
		end
		_G[frame:GetName().."EditBox"]:SetText("");
	end,
	OnAccept = function(popup, char)
		local Module = ElvUI_ChatTweaks:GetModule("Alt Names")
		if not Module then
			ElvUI_ChatTweaks:Print(("|cffff0000%s|r"):format(L["Unable to load the Alt Name module, please try again."]))
		else
			Module:Accept(popup, char, _G[popup:GetName().."EditBox"])
		end
	end,
	EditBoxOnEnterPressed = function(popup, char)
		local Module = ElvUI_ChatTweaks:GetModule("Alt Names")
		if not Module then
			ElvUI_ChatTweaks:Print(("|cffff0000%s|r"):format(L["Unable to load the Alt Name module, please try again."]))
		else
			local parent = popup:GetParent()
			Module:Accept(popup, char, parent.editBox)
		end
		popup:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(frame) frame:GetParent():Hide() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

-- Modules\Datatext.lua
StaticPopupDialogs["ECT_ENABLE_ALL"] = {
	text = L["Are you sure you want to enable all of the modules?"],
	button1 = L["Yes"],
	button2 = L["No"],
	OnAccept = function(self) ElvUI_ChatTweaks:EnableAllModules() end,
	timeout = 10,
	whileDead = true,
	hideOnEscape = true,
}

-- Modules\Datatext.lua
StaticPopupDialogs["ECT_DISABLE_ALL"] = {
	text = L["Are you sure you want to disable all of the modules?"],
	button1 = L["Yes"],
	button2 = L["No"],
	OnAccept = function(self) ElvUI_ChatTweaks:DisableAllModules() end,
	timeout = 10,
	whileDead = true,
	hideOnEscape = true,
}
