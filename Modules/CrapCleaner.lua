-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------

-- Modeled after BadBoy_CCleaner by funkydude
local Module = ElvUI_ChatTweaks:NewModule("Crap Cleaner", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Crap Cleaner"]
Module.namespace = string.gsub(Module.name, " ", "")

local notifyString = L["Crap Cleaner blocked a message from %s%s|r."]

local db, options
local defaults = {
	global = {
		icons = true,
		iconAction = "filter",
		triggers = {
			"anal",
			"dirge",
			"murloc",
			"rape",
			"[yY][oO][lL][oO]",
		},
		logging = true,
		notify = false,
	}
}

local function filterText(self, event, message, player, ...)
	local channel, found = select(5, ...), 0
	local noticeSent = false
	
	-- make sure there are triggers set
	if #db.triggers == 0 then return end
	-- only check "official" channels
	if event == "CHAT_MSG_CHANNEL" and channel == 0 then return end
	-- dont filter ourselves or guildies
	if not CanComplainChat(player) or UnitIsInMyGuild(player) then return end
	
	-- filter triggers
	for i = 1, #db.triggers do
		if message:lower():find(db.triggers[i]:lower(), nil, true) then
			-- found, filter it
			if not noticeSent and db.notify then 
				Module:Print(notifyString:format(ElvUI_ChatTweaks.hexColor, player))
				noticeSent = true
			end
			
			if db.logging and Module.log:IsEnabled() then
				Module.log:AddToLog("crap", event, player, message)
			end
			
			if Module.debug then Module:Print(("%s: %s"):format(player, message)) end
			return true
		end
	end
	
	-- filter icons, if set to
	if db.icons then
		local modify = false
		for i = 1, #Module.knownIcons do
			-- remove icon only
			if db.iconAction == "remove" then
				message, found = message:gsub(Module.knownIcons[i], "")	-- replace any icons found
				if Module.debug then Module:Print(("%s: %s"):format(player, message)) end
				if found > 0 then modify = true end
			-- filter entire line (useful for gold spammers in trade chat)
			elseif db.iconAction == "filter" and message:find(Module.knownIcons[i]) then
				if db.notify then Module:Print(notifyString:format(L["Chat message with icons"], player)) end
				if Module.debug then Module:Print(("%s: %s"):format(player, message)) end
				return true
			end
		end
		if modify then
			-- only send back the modified message if we actually did something to it
			return false, message, player, ...
		end
	end
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filterText)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filterText)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filterText)
	self.log = ElvUI_ChatTweaks:GetModule("Spam Log")	-- for logging
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", filterText)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", filterText)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", filterText)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetDefaults()
	return defaults
end

function Module:Info()
	return L["Filter annoying phrases in chat."]
end

function Module:GetOptions()
	if not options then
		options = {
			icons = {
				type = "toggle",
				order = 13,
				name = L["Filter Raid Icons"],
				desc = L["Filter out raid icons in chat."],
				get = function() return db.icons end,
				set = function(_, value) db.icons = value end,
			},
			iconAction = {
				type = "select",
				order = 14,
				name = L["Icon Action"],
				desc = L["Action to take when an icon is found."],
				values = {
					["filter"]	= L["Filter Entire Line"],
					["remove"]	= L["Remove Icon Only"],	
				},
				disabled = function() return not db.icons end,
				get = function() return db.iconAction end,
				set = function(_, value) db.iconAction = value end,
			},
			dummy = {
				type = "description",
				order = 15,
				name = "",
			},
			notify = {
				type = "toggle",
				order = 16,
				name = L["Notify on Filter"],
				desc = L["Notify you when a message is filtered."],
				get = function() return db.notify end,
				set = function(_, value) db.notify = value end,
			},
			logging = {
				type = "toggle",
				order = 17,
				name = L["Enable Logging"],
				desc = L["Toggle logging anything found to the Spam Log module."],
				get = function() return db.logging end,
				set = function(_, value) db.logging = value end,
			},
			triggers = {
				type = "input",
				order = 50,
				width = "full",
				multiline = true,
				name = L["Filter Triggers"],
				desc = L["Words or phrases that will trigger the filtering."],
				descStyle = "inline",
				get = function()
					if #db.triggers == 0 then return "" end
					local msgs = ""
					for i = 1, #db.triggers do
						if db.triggers[i]:trim() ~= "" and db.triggers[i]:trim() ~= nil then
							msgs = msgs .. db.triggers[i] .. "\n"
						end
					end
					return msgs
				end,
				set = function(_, value)
					db.triggers = {}
					local lines = {strsplit("\n", value)}
					for _, line in ipairs(lines) do
						if line ~= "" and line ~= nil then db.triggers[#db.triggers + 1] = line end
					end
				end
			},
		}
	end
	return options
end

-- From BadBoy_CCleaner by funkydude
Module.knownIcons = { --list of all known raid icon chat shortcuts
	"{%a%a%d}",
	"{[Xx]}",
	"{[Ss][Tt][Aa][Rr]}",
	"{[Cc][Ii][Rr][Cc][Ll][Ee]}",
	"{[Dd][Ii][Aa][Mm][Oo][Nn][Dd]}",
	"{[Tt][Rr][Ii][Aa][Nn][Gg][Ll][Ee]}",
	"{[Mm][Oo][Oo][Nn]}",
	"{[Ss][Qq][Uu][Aa][Rr][Ee]}",
	"{[Cc][Rr][Oo][Ss][Ss]}",
	"{[Ss][Kk][Uu][Ll][Ll]}",
	--deDE
	"{[Ss][Tt][Ee][Rr][Nn]}",
	"{[Kk][Rr][Ee][Ii][Ss]}",
	"{[Dd][Ii][Aa][Mm][Aa][Nn][Tt]}",
	"{[Dd][Rr][Ee][Ii][Ee][Cc][Kk]}",
	"{[Mm][Oo][Nn][Dd]}",
	"{[Vv][Ii][Ee][Rr][Ee][Cc][Kk]}",
	"{[Kk][Rr][Ee][Uu][Zz]}",
	"{[Tt][Oo][Tt][Ee][Nn][Ss][Cc][Hh][Ää]+[Dd][Ee][Ll]}",
	--frFR
	"{[Éé]+[Tt][Oo][Ii][Ll][Ee]}",
	"{[Cc][Ee][Rr][Cc][Ll][Ee]}",
	"{[Ll][Oo][Ss][Aa][Nn][Gg][Ee]}",
	--"{[Tt][Rr][Ii][Aa][Nn][Gg][Ll][Ee]}",
	"{[Ll][Uu][Nn][Ee]}",
	"{[Cc][Aa][Rr][Rr][Éé]+}",
	"{[Cc][Rr][Oo][Ii][Xx]}",
	"{[Cc][Rr][Ââ]+[Nn][Ee]}",
	-- Feel free to add translated icons
}