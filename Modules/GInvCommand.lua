-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("GInvite Alternate Command", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["GInvite Alternate Command"]
Module.namespace = string.gsub(Module.name, " ", "")

function Module:OnEnable()
	if CanGuildInvite() then
		self:RegisterChatCommand("ginv", function(args)
			local invite = self:GetArgs(args)
			if not invite then
				print(L["|cffffff00Usage: /ginvite <name>|r"])
			elseif UnitIsInMyGuild(invite) then
				print(L["|cffffff00Character already in your guild."])
			else
				local inGuild, _, _ = GetGuildInfo(invite)
				if inGuild then
					print(L["|cffffff00Character already in a guild."])
				else
					GuildInvite(invite)
				end
			end
		end)
	end
end

function Module:OnDisable()
	self:UnregisterChatCommand("ginv")
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Provides |cff00ff00/ginv|r, an alternative to |cff00ff00/ginvite|r command, for us lazy folks."]
end