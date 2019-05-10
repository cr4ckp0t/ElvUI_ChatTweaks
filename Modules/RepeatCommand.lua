-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Repeat Command", "AceConsole-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Repeat Command"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db, options
local defaults = {
	global = {
		interval = 1
	}
}

local EditBox = CreateFrame("EditBox", "RepeatCommandEditBox")
EditBox:SetAutoFocus(false)
EditBox:ClearFocus()

function Module:RunCommand(command)
	if self.repeater and (self.times <= self.maxTimes) then
		EditBox:SetText(command)
		ChatEdit_SendText(EditBox)
		EditBox:Show()
		
		self.times = self.times + 1
		if self.times == self.maxTimes then
			self:CancelTimer(self.repeater, true)
			self.times, self.maxTimes = 0, 0
		end
	end
end

function Module:OnEnable()
	self:RegisterChatCommand("rpt", function(args)
		local rpt, command = args:match("^([^%s]+)%s+(.*)$")
		rpt = tonumber(rpt)
		if not rpt or not command or #command == 0 then
			print(L["|cffffff00Usage: /rpt <times> <command>|r"])
		elseif IsSecureCmd(command) then
			print(format(L["|cffffff00Unable to execute secure command.|r |cffffffff%s|r"], command))
		else
			self.times = 0
			self.maxTimes = rpt
			self.repeater = self:ScheduleRepeatingTimer("RunCommand", db.interval, command)
		end
	end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("rpt")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			interval = {
				type = "range",
				name = L["Execution Interval"],
				desc = L["Time, in seconds, in between running the command."],
				get = function() return db.interval end,
				set = function(_, value) db.interval = value end,
				min = 0.5, max = 60, step = 0.5
			}
		}
	end
	return options
end

function Module:Info()
	return L["Similar to the |cffffffIn Command|r module, except it will repeat the command X times."]
end