-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Auto Ding", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Auto Ding"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		dontAlways = true,
		chance = 50,
		minDelay = 1,
		maxDelay = 5,
		spamDelay = 60,
		messages = {"Congrats #name#!"},
		guild = true,
		raid = true,
		party = true,
		whisper = true,
		say = true,
		yell = true,
		afk = true,
		dnd = true,
		player = true,
		
		-- to prevent abuse
		lastDing = {}
	}
}

local last = {
	guild = nil,
	raid = nil,
	party = nil,
	whisper = nil,
	say = nil,
	yell = nil
}

function Module:PopulateFilters(filters)
	db.message = {}
	for _, value in pairs(filters) do
		if value ~= "" and value ~= nil then db.messages[#db.messages + 1] = value end
	end
end

function Module:FiltersToString()
	local trigs = ""
	for i = 1, #db.messages do
		if db.messages[i]:trim() ~= "" and db.messages[i]:trim() ~= nil then
			trigs = trigs .. db.messages[i] .. "\n"
		end
	end
	return trigs
end

function Module:Ding(settings)
	local temp = {strsplit("-", settings[1])}
	local sender = temp[1]
	local message = db.messages[random(1, #db.messages)]:gsub("#name#", sender):gsub("#level#", UnitLevel(sender))
	
	-- debugging messages
	if self.debug == true then
		self:Print(message)
	end
	
	if settings[2] == "WHISPER" then
		-- whisper syntax for sendchatmessage is a little different
		SendChatMessage(message, settings[2], nil, settings[1])
	else
		SendChatMessage(message, settings[2])
	end
end

function Module:MonitorChat(event, message, sender)
	local temp = {strsplit("-", sender)}
	local senderName = temp[1]
	
	-- dont run if afk/dnd and appropriate setting is enabled
	if db.afk and UnitIsAFK("player") then return end
	if db.dnd and UnitIsDND("player") then return end
	if db.player and senderName == UnitName("player") then return end
	
	-- sometimes (randomly) the function will return to prevent annoyances
	if db.dontAlways then
		local number, percent = random(1, 10), db.chance / 10
		if type(number) == "number" and type(percent) == "number" then
			if number > percent then return end	-- stop execution
		end
	end
	
	-- debugging
	if self.debug == true then
		self:Print(event, message, sender)
	end
	
	if message:lower():find("%f[%a]ding%f[%A]") ~= nil then
		if db.lastDing[sender] == nil or db.lastDing[sender] <= (time() - db.spamDelay) then
			local delay = random(db.minDelay, db.maxDelay)
			-- guild
			if event == "CHAT_MSG_GUILD" and db.guild then
				if last.guild ~= sender then
					self:ScheduleTimer("Ding", delay, {sender, "GUILD"})
				end
				last.guild = sender
			-- party
			elseif event == "CHAT_MSG_PARTY" and db.party and not UnitInRaid(sender) and UnitInParty(sender) then
				if last.party ~= sender then
					self:ScheduleTimer("Ding", delay, {sender, "PARTY"})
				end
				last.party = sender
			-- raid
			elseif event == "CHAT_MSG_RAID" and db.raid and UnitInRaid(sender) then
				if last.raid ~= sender then
					self:ScheduleTimer("Ding", delay, {sender, "PARTY"})
				end
				last.raid = sender
			-- whisper
			elseif event == "CHAT_MSG_WHISPER" and db.whisper then
				if last.whisper ~= sender then
					self:ScheduleTimer("Ding", delay, {sender, "WHISPER"})
				end
				last.whisper = sender
			-- say
			elseif event == "CHAT_MSG_SAY" and db.say then
				if last.say ~= sender then
					self:ScheduleTimer("Ding", delay, {sender, "SAY"})
				end
				last.say = sender
			-- yell
			elseif event == "CHAT_MSG_YELL" and db.yell then
				if last.yell ~= sender then
					self:ScheduleTimer("Ding", delay, {sender, "YELL"})
				end
				last.yell = sender
			end
			db.lastDing[sender] = time()
			
		end
	end
end

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_GUILD", "MonitorChat")
	self:RegisterEvent("CHAT_MSG_PARTY", "MonitorChat")
	self:RegisterEvent("CHAT_MSG_RAID", "MonitorChat")
	self:RegisterEvent("CHAT_MSG_SAY", "MonitorChat")
	self:RegisterEvent("CHAT_MSG_YELL", "MonitorChat")
	self:RegisterEvent("CHAT_MSG_WHISPER", "MonitorChat")
end

function Module:OnDisable()
	self:UnregisterAllEvents()
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Automatically congratulates someone when they say \"ding\" in chat."]
end

function Module:GetOptions()
	if not options then
		options = {
			dontAlways = {
				type = "toggle",
				order = 13,
				name = L["Dont Always Run"],
				desc = L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always congratulate."],
				get = function() return db.dontAlways end,
				set = function(_, value) db.dontAlways = value end,
			},
			chance = {
				type = "range",
				order = 14,
				name = L["Percent Chance"],
				desc = L["The percent chance the module has to congratulate someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."],
				disabled = function() return not db.dontAlways end,
				get = function() return db.chance end,
				set = function(_, value) db.chance = value end,
				min = 0, max = 100, step = 10,
			},
			minDelay = {
				type = "range",
				order = 15,
				name = L["Minimum Delay"],
				desc = L["Minimum time, in seconds, to wait before congratulating someone."],
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
				desc = L["Maximum time, in seconds, to wait before congratulating someone."],
				get = function() return db.maxDelay end,
				set = function(_, value)
					db.maxDelay = value
					options.minDelay.max = value
				end,
				min = 0, max = 30, step = 1,
			},
			spamDelay = {
				type = "range",
				order = 17,
				name = L["Spam Delay"],
				desc = L["The time, in seconds, it takes for the same person to trigger the addon by saying ding."],
				get = function() return db.spamDelay end,
				set = function(_, value) db.spamDelay = value end,
				min = 5, max = 120, step = 1,
			},
			messages = {
				type = "input",
				order = 98,
				multiline = true,
				width = "full",
				name = L["Ding Messages"],
				desc = L["Messages to use when someone says \"ding\".\n\n|cffFA6400Wildcards|r\n|cff00ff00#name#|r - Who said ding.\n|cff00ff00#guild#|r - Their current level."],
				get = function() return Module:FiltersToString() end,
				set = function(_, value) Module:PopulateFilters({strsplit("\n", value:trim())}) end,
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
					player = {
						type = "toggle",
						order = 3,
						name = L["Self"],
						desc = L["Disable if you say ding."],
						get = function() return db.player end,
						set = function(_, value) db.player = value end,
					},
				}
			},
			chats = {
				type = "group",
				guiInline = true,
				order = 100,
				name = L["Chats To Monitor"],
				args = {
					guild = {
						type = "toggle",
						name = L["Guild"],
						desc = L["Monitor guild chat."],
						get = function() return db.guild end,
						set = function(_, value) db.guild = value end,
					},
					raid = {
						type = "toggle",
						name = L["Raid"],
						desc = L["Monitor raid chat."],
						get = function() return db.raid end,
						set = function(_, value) db.raid = value end,
					},
					party = {
						type = "toggle",
						name = L["Party"],
						desc = L["Monitor party chat."],
						get = function() return db.party end,
						set = function(_, value) db.party = value end,
					},
					say = {
						type = "toggle",
						name = L["Say"],
						desc = L["Monitor say chat."],
						get = function() return db.say end,
						set = function(_, value) db.say = value end,
					},
					yell = {
						type = "toggle",
						name = L["Yell"],
						desc = L["Monitor yell chat."],
						get = function() return db.yell end,
						set = function(_, value) db.yell = value end,
					},
					whisper = {
						type = "toggle",
						name = L["Whispers"],
						desc = L["Monitor whispers."],
						get = function() return db.whisper end,
						set = function(_, value) db.whisper = value end,
					}
				}
			}
		}
	end
	return options
end