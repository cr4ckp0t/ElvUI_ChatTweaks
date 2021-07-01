-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Auto Set Role", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local E, _, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Auto Set Role"]
Module.namespace = string.gsub(Module.name, " ", "")

local unpack = _G["unpack"]
local UnitInRaid = _G["UnitInRaid"]
local UnitInParty = _G["UnitInParty"]
local GetSpecialization = _G["GetSpecialization"]
local UnitGroupRolesAssigned = _G["UnitGroupRolesAssigned"]
local GetSpecializationRole = _G["GetSpecializationRole"]
local InCombatLockdown = _G["InCombatLockdown"]
local UnitSetRole = _G["UnitSetRole"]

local db, options
local defaults = {
	global = {
		notify = false,
	},
}

function Module:SetRole()
    if not (UnitInRaid("player") or UnitInParty("player")) then return end

    local spec = GetSpecialization()
    if not spec then return end

    local curRole = UnitGroupRolesAssigned("player")
    local specRole = GetSpecializationRole(spec)
    if curRole ~= specRole then
        if InCombatLockdown() then
            if db.notify then
                self:Print(L["Role will not be set while in combat."])
            end
        else
            UnitSetRole("player", specRole)

            if db.notify then
                self:Print(L["Role Set: %s%s|r"]:format(self.hex, specRole))
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
end

function Module:OnDisable()
	self:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:UnregisterEvent("GROUP_ROSTER_UPDATE")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")

	RolePollPopup:SetScript("OnShow", nil)
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
