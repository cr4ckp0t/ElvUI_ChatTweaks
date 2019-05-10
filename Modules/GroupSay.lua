-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Group Say Command", "AceHook-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Group Say Command"]
Module.namespace = string.gsub(Module.name, " ", "")

-- module vars
local _G	 = getfenv(0)
local format = string.format

function Module:OnTextChanged(object)
	local text = object:GetText()
	if text:sub(1, 4) == "/gs " then
		object:SetText(self:GetGroup(true) .. text:sub(5))
		ChatEdit_ParseText(object, 0)
	end
	self.hooks[object].OnTextChanged(object)
end

function Module:GetGroup(slash)
	local inInstance, instanceType = IsInInstance()
	if inInstance or GetNumSubgroupMembers() > 0 then
		-- determine the type
		if instanceType == "pvp" or instanceType == "arena" then
			return slash and "/i " or "INSTANCE_CHAT"
		elseif IsInRaid() and GetNumGroupMembers() > 0 then
			-- lfr or regular raid
			if IsLFGModeActive(LE_LFG_CATEGORY_LFR) then
				return slash and "/i " or "INSTANCE_CHAT"
			else
				return slash and "/ra " or "RAID"
			end
		elseif not IsInRaid() and GetNumSubgroupMembers() > 0 then
			-- lfd or regular party
			if IsLFGModeActive(LE_LFG_CATEGORY_LFD) then
				return slash and "/i " or "INSTANCE_CHAT"
			else
				return slash and "/p " or "PARTY"
			end
		end
	else
		return slash and "/s " or "SAY"
	end
end

function Module:OnEnable()
	for i = 1, 10 do
		if _G[("ChatFrame%dEditBox"):format(i)] and not self:IsHooked(_G[("ChatFrame%dEditBox"):format(i)], "OnTextChanged") then
			self:HookScript(_G[format("ChatFrame%dEditBox", i)], "OnTextChanged")
		end
	end
	
	if not self.slashRegistered then
		self:RegisterChatCommand("gs", function(message)
			local inInstance, instanceType = IsInInstance()
			if inInstance or GetNumSubgroupMembers() > 0 then
				-- determine the type
				if instanceType == "pvp" or instanceType == "arena" then
					SendChatMessage(message, "INSTANCE_CHAT", nil)
				elseif IsInRaid() and GetNumGroupMembers() > 0 then
					SendChatMessage(message, IsLFGModeActive(LE_LFG_CATEGORY_LFR) and "INSTANCE_CHAT" or "RAID")
				elseif not IsInRaid() and GetNumSubgroupMembers() > 0 then
					SendChatMessage(message, IsLFGModeActive(LE_LFG_CATEGORY_LFD) and "INSTANCE_CHAT" or "PARTY")
				end
			else
				SendChatMessage(message, "SAY", nil)
			end
		end)
		self.slashRegistered = true
	end
end

function Module:OnDisable()
	for i = 1, 10 do
		if _G[("ChatFrame%dEditBox"):format(i)] and self:IsHooked(_G[("ChatFrame%dEditBox"):format(i)], "OnTextChanged") then
			self:Unhook(_G[("ChatFrame%dEditBox"):format(i)], "OnTextChanged")
		end
	end

	if self.slashRegistered then
		self:UnregisterChatCommand("gs")
		self.slashRegistered = false
	end
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically."]
end