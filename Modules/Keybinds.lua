-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Keybinds", "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Keybinds"]
Module.namespace = string.gsub(Module.name, " ", "")

local options

BINDING_HEADER_ECT = L["ElvUI ChatTweaks"]
BINDING_NAME_ECTOFFICER = L["Officer Channel"]
BINDING_NAME_ECTGUILD = L["Guild Channel"]
BINDING_NAME_ECTPARTY = L["Party Channel"]
BINDING_NAME_ECTRAID = L["Raid Channel"]
BINDING_NAME_ECTRAIDWARN = L["Raid Warning Channel"]
BINDING_NAME_ECTINSTANCE = L["Instance Channel"]
BINDING_NAME_ECTSAY = L["Say"]
BINDING_NAME_ECTYELL = L["Yell"]
BINDING_NAME_ECTWHISPER = L["Whisper"]
BINDING_NAME_ECTONE = (L["Channel %d"]):format(1)
BINDING_NAME_ECTTWO = (L["Channel %d"]):format(2)
BINDING_NAME_ECTTHREE = (L["Channel %d"]):format(3)
BINDING_NAME_ECTFOUR = (L["Channel %d"]):format(4)
BINDING_NAME_ECTFIVE = (L["Channel %d"]):format(5)
BINDING_NAME_ECTSIX = (L["Channel %d"]):format(6)
BINDING_NAME_ECTSEVEN = (L["Channel %d"]):format(7)
BINDING_NAME_ECTEIGHT = (L["Channel %d"]):format(8)
BINDING_NAME_ECTNINE = (L["Channel %d"]):format(9)
BINDING_NAME_ECTSMARTGROUP = L["Smart Group Channel"]

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			keybinds = {
				type = "description",
				order = 13,
				name = L["|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r"],
				width = "full",
			}
			--[[
			officer = {
				type = "keybinding",
				order = 13,
				name = BINDING_NAME_ECTOFFICER,
				get = function() return GetBindingKey("ECTOFFICER") end,
				set = function(_, value)
					db["ECTOFFICER"] = value
					SetBinding(value, "ECTOFFICER")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			guild = {
				type = "keybinding",
				order = 14,
				name = BINDING_NAME_ECTGUILD,
				get = function() return GetBindingKey("ECTGUILD") end,
				set = function(_, value)
					db["ECTGUILD"] = value
					SetBinding(value, "ECTGUILD")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			party = {
				type = "keybinding",
				order = 15,
				name = BINDING_NAME_ECTPARTY,
				get = function() return GetBindingKey("ECTPARTY") end,
				set = function(_, value)
					db["ECTPARTY"] = value
					SetBinding(value, "ECTPARTY")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			raid = {
				type = "keybinding",
				order = 16,
				name = BINDING_NAME_ECTRAID,
				get = function() return GetBindingKey("ECTRAID") end,
				set = function(_, value)
					db["ECTRAID"] = value
					SetBinding(value, "ECTRAID")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			raidwarn = {
				type = "keybinding",
				order = 17,
				name = BINDING_NAME_ECTRAIDWARN,
				get = function() return GetBindingKey("ECTRAIDWARN") end,
				set = function(_, value)
					db["ECTRAIDWARN"] = value
					SetBinding(value, "ECTRAIDWARN")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			instance = {
				type = "keybinding",
				order = 18,
				name = BINDING_NAME_ECTINSTANCE,
				get = function() return GetBindingKey("ECTINSTANCE") end,
				set = function(_, value)
					db["ECTINSTANCE"] = value
					SetBinding(value, "ECTINSTANCE")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			say = {
				type = "keybinding",
				order = 19,
				name = BINDING_NAME_ECTSAY,
				get = function() return GetBindingKey("ECTSAY") end,
				set = function(_, value)
					db["ECTSAY"] = value
					SetBinding(value, "ECTSAY")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			yell = {
				type = "keybinding",
				order = 20,
				name = BINDING_NAME_ECTYELL,
				get = function() return GetBindingKey("ECTYELL") end,
				set = function(_, value)
					db["ECTYELL"] = value
					SetBinding(value, "ECTYELL")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			whisper = {
				type = "keybinding",
				order = 21,
				name = BINDING_NAME_ECTWHISPER,
				get = function() return GetBindingKey("ECTWHISPER") end,
				set = function(_, value)
					db["ECTWHISPER"] = value
					SetBinding(value, "ECTWHISPER")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			one = {
				type = "keybinding",
				order = 22,
				name = BINDING_NAME_ECTONE,
				get = function() return GetBindingKey("ECTONE") end,
				set = function(_, value)
					db["ECTONE"] = value
					SetBinding(value, "ECTONE")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			two = {
				type = "keybinding",
				order = 23,
				name = BINDING_NAME_ECTTWO,
				get = function() return GetBindingKey("ECTTWO") end,
				set = function(_, value)
					db["ECTTWO"] = value
					SetBinding(value, "ECTTWO")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			three = {
				type = "keybinding",
				order = 24,
				name = BINDING_NAME_ECTTHREE,
				get = function() return GetBindingKey("ECTTHREE") end,
				set = function(_, value)
					db["ECTTHREE"] = value
					SetBinding(value, "ECTTHREE")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			four = {
				type = "keybinding",
				order = 25,
				name = BINDING_NAME_ECTFOUR,
				get = function() return GetBindingKey("ECTFOUR") end,
				set = function(_, value)
					db["ECTFOUR"] = value
					SetBinding(value, "ECTFOUR")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			five = {
				type = "keybinding",
				order = 26,
				name = BINDING_NAME_ECTFIVE,
				get = function() return GetBindingKey("ECTFIVE") end,
				set = function(_, value)
					db["ECTFIVE"] = value
					SetBinding(value, "ECTFIVE")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			six = {
				type = "keybinding",
				order = 27,
				name = BINDING_NAME_ECTSIX,
				get = function() return GetBindingKey("ECTSIX") end,
				set = function(_, value)
					db["ECTSIX"] = value
					SetBinding(value, "ECTSIX")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			seven = {
				type = "keybinding",
				order = 28,
				name = BINDING_NAME_ECTSEVEN,
				get = function() return GetBindingKey("ECTSEVEN") end,
				set = function(_, value)
					db["ECTSEVEN"] = value
					SetBinding(value, "ECTSEVEN")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			eight = {
				type = "keybinding",
				order = 29,
				name = BINDING_NAME_ECTEIGHT,
				get = function() return GetBindingKey("ECTEIGHT") end,
				set = function(_, value)
					db["ECTEIGHT"] = value
					SetBinding(value, "ECTEIGHT")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			nine = {
				type = "keybinding",
				order = 30,
				name = BINDING_NAME_ECTNINE,
				get = function() return GetBindingKey("ECTNINE") end,
				set = function(_, value)
					db["ECTNINE"] = value
					SetBinding(value, "ECTNINE")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			smartgroup = {
				type = "keybinding",
				order = 31,
				name = BINDING_NAME_ECTSMARTGROUP,
				disabled = function() return not ElvUI_ChatTweaks:ModuleEnabled("Group Say Command") end,
				get = function() return GetBindingKey("ECTSMARTGROUP") end,
				set = function(_, value)
					db["ECTSMARTGROUP"] = value
					SetBinding(value, "ECTSMARTGROUP")
					SaveBindings(GetCurrentBindingSet())
				end,
			},
			]]--
		}
	end
	return options
end

function Module:Info()
	return L["Provides keybinds to make talking in a specific chat easier."]
end