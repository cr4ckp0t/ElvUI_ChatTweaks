-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Developer Tools", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Developer Tools"]
Module.namespace = string.gsub(Module.name, " ", "")

local classes = {
	[L["DEATHKNIGHT"]] = true,
	[L["DRUID"]] = true,
	[L["HUNTER"]] = true,
	[L["MAGE"]] = true,
	[L["MONK"]] = true,
	[L["PALADIN"]] = true,
	[L["PRIEST"]] = true,
	[L["ROGUE"]] = true,
	[L["SHAMAN"]] = true,
	[L["WARLOCK"]] = true,
	[L["WARRIOR"]] = true,
}

local db, options
local defaults = {
	global = {
		chatEvents = {
			enable = true,
			watch = {
				["GUILD"] = false,
				["OFFICER"] = false,
				["CHANNEL"] = true,
				["SAY"] = false,
				["YELL"] = false,
				["RAID"] = false,
				["PARTY"] = false,
			},
			frame = "ChatFrame4",
		},
	}
}

local function HexToRGB(hex)
	-- incoming string must 6 characters long
	if string.len(hex) ~= 6 then
		return 0, 0, 0
	end
	
	-- convert the three parts to their RGB values
	local red = tonumber(hex:sub(1, 2), 16) / 255
	local green = tonumber(hex:sub(3, 4), 16) / 255
	local blue = tonumber(hex:sub(5, 6), 16) / 255
	
	-- return the values rounded to two decimal places
	return ("%.2f"):format(red), ("%.2f"):format(green), ("%.2f"):format(blue)
end

local function MonitorChat(self, event, message, ...)
	if not db.chatEvents.enable then return false end
	local cf = _G[db.chatEvents.frame]
	local chan = event:match("CHAT_MSG_(.+)")
	if cf then
		cf:AddMessage(("|cff00ff96%s:|r |cffffffff%s|r"):format(chan, message))
	end
	return false
end

function Module:UpdateChannels()
	for index, value in pairs(db.chatEvents.watch) do
		local channel = ("CHAT_MSG_%s"):format(index:upper())
		if not value then
			ChatFrame_RemoveMessageEventFilter(channel, MonitorChat)
		else
			ChatFrame_AddMessageEventFilter(channel, MonitorChat)
		end
	end
end

function Module:OnEnable()
	self:RegisterChatCommand("ctdev", function(args)
		local command = self:GetArgs(args)
		
		if command == "version" then
			self:Print((L["Version: |cff1784d1%s|r"]):format(select(1, GetBuildInfo())))
		elseif command == "build" then
			self:Print((L["Build: |cff1784d1%s|r"]):format(select(2, GetBuildInfo())))
		elseif command == "date" then
			self:Print((L["Build Date: |cff1784d1%s|r"]):format(select(3, GetBuildInfo())))
		elseif command == "interface" then
			self:Print((L["TOC Version: |cff1784d1%s|r"]):format(select(4, GetBuildInfo())))
		elseif command == "locale" then
			self:Print((L["Client Locale: |cff1784d1%s|r"]):format(GetLocale()))
		else
			self:Print(L["Available parameters are |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."])
		end
	end)
	
	-- converts hex colors into their rgb values
	self:RegisterChatCommand("hextorgb", function(args)
		local str = self:GetArgs(args)
		if not str or str == "" or string.len(str) ~= 6 then
			print(L["|cffffff00Usage: /hextorgb <hex code>|r"])
			return
		end
		
		local red, green, blue = HexToRGB(str)
		self:Print((L["|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"]):format(str, str:upper(), red, green, blue))
	end)
	
	-- converts rgb values into their hex color
	self:RegisterChatCommand("rgbtohex", function(args)
		local red, green, blue = self:GetArgs(args, 3)

		if not red or not green or not blue then
			print(L["|cffffff00Usage: /rgbtohex <red> <green> <blue>|r"])
			return
		end
		local hex = ("%02x%02x%02x"):format(tonumber(red) * 255, tonumber(green) * 255, tonumber(blue) * 255)
		self:Print((L["|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"]):format(hex, hex:upper(), red, green, blue))
	end)
	
	-- class colors
	self:RegisterChatCommand("ccolor", function(args)
		local str = self:GetArgs(args)
		if not str or str == "" or not RAID_CLASS_COLORS[str:upper()] then
			print(L["|cffffff00Usage: /ccolor <class>|r"])
			return
		end
		local color = RAID_CLASS_COLORS[str:upper()]
		local hex = ("%02x%02x%02x"):format(color.r * 255, color.g * 255, color.b * 255)
		self:Print((L["|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"]):format(hex, hex:upper(), color.r, color.g, color.b))
	end)
	
	self:UpdateChannels()
end

function Module:OnDisable()
	self:UnregisterChatCommand("ctdev")
	self:UnregisterChatCommand("hextorgb")
	self:UnregisterChatCommand("rgbtohex")
	self:UnregisterChatCommand("ccolor")
	
	for channel, _ in pairs(db.chatEvents.watch) do
		ChatFrame_RemoveMessageEventFilter(("CHAT_MSG_%s"):format(channel:upper()), MonitorChat)
	end
	
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(self.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			chatEvents = {
				type = "group",
				order = 50,
				name = L["Chat Events"],
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Monitor Chat Events"],
						desc = L["Toggle the monitoring of chat events."],
						get = function() return db.chatEvents.enable end,
						set = function(_, value) db.chatEvents.enable = value end,
					},
					frame = {
						type = "select",
						order = 2,
						name = L["Output Frame"],
						desc = L["Frame to output the messages to."],
						disabled = function() return not db.chatEvents.enable end,
						values = function()
							local frames = {}
							for i = 1, 18 do
								local cf = _G[("ChatFrame%d"):format(i)]
								if cf and cf ~= COMBATLOG then
									frames[("ChatFrame%d"):format(i)] = ("Chat Frame %d"):format(i)
								end
							end
							return frames
						end,
						get = function() return db.chatEvents.frame end,
						set = function(_, value) db.chatEvents.frame = value end,
					},
					watch = {
						type = "multiselect",
						order = 2,
						name = L["Channels to Watch"],
						desc = L["Select the channels you want to monitor."],
						disabled = function() return not db.chatEvents.enable end,
						values = {
							["GUILD"] = CHAT_MSG_GUILD,
							["OFFICER"] = CHAT_MSG_OFFICER,
							["CHANNEL"] = L["Num Channels"],
							["SAY"] = CHAT_MSG_SAY,
							["YELL"] = CHAT_MSG_YELL,
							["RAID"] = CHAT_MSG_RAID,
							["PARTY"] = CHAT_MSG_PARTY,
						},
						get = function(_, key) return db.chatEvents.watch[key] end,
						set = function(_, key, value) db.chatEvents.watch[key] = value; Module:UpdateChannels(); end,
					},
				},
			},
		}
	end
	return options
end

function Module:Info()
	return L["Provides a few tools to help me (Lockslap), develop this addon as well as diagnose and fix any errors that are reported.\n\n|cff00ff00You can leave this addon disabled unless I (Lockslap) ask you to enable it for some debugging.|r"]
end