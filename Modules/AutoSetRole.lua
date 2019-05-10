-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Auto Set Role", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local E, _, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Auto Set Role"]
Module.namespace = string.gsub(Module.name, " ", "")

local role, spec, specName = nil, nil, nil
local hasPrinted = false

local db, options
local defaults = {
	global = {
		notify = false,
	},
}

function Module:SetRole(event)
	local isSet = event == "ACTIVE_TALENT_GROUP_CHANGED" and false or true
	
	spec = GetSpecialization()
	if not spec then return end
	role = GetSpecializationRole(spec)
	specName = spec and select(2, GetSpecializationInfo(spec))
	
	if InCombatLockdown() then
		if db.notify then
			self:Print(L["Role will not be set while in combat."])
		end
	else
		if spec == nil and not isSet then
			UnitSetRole("player", "NONE")
			
			if db.notify then
				self:Print(L["No role was set because you have no specialization."])
				hasPrinted = true
			end
		else
			UnitSetRole("player", role)
			
			if db.notify then
				self:Print((L["Role Set: %s%s|r"]):format(self.hex, role))
				hasPrinted = true
			end
		end
	end
end

function Module:OnEnable()
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "SetRole")
	self:RegisterEvent("GROUP_ROSTER_UPDATE", "SetRole")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "SetRole")
	
	-- auto accept role popup
	RolePollPopup:SetScript("OnShow", function() RolePollPopupAcceptButton:Click() end)
	
	-- so there's no print spam
	self.resetPrint = self:ScheduleRepeatingTimer(function() hasPrinted = false end, 30)
end

function Module:OnDisable()
	self:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:UnregisterEvent("GROUP_ROSTER_UPDATE")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	
	RolePollPopup:SetScript("OnShow", nil)
	
	-- disable it
	self:CancelTimer(self.resetPrint)
	self.resetPrint = nil
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(self.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
	self.hex = "|cffffffff"
end

function Module:Info()
	return L["Will automatically set your role based on your spec, when appropriate."]
end

function Module:GetOptions()
	if not options then
		options = {
			notify = {
				type = "toggle",
				order = 13,
				name = L["Notify on Role Set"],
				desc = L["Send a chat message when a role is set/changed."],
				get = function() return db.notify end,
				set = function(_, value) db.notify = value end,
			},
		}
	end
	return options
end

local function ValueColorUpdate(hex, r, g, b)
	Module.hex = hex
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true