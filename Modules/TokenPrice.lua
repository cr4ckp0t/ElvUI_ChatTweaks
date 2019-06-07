-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpotx (US, Lightbringer)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Token Price", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Token Price"]..ElvUI_ChatTweaks.NewSign
Module.namespace = string.gsub(Module.name, " ", "")

local C_WowTokenPublic_UpdateMarketPrice = C_WowTokenPublic.UpdateMarketPrice
local C_WowTokenPublic_GetCurrentMarketPrice = C_WowTokenPublic.GetCurrentMarketPrice
local GetMoneyString = _G["GetMoneyString"]

local format = string.format

local clearCMD = L["|cff00ff00%s|r or |cff00ff00%s|r or |cff00ff00%s|r"]

local db, options
local defaults = {
	global = {
		login = true,
	}
}

function Module:GetOptions()
	if not options then
		options = {			
			login = {
				type = "toggle",
				order = 17,
				name = L["Login"],
				desc = L["Show current token price at login."],
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value; end,
			},
		}
	end
	return options
end

function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k == 0) then
			break
		end
	end
	return formatted
end

function Module:PLAYER_LOGIN()
	if db.login then
		C_WowTokenPublic_UpdateMarketPrice()
		ShowTokenPrice = true	
	end
end

function Module:TOKEN_MARKET_PRICE_UPDATED()
	if ShowTokenPrice then
		local currentPrice = C_WowTokenPublic_GetCurrentMarketPrice()
		if not currentPrice or currentPrice == nil or currentPrice == '' or currentPrice == 0 then
			ElvUI_ChatTweaks:Print("The Blizzard token API is down.")
			return
		end
		ElvUI_ChatTweaks:Print("Current token price:|cffFFFF00 " .. comma_value(GetMoneyString(currentPrice)) .. "")
		ShowTokenPrice = false
	end
end

function Module:OnEnable()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("TOKEN_MARKET_PRICE_UPDATED")
	
	self:RegisterChatCommand("tp", function() C_WowTokenPublic_UpdateMarketPrice(); ShowTokenPrice = true end)
	self:RegisterChatCommand("token",	function() C_WowTokenPublic_UpdateMarketPrice(); ShowTokenPrice = true end)
	self:RegisterChatCommand("tokens",	function() C_WowTokenPublic_UpdateMarketPrice(); ShowTokenPrice = true end)
end

function Module:OnDisable()
	self:UnregisterEvent("PLAYER_LOGIN")
	self:UnregisterEvent("TOKEN_MARKET_PRICE_UPDATED")

	self:UnregisterChatCommand("tp")
	self:UnregisterChatCommand("token")
	self:UnregisterChatCommand("tokens")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds chat commands to show the current server token price in the chat windows.\n\n"] .. format(clearCMD, "/tp", "/token", "/tokens")
end