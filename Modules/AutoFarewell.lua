-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Auto Farewell", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Auto Farewell"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db, options
local defaults = {
	global = {
		dontAlways = true,
		chance = 50,
		minDelay = 1,
		maxDelay = 5,
		guild = true,
		gMessages = {},
		whisper = false,
		wMessages = {},
		afk = true,
		dnd = true,
	}
}

local guildLeave = format(ERR_GUILD_LEAVE_S, "(.+)")

function Module:GuildFarewell(settings)
	SendChatMessage(db.gMessages[random(1, db.gMessages)]:gsub("#name#", settings[1]):gsub("#guild#", settings[2]), "GUILD", nil)
end

function Module:SendFarewell(settings)
	SendChatMessage(db.wMessages[random(1, db.wMessages)]:gsub("#name#", settings[1]):gsub("#guild#", settings[2]), "WHISPER", nil, settings[1])
end

function Module:CHAT_MSG_SYSTEM(event, message, ...)
	if not IsInGuild() or not message or (not db.guild and not db.whisper) then return end
	
	-- dont run if afk/dnd and setting is enabled
	if db.afk and UnitIsAFK("player") then return end
	if db.dnd and UnitIsDND("player") then return end
	
	if db.dontAlways then
		local number, percent = random(1, 10), tonumber(db.chance) / 10
		if number > percent then return end
	end
	
	local who = message:match(guildLeave)
	if who ~= nil then
		local guildName, _, _ = GetGuildInfo("player")
		-- guild message
		if db.guild then
			self:ScheduleTimer("GuildFarewell", random(db.minDelay, db.maxDelay), {who, guildName})
		end
		
		-- whisper
		if db.whisper then
			self:ScheduleTimer("SendFarewell", random(db.minDelay, db.maxDelay), {who, guildName})
		end
	end
end

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_SYSTEM")
end

function Module:OnDisable()
	self:UnregisterEvent("CHAT_MSG_SYSTEM")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Automatically bid someone farewell when they leave your guild."]
end

function Module:GetOptions()
	if not options then
		options = {
			dontAlways = {
				type = "toggle",
				order = 13,
				name = L["Dont Always Run"],
				desc = L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always run."],
				get = function() return db.dontAlways end,
				set = function(_, value) db.dontAlways = value end,
			},
			chance = {
				type = "range",
				order = 14,
				name = L["Percent Chance"],
				desc = L["The percent chance the module has to bid someone farewell.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."],
				disabled = function() return not db.dontAlways end,
				get = function() return db.chance end,
				set = function(_, value) db.chance = value end,
				min = 0, max = 100, step = 10,
			},
			minDelay = {
				type = "range",
				order = 15,
				name = L["Minimum Delay"],
				desc = L["Minimum time, in seconds, to wait before bidding someone farewell."],
				get = function() return db.minDelay end,
				set = function(_, value)
					db.minDelay = value
					options.maxDelay.min = value
				end,
				min = 0, max = 30, step = 1,
			},
			maxDelay = {
				type = "range",
				order = 16,
				name = L["Maximum Delay"],
				desc = L["Maximum time, in seconds, to wait before bidding someone farewell."],
				get = function() return db.maxDelay end,
				set = function(_, value)
					db.maxDelay = value
					options.minDelay.max = value
				end,
				min = 0, max = 30, step = 1,
			},
			disableIf = {
				type = "group",
				order = 99,
				name = L["Disable if..."],
				guiInline = true,
				args = {
					afk = {
						type = "toggle",
						order = 1,
						name = L["AFK"],
						desc = L["Disable while you're AFK flagged."],
						get = function() return db.afk end,
						set = function(_, value) db.afk = value end,
					},
					dnd = {
						type = "toggle",
						order = 2,
						name = L["Busy"],
						desc = L["Disable while you're DND flagged."],
						get = function() return db.dnd end,
						set = function(_, value) db.dbd = value end,
					},
				}
			},
			guildOptions = {
				type = "group",
				order = 99,
				name = L["Guild Options"],
				guiInline = true,
				args = {
					guild = {
						type = "toggle",
						order = 1,
						width = "full",
						name = L["Send Guild Messages"],
						desc = L["Send messages to guild chat when someone leaves."],
						get = function() return db.guild end,
						set = function(_, value) db.guild = value end,
					},
					gMessages = {
						type = "input",
						order = 2,
						multiline = true,
						width = "full",
						name = L["Guild Messages"],
						desc = L["Messages to use in guild chat when someone leaves your guild.\n\n|cffFA6400Wildcards|r\n|cff00ff00#name#|r - Person who left.\n|cff00ff00#guild#|r - Name of your guild."],
						disabled = function() return not db.guild end,
						get = function()
							if #db.gMessages == 0 then return "" end
							local msgs = ""
							for i = 1, #db.gMessages do
								if db.gMessages[i]:trim() ~= "" and db.gMessages[i]:trim() ~= nil then
									msgs = msgs .. db.gMessages[i] .. "\n"
								end
							end
							return msgs
						end,
						set = function(_, value)
							db.gMessages = {}
							local lines = {strsplit("\n", value)}
							for _, line in pairs(lines) do
								if line ~= "" then db.gMessages[#db.gMessages + 1] = line end
							end
						end,
					}
				}
			},
			whisperOptions = {
				type = "group",
				order = 100,
				name = L["Whisper Options"],
				guiInline = true,
				args = {
					whisper = {
						type = "toggle",
						order = 1,
						width = "full",
						name = L["Send Whisper"],
						desc = L["Send a whisper to the person who left."],
						get = function() return db.whisper end,
						set = function(_, value) db.whisper = value end,
					},
					wMessages = {
						type = "input",
						order = 2,
						multiline = true,
						width = "full",
						name = L["Whisper Messages"],
						desc = L["Messages to use in the whisper when someone leaves your guild.\n\n|cffFA6400Wildcards|r\n|cff00ff00#name#|r - Person who left.\n|cff00ff00#guild#|r - Name of your guild."],
						disabled = function() return not db.whisper end,
						get = function()
							if #db.wMessages == 0 then return "" end
							local msgs = ""
							for i = 1, #db.wMessages do
								if db.wMessages[i]:trim() ~= "" and db.wMessages[i]:trim() ~= nil then
									msgs = msgs .. db.wMessages[i] .. "\n"
								end
							end
							return msgs
						end,
						set = function(_, value)
							db.wMessages = {}
							local lines = {strsplit("\n", value)}
							for _, line in pairs(lines) do
								if line ~= "" then db.wMessages[#db.wMessages + 1] = line end
							end
						end,
					}
				}
			},
		}
	end
	return options
end