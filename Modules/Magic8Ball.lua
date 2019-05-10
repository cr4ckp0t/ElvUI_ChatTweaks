-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Magic 8-Ball", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Magic 8-Ball"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		trigger = "!8ball",
		whisper = true,
		throttle = 5,
		filter = true,
		repeatQuestion = false,
		channels = {
			["GUILD"] = true,
			["OFFICER"] = false,
			["PARTY"] = false,
			["RAID"] = false,
			["INSTANCE_CHAT"] = false,
			["CHANNEL"] = false,
			["SAY"] = true,
			["YELL"] = true,
		},
		
		reminder = {
			channel = "GUILD",
		},
	}
}

local phrases = {
	-- affirmative phrases
	L["It is certain."],
	L["It is decidedly so."],
	L["Without a doubt."],
	L["Yes, definitely."],
	L["You may rely on it."],
	L["As I see it, yes."],
	L["Most likely."],
	L["Outlook good."],
	L["Yes"],
	L["Signs point to yes."],
	
	-- non-commital phrases
	L["Reply hazy, try again."],
	L["Ask again later."],
	L["Better not tell you now."],
	L["Cannot predict now."],
	L["Concentrate and ask again."],
	
	-- negative phrases
	L["Don't count on it."],
	L["My reply is no."],
	L["My sources say no."],
	L["Outlook not so good."],
	L["Very doubtful."],
}

local function RegexEscape(inStr)
	return inStr:gsub("%p", "%%%1")
end

local function MonitorChannel(self, event, message, author, ...)
	if not message or not author then return false end
	
	-- check to see if the message has the trigger
	if not Module.waiting and message:sub(1, #db.trigger) == db.trigger then
		local question = message:match(("%s (.+)"):format(RegexEscape(db.trigger)))
		local response = phrases[math.random(1, #phrases)]
		
		-- debugging
		if Module.debug then
			self:Print(question)
			self:Print(response)
		end
		
		-- send the response
		if db.whisper then
			if db.repeatQuestion then
				-- repeat the question
				SendChatMessage((L["You asked: %s"]):format(question), "WHISPER", nil, author)
			end
			SendChatMessage((L["Magic 8-Ball says: %s"]):format(response), "WHISPER", nil, author)
		else
			local channel = event:match("CHAT_MSG_(.+)")
			if channel then
				if db.repeatQuestion then
					SendChatMessage((L["You asked: %s"]):format(question), channel:upper(), nil, channel == "CHANNEL" and select(6, ...) or nil)
				end
				SendChatMessage((L["Magic 8-Ball says: %s"]):format(response), channel:upper(), nil, channel == "CHANNEL" and select(6, ...) or nil)
			elseif Module.debug and not channel then
				-- something happened
				self:Print(event)
			end
		end
		
		-- start the timer to throttle the responses
		self.waiting = true
		Module:ScheduleTimer(function() self.waiting = false end, db.throttle)
		
		return db.filter
	end
	return false
end

function Module:UpdateChannels()
	for index, value in pairs(db.channels) do
		local channel = ("CHAT_MSG_%s"):format(index:upper())
		if value then
			ChatFrame_AddMessageEventFilter(channel, MonitorChannel)
		else
			ChatFrame_RemoveMessageEventFilter(channel, MonitorChannel)
		end
	end
end

function Module:OnEnable()
	self:UpdateChannels()
end

function Module:OnDisable()
	for channel, _ in pairs(db.channels) do
		ChatFrame_RemoveMessageEventFilter(("CHAT_MSG_%s"):format(channel:upper()), MonitorChannel)
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(self.namespace, defaults)
	db = self.db.global
	Module.debug = ElvUI_ChatTweaks.db.global.debugging
	self.waiting = false	-- for our throttle
end

function Module:GetOptions()
	if not options then
		options = {
			trigger = {
				type = "input",
				order = 13,
				name = L["Trigger"],
				desc = L["Text to trigger the addon to answer a question."],
				get = function() return db.trigger end,
				set = function(_, value) db.trigger = value end,
			},
			whisper = {
				type = "toggle",
				order = 14,
				name = L["Whisper Answer"],
				desc = L["Whisper the response to the person.  Otherwise it will be answered in the same channel the request was sent."],
				get = function() return db.whisper end,
				set = function(_, value) db.whisper = value end,
			},
			throttle = {
				type = "range",
				order = 15,
				name = L["Throttle"],
				desc = L["Throttle to only answer a question every X seconds, to prevent spam.\n\n|cffff0000Not recommended to disable this.|r"],
				get = function() return db.throttle end,
				set = function(_, value) db.throttle = value end,
				min = 0, max = 120, step = 5, bigStep = 10,
			},
			filter = {
				type = "toggle",
				order = 16,
				name = L["Filter Line"],
				desc = L["Filter the line containing the question."],
				get = function() return db.filter end,
				set = function(_, value) db.filter = value end,
			},
			repeatQuestion = {
				type = "toggle",
				order = 17,
				name = L["Repeat Question"],
				desc = L["Repeat the question when giving a response."],
				get = function() return db.repeatQuestion end,
				set = function(_, value) db.repeatQuestion = value end,
			},
			channels = {
				type = "multiselect",
				order = 50,
				name = L["Channels to Monitor"],
				desc = L["Channels to look for questions."],
				values = {
					["GUILD"] = CHAT_MSG_GUILD,
					["OFFICER"] = CHAT_MSG_OFFICER,
					["PARTY"] = CHAT_MSG_PARTY,
					["RAID"] = CHAT_MSG_RAID,
					["INSTANCE_CHAT"] = INSTANCE_CHAT,
					["CHANNEL"] = L["Numbered Channels"],
					["SAY"] = CHAT_MSG_SAY,
					["YELL"] = CHAT_MSG_YELL,
				},
				get = function(_, key) return db.channels[key] end,
				set = function(_, key, value) db.channels[key] = value; Module:UpdateChannels(); end,
			},
			reminder = {
				type = "group",
				order = 99,
				name = L["Reminder"],
				args = {
					channel = {
						type = "select",
						order = 1,
						name = L["Output Channel"],
						desc = L["Channel to send the reminder to."],
						values = {
							["GUILD"] = CHAT_MSG_GUILD,
							["OFFICER"] = CHAT_MSG_OFFICER,
							["PARTY"] = CHAT_MSG_PARTY,
							["RAID"] = CHAT_MSG_RAID,
							["INSTANCE_CHAT"] = INSTANCE_CHAT,
							["SAY"] = CHAT_MSG_SAY,
							["YELL"] = CHAT_MSG_YELL,
						},
						get = function() return db.reminder.channel end,
						set = function(_, value) db.reminder.channel = value end,
					},
					send = {
						type = "execute",
						order = 2,
						name = L["Send Reminder"],
						desc = L["Click to send the reminder to the select channel that the Magic 8-Ball is listening."],
						func = function() SendChatMessage((L["Magic 8-Ball Says: I am ready to answer your questions!  Do \"%s <question>\" to ask me a question."]):format(db.trigger), db.reminder.channel) end,
					},
				},
			},
		}
	end
	return options
end

function Module:Info()
	return L["The classic Magic 8-Ball brought to World of Warcraft!"]
end