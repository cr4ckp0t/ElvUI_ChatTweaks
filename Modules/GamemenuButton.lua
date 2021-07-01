-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Gamemenu Button", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
local lib = LibStub("LibElv-GameMenu-1.0")
Module.name = L["Gamemenu Button"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

local HideUIPanel = _G["HideUIPanel"]

local _G = _G
local HideUIPanel = HideUIPanel

local db
local defaults = {
	global = {
		gamemenu = {
			hide = false,
		}
	}
}

function Module:BuildGameMenu()
	local buttons = {
		[1] = {
			["name"] = "GameMenu_CTCConfig",
			["text"] = L["%sChat Tweaks|r"]:format(ElvUI_ChatTweaks.hexColor),
			["func"] = function() ElvUI_ChatTweaks:ToggleConfig(); HideUIPanel(_G["GameMenuFrame"]) end,
		},
	}
	for i = 1, #buttons do
		lib:AddMenuButton(buttons[i])
	end

	lib:UpdateHolder()
end

function Module:OnEnable()
	self:BuildGameMenu()
	db.gamemenu.hide = false
	GameMenu_CTCConfig:Show()
end

function Module:OnDisable()
	db.gamemenu.hide = true
	GameMenu_CTCConfig:Hide()
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	Module.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds a gamemenu button.\n\n|cffffff00To disable the button, simply disable this module.\n\nPlease do a full reload after disable or enable.|r"]
end
