-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Guild Recruitment", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceComm-3.0", "AceSerializer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
local LibC = LibStub:GetLibrary("LibCompress")
local LibCE = LibC:GetAddonEncodeTable()
Module.name = L["Guild Recruitment"]
Module.namespace = string.gsub(Module.name, " ", "")

local GetServerTime = _G["GetServerTime"]
local C_Calendar_GetDate = C_Calendar.GetDate
local GetGameTime = _G["GetGameTime"]
local IsInGuild = _G["IsInGuild"]
local GetGuildInfo = _G["GetGuildInfo"]
local UnitIsDND = _G["UnitIsDND"]
local UnitName = _G["UnitName"]

--
-- Library functions
--

-- safe cut utf8 string
local function utf8cut(value, len)
	if type(value) == "string" and #value > 0 and len >= 1 then
		if #value > len then
			if value:byte(len) >= 192 then -- UTF-8 multibyte first byte
				value = value:sub(1, len - 1)
			elseif value:byte(len - 1) >= 224 then -- UTF-8 triplebyte first byte
				value = value:sub(1, len - 2)
			else
				value = value:sub(1, len)
			end
		end
	end
	
	return value
end

-- get server time in unix timestamp format
local function GetServerTime()
	local cdate = C_Calendar_GetDate()
	local weekday, month, day, year = cdate.weekday, cdate.month, cdate.monthDay, cdate.year
	local hours, minutes = GetGameTime()
	
	local timeset = { year = year, month = month, day = day, hour = hours, min = minutes }
	
	return time(timeset)
end


--
-- Addon configuration
--

-- format message (substitude some tags in text like $glevel and $gname)
local function FormatMessage(text)
	local msg = text

	-- replace $gname with guild name
	if IsInGuild() then
		local gname = GetGuildInfo("player")
		if gname then
			msg = string.gsub(msg, "$gname", gname)
		end
	end
	
	return msg
end

-- update message
function Module:SetMessage()
	-- split message
	local msg = { strsplit("\n", strtrim(self.db.global.message) .. "\n") }
	
	-- TODO: ugly code, split to functions
	
	-- only 2 lines allowed of 255 bytes each
	-- prepare to cut those lines
	local l1 = strtrim(msg[1])
	local l2 = strtrim(msg[2])
	
	-- compare line size before/afrer formatting
	local l1_before = #l1
	local l1_after = #FormatMessage(l1)
	local l1_diff = max(0, l1_after - l1_before)

	local l2_before = #l2
	local l2_after = #FormatMessage(l2)
	local l2_diff = max(0, l2_after - l2_before)
	
	-- cut lines to fit formatting
	l1 = utf8cut(strtrim(l1), 255 - l1_diff)
	l2 = utf8cut(strtrim(l2), 255 - l2_diff)
	
	-- put lines back together
	msg = strjoin("\n", l1, l2)
end

local db, options
local defaults = {
	global = {
		test_mode = false,

		message = "",
		timer = 5,
		min_lines = 100,
		announce_general = false,
		announce_trade = false,
		announce_lfg = true,

		guild_coop = true,
		guild_sync = true,
		sync_revision = 0,
		sync_key = "",

		set_dnd = false,
		dnd_message = "",
	}
}

-- declare config interface
function Module:GetOptions()
	if not options then
		options = {			
			test_mode = {
				type = "toggle",
				order = 17,
				name = L["Test mode"],
				desc = L["Doesn't send anything to channels, simulating only."],
				descStyle = "inline",
				width = "full",
				get = function(info) return db[ info[#info] ] end,
				set = function(info, value) db[ info[#info] ] = value; Module:SetTimer() end,
			},
			message_tab = {
				name = "Message",
				type = "group",
				order = 20,
				args = {
					message = {
						type = "input",
						order = 21,
						name = L["Message to announce, 2 lines max"],
						desc = L["Type the message to announce, every line will be announced. Message should not be longer than 2 lines."],
						multiline = 7,
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value; Module:SetMessage() end,
					},
					message_help = {
						type = "description",
						order = 22,
						name = L["You can use $gname tag in text. This will be replaced by your guild name."],
					},
					settings = {
						type = "header",
						order = 23,
						name = L["Announce settings"],
					},				
					timer = {
						type = "range",
						order = 24,
						name = L["Announce interval, minutes"],
						desc = L["How often announce your message to channel."],
						min = 1,
						max = 30,
						step = 1,
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value; Module:SetTimer() end,
					},
					min_lines = {
						type = "range",
						order = 25,
						name = L["SPAM protection, lines"],
						desc = L["This add-on will try to prevent spamming to idle channels. If there is no activity in a channel, then it waits a little longer. Specify how many lines should pass before add-on is allowed to announce message."],
						min = 0,
						max = 100,
						step = 10,
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value; Module:SetTimer() end,
					},
					channels = {
						type = "header",
						order = 26,
						name = L["Select channels"],
					},				
					announce_general = {
						type = "toggle",
						order = 27,
						name = L["Announce to General"],
						desc = L["Announce your message to General channel when out of a city."],
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value; Module:SetTimer() end,
					},
					announce_trade = {
						type = "toggle",
						order = 28,
						name = L["Announce to Trade"],
						desc = L["Announce your message to city trade channel."],
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value; Module:SetTimer() end,
					},
					announce_lfg = {
						type = "toggle",
						order = 29,
						name = L["Announce to LFG"],
						desc = L["Announce your message to LFG channel."],
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value; Module:SetTimer() end,
					},
				},
			},
			guild_tab = {
				name = "Guild Mode",
				type = "group",
				order = 30,
				args = {
					guild_coop = {
						type = "toggle",
						order = 31,
						name = L["Guild cooperation mode"],
						desc = L["Doesn't allow multiple announces from your guild members at the same time."],
						descStyle = "inline",
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value end,
					},
					guild_sync = {
						type = "toggle",
						order = 32,
						name = L["Allow guild synchronization"],
						desc = L["This will synchronize message and settings between guild members. Latter version of a message will be used by all guild members with synchronization enabled."],
						descStyle = "inline",
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value end,
					},
					sync_key_help = {
						type = "description",
						order = 33,
						name = L["SYNC_KEY_HELP"],
					},
					sync_key = {
						type = "input",
						order = 34,
						name = L["Synchronization key"],
						desc = L["Use this key to separate sync settings for different groups of peoples. Leave empty for default."],
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value end,
					},
				},
			},
			status_tab = {
				name = "Status",
				type = "group",
				order = 50,
				args = {
					set_dnd = {
						type = "toggle",
						order = 51,
						name = L["Set DND"],
						desc = L["Always set your DND status while announcing to channels"],
						descStyle = "inline",
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value; Module:SetDND(true) end,
					},
					dnd_msg = {
						type = "input",
						order = 52,
						name = L["Set DND message"],
						desc = L["Type DND message there."],
						width = "full",
						get = function(info) return db[ info[#info] ] end,
						set = function(info, value) db[ info[#info] ] = value; Module:SetDND(true) end,
					},
				},
			},
		}
	end
	return options
end

function Module:Info()
	return L["Send guild recruitment messages to various chat channels."]
end

--
-- Addon initialization
--

-- Code that you want to run when the addon is first loaded goes here.
function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
	
	-- setup variables
	self:InitVars()
end

-- Called when the addon is enabled
function Module:OnEnable()
	-- register events
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE", "EventChannelNotice")
	self:RegisterEvent("CHAT_MSG_CHANNEL", "EventChannelMsg")
	
	-- register comm events
	self:RegisterComm("GuildRecr", "EventComm")
	self:RegisterComm("GuildRecrAnnoun", "CommAnnounceOld") -- DEPRECATED: considered obsolete as of patch 4.1, we should limit the use of different prefixes, should be removed in later versions
	
	-- schedule timer
	self:SetTimer()
	
	-- init profile variables
	self:InitProfileVars()
end

-- Called when the addon is disabled
function Module:OnDisable()
	-- unregister events
	self:UnregisterAllEvents()
	
	-- unregister comm events
	self:UnregisterAllComm()
	
	-- cancel timers
	self:CancelAllTimers()
end

-- Initalize local variables
function Module:InitVars()
	-- general, trade and lfg channels id
	self.general_id = nil
	self.trade_id = nil
	self.lfg_id = nil
	
	-- channel msg counters
	self.trade_cnt = 0
	self.lfg_cnt = 0
	
	-- skip counter
	self.skip_cnt = 0
	
	-- guild coop mode, last advertised player name
	self.guild_coop_by = nil
	-- guild sync, last advertised config revision
	self.sync_revision_sent = 0
	
	-- dnd set trigger (fix reload)
	self.dnd_set = db.set_dnd
	
	-- upgrade version notification
	self.version_notice = false
	
	-- timer handle
	self.timer = nil
end

-- Initalize profile variables
function Module:InitProfileVars()
	-- sanitize sync data
	if not db.sync_revision or db.sync_revision > GetServerTime() then
		db.sync_revision = 0
	end
	
	if not db.sync_key then
		db.sync_key = ""
	end
end

-- Setup announce timer
function Module:SetTimer(drift)
	-- cancel running timer if any
	if self.timer then
		self:CancelTimer(self.timer, false)
		self.timer = nil
	end
	
	-- schedule new timer
		-- should put clients out of synchronization
		local timer_drift = 0
		if drift then
			timer_drift = random(drift)
		end
		
		self.timer = self:ScheduleRepeatingTimer("TimerAnnounce", db.timer * 60 + timer_drift)
end

-- LDB timer handler
--[[function Module:LDBTimer()
	-- update ldb text
	if not self.timer then
		self.ldb.text = L["Off"]
		return
	end

	-- calculate time (seconds) difference between now and target time
	local time_left = self:TimeLeft(self.timer)
	if time_left == nil then
		self.ldb.text = L["Off"]
		return
	end

	-- err what?
	if time_left < 0 then
		if debug then
			self:Print("DEBUG: LDB timer difference is negative!")
		end

		self.ldb.text = L["Off"]
		return
	end

	local time_min = time_left / 60
	local time_sec = time_left % 60

	-- handle 
	if not time_min or not time_sec then
		self.ldb.text = L["On"]
		return
	end

	-- more than a minute
	if time_min >= 1 then
		self.ldb.text = format(L["On (%d min)"], ceil(time_min))
		return
	else
		self.ldb.text = format(L["On (%d sec)"], time_sec)
		return
	end
end]]

-- set DND status if requested
function Module:SetDND(clear)
	-- clear DND status
	if clear and self.dnd_set and UnitIsDND("player") then
		if debug then
			self:Print("DEBUG: DND mode cleared")
		end
		
		self.dnd_set = false
		SendChatMessage("", "DND")
		return
	end
	
	-- set DND if required
	if clear or not db.set_dnd or not db.dnd_msg then
		return
	end
	
	if not UnitIsDND("player") then
		if debug then
			self:Print("DEBUG: DND mode set")
		end
		
		self.dnd_set = true
		SendChatMessage(db.dnd_msg, "DND")
	end
end

-- check for data available and addon running
function Module:IsDataReady()
	return db.message and strtrim(db.message) and (db.announce_general or db.announce_trade or db.announce_lfg)
end

-- get configuration revision number and a key as a string
function Module:GetConfRevStr()
	local revision = tostring(db.guild_sync and db.sync_revision or "sync_disabled")
	local key = db.sync_key
	
	if #key > 0 then
		return format("%s|%s", revision, key)
	else
		return revision
	end
end

-- offer configuration to guild or player
function Module:OfferConf(dest)
	if not dest or not self:IsDataReady() then
		if debug then
			self:Print("DEBUG: Offering configuration cancelled. Addon disabled or no data ready.")
		end
		
		return
	end
	
	-- select destination
	local dist, target
	if dest == "GUILD" then
		dist, target = "GUILD", nil
	else
		dist, target = "WHISPER", dest
	end
	
	if debug then
		self:Printf("DEBUG: Offering configuration to: %s (%s)", tostring(dist), tostring(target))
	end
	
	
	-- prepare an array of configs
	-- it is possible to define several versions of the config with different abi's
	-- and app should decide which version is suitable.
	
	-- abi is data structure specification if you like. as we can't handle data we arn't aware of
	-- we could add more data to the end, but we should not alter existing data specification
	-- on which previous versions of application relies. this is basic principe of backward compatibility.
	
	local conf = {
		-- define abi in descending order (later version on the top). app will use first compatible version
		
		-- only one version so far
		{
			abi = 1, -- abi version (integer)
			sync_revision = db.sync_revision, -- data revision
			test_mode = db.test_mode,
			message = db.message,
			timer = db.timer,
			min_lines = db.min_lines,
			announce_general = db.announce_general,
			announce_trade = db.announce_trade,
			announce_lfg = db.announce_lfg,
		},
	}
	
	-- compress and encode data
	conf = self:Serialize(conf)
	conf = LibC:Compress(conf)
	conf = LibCE:Encode(conf)
	
	-- send config
	--local msg = format("ConfigOffer %s %d %s", self:GetConfRevStr(), addon_revision, conf, "BULK")
	self:SendCommMessage("Module", msg, dist, target)
end

-- request configuration from guild or player
function Module:RequestConf(dest)
	if not dest then
		return
	end
	
	-- select destination
	local dist, target
	if dest == "GUILD" then
		dist, target = "GUILD", nil
	else
		dist, target = "WHISPER", dest
	end
	
	if debug then
		self:Printf("DEBUG: Requesting configuration from: %s (%s)", tostring(dist), tostring(target))
	end
	
	-- send request
	local msg = format("ConfigRequest %s", self:GetConfRevStr())
	self:SendCommMessage("Module", msg, dist, target)
end

-- validate and accept configuration
function Module:AcceptConf(text)
	if debug then
		self:Print("DEBUG: Accepting configuration...")
	end
	
	if type(text) ~= "string" then
		if debug then
			self:Print("DEBUG: Serialized data expected.")
		end
		
		return false
	end
	
	-- decode and decompress
	local data, err_msg
	data, err_msg = LibC:Decompress(LibCE:Decode(text))
	if not data then
		if debug then
			self:Print("DEBUG: Decompression failed! " .. err_msg)
		end
		
		return false
	end

	if debug then
		self:Printf("DEBUG: Data decompressed. Compressed size: %d. Decompressed size: %d.", #text, #data)
	end
	
	-- deserialize
	local success, conf_list = self:Deserialize(data)
	if not success or type(conf_list) ~= "table" then
		if debug then
			self:Print("DEBUG: Deserialization failed! table expected.")
		end
		
		return false
	end
	
	-- search for proper abi
	local abi = 1
	local config
	for i, v in ipairs(conf_list) do
		if debug then
			self:Printf("DEBUG: Considering data at index:%d abi:%s", i, tostring(type(v) == "table" and v.abi or nil))
		end
	
		if type(v) == "table" and v.abi == abi then
			config = v
			break
		end
	end
		
	-- validate basic minimum for abi
	if type(config.sync_revision) ~= "number" or type(config.message) ~= "string" then
		if debug then
			self:Print("DEBUG: data validation failed")
		end
		
		return false
	end
	
	-- and once again, should we update?
	if config.sync_revision <= db.sync_revision then
		if debug then
			self:Print("DEBUG: Err. config revision is older than ours!")
		end
		
		return false
	end
	
	-- reschedule timer with drift
	Module:SetTimer(30)
	
	if debug then
		self:Printf("DEBUG: Configuration accepted! Revision: %d", config.sync_revision)
	end
	
	return true
end


--
-- Event Handlers
--

-- Fired when you enter or leave a chat channel
function Module:EventChannelNotice(event, arg1, _, _, _, _, _, arg7, arg8)
	-- arg7 channel type (1 - General, 2 - Trade, 26 - LFG)
	-- arg8 channel number
	
	if debug then
		self:Printf("DEBUG: EventChannelNotice - Event: '%s' Type: '%s' Channel: '%s'", tostring(arg1), tostring(arg7), tostring(arg8))
	end
	
	-- sanity check
	if not arg1 or not arg7 or not arg8 then
		if debug then
			self:Print("DEBUG: EventChannelNotice - argument missing")
		end

		return
	end
	
	-- General channel
	if arg7 == 1 then
		if arg1 == "YOU_JOINED" or arg1 == "YOU_CHANGED" then
			if debug then
				self:Print("DEBUG: joined General channel.")
			end

			self.general_id = arg8
		else
			if debug then
				self:Print("DEBUG: left General channel.")
			end

			self.general_id = nil
		end
	end

	-- Trade channel
	if arg7 == 2 then
		if arg1 == "YOU_JOINED" then
			if debug then
				self:Print("DEBUG: joined Trade channel.")
			end

			self.trade_id = arg8
		else
			if debug then
				self:Print("DEBUG: left Trade channel.")
			end

			self.trade_id = nil
		end
	end

	-- LFG channel
	if arg7 == 26 then
		if arg1 == "YOU_JOINED" then
			if debug then
				self:Print("DEBUG: joined LFG channel.")
			end

			self.lfg_id = arg8
		else
			if debug then
				self:Print("DEBUG: left LFG channel.")
			end

			self.lfg_id = nil
		end
	end
	
	-- clear DND out of city
	if arg1 == "SUSPENDED" and (arg7 == 2 or arg7 == 26) and db.set_dnd then
		self:SetDND(true)
	end
end

-- Fired when the client receives a channel message.
function Module:EventChannelMsg(event, _, _, _, _, _, _, arg7, arg8)
	-- sanity check
	if not arg7 or not arg8 then
		if debug then
			self:Printf("DEBUG: EventChannelMsg - argument missing. Type: '%s' Channel: '%s'", tostring(arg7), tostring(arg8))
		end

		return
	end

	-- fix reload: rejoin channels if message received on that channel
	if arg7 == 1 then
		if debug and not self.general_id then
			self:Print("DEBUG: joined General channel.")
		end
		
		self.general_id = arg8
	end

	if arg7 == 2 then
		if debug and not self.trade_id then
			self:Print("DEBUG: joined Trade channel.")
		end
		
		self.trade_id = arg8
	end

	if arg7 == 26 then
		if debug and not self.lfg_id then
			self:Print("DEBUG: joined LFG channel.")
		end

		self.lfg_id = arg8
	end

	-- count trade messages
	if self.trade_id and arg8 == self.trade_id then
		self.trade_cnt = self.trade_cnt + 1
	end

	-- count lfg messages
	if self.lfg_id and arg8 == self.lfg_id then
		self.lfg_cnt = self.lfg_cnt + 1
	end
end

-- Announce timer handler
function Module:TimerAnnounce()
	-- enabled but no data/channels?!
	if not self:IsDataReady() then
		self:Print(L["Addon enabled, but no message or channels selected."])
		return
	end
	
	-- check channel availability and possibility to announce
	local can_trade	= self.trade_id and db.announce_trade and (self.trade_cnt >= db.min_lines or self.skip_cnt >= 2)
	local can_lfg	= self.lfg_id and db.announce_lfg and (self.lfg_cnt >= db.min_lines or self.skip_cnt >= 2)
	local can_general = self.general_id and db.announce_general and (not (self.trade_id and db.announce_trade) and not (self.lfg_id and db.announce_lfg))  -- use general only outside of a city
	
	-- guild sync check
	if IsInGuild() and db.guild_sync and self.sync_revision_sent < db.sync_revision then
		self:OfferConf("GUILD")
		self.sync_revision_sent = db.sync_revision
	end
	
	-- guild coop check
	if self.guild_coop_by then
		self:Printf(L["Skipping. Message already advertised by %s"], self.guild_coop_by)
		self.guild_coop_by = nil
		self.trade_cnt = 0
		self.lfg_cnt = 0
		self.skip_cnt = 0
		return
	end

	-- determine most active channel if both available
	if can_trade and can_lfg then
		if self.trade_cnt > self.lfg_cnt then
			can_lfg = false
		else
			can_trade = false
		end
	end
	
	-- announce to trade channel
	if can_trade then
		self:Printf(L["Announcing to Trade channel. Trade: %d LFG: %d"], self.trade_cnt, self.lfg_cnt)
		self.trade_cnt = 0
		self:Announce(self.trade_id)
		return
	end
	
	-- announce to lfg channel
	if can_lfg then
		self:Printf(L["Announcing to LFG channel. Trade: %d LFG: %d"], self.trade_cnt, self.lfg_cnt)
		self.lfg_cnt = 0
		self:Announce(self.lfg_id)
		return
	end
	
	-- announce to general channel
	if can_general then
		self:Printf(L["Announcing to General channel. Trade: %d LFG: %d"], self.trade_cnt, self.lfg_cnt)
		self:Announce(self.general_id)
		return
	end
	
	-- requirements not meet, print stats
	if self.trade_id or self.lfg_id then
		self:Printf(L["Skipping. Trade: %d LFG: %d"], self.trade_cnt, self.lfg_cnt)
		self.skip_cnt = self.skip_cnt + 1
	end
end

-- send message to specified channel
function Module:Announce(channel)
	if not channel or not db.message or not strtrim(db.message) then
		return
	end
	
	-- reset skip counter
	self.skip_cnt = 0
	
	-- split message and announce
	local msg = { strsplit("\n", strtrim(db.message)) }
	
	-- output 2 lines max
	for i = 1, 2 do
		if msg[i] and strtrim(msg[i]) ~= "" then
			local line = FormatMessage(strtrim(msg[i]))
			
			-- send message
			if #line > 0 then
				if db.test_mode then
					self:Print(L["Test mode"] .. ": " .. line)
				else
					SendChatMessage(line, "CHANNEL", nil, channel)
				end
			end
		end
	end

	-- announce guild event if needed
	if db.guild_coop and IsInGuild() then
		self:SendCommMessage("Module", "Announce " .. self:GetConfRevStr(), "GUILD")
	end
	
	-- set DND if needed
	self:SetDND()
end

-- addon communication event
function Module:EventComm(prefix, message, distribution, sender)
	-- should we care?
	if not message or not sender or sender == UnitName("player") then
		return
	end
	
	-- parse event and args
	local event, arg1, arg2, arg3 = strsplit(" ", message, 4)
	
	-- parse config revision
	local sender_revision, sender_key = strsplit("|", arg1 or "")
	sender_revision = tonumber(sender_revision)
	sender_key = sender_key or ""
	
	-- ANNOUNCE EVENT
	if event == "Announce" then
		if debug then
			self:Printf("DEBUG: EventComm - Announce event received from '%s'. Revision: '%s'", sender, tostring(arg1))
		end
		
		-- check config key
		if sender_key ~= db.sync_key then
			if debug then
				self:Print("DEBUG: EventComm - Skipping. Different sync key.")
			end
			
			return
		end

		-- guild coop mode check
		if db.guild_coop then
			self.guild_coop_by = sender
		end
		
		-- guild sync mode check
		if not db.guild_sync then
			-- done
			return
		end
		
		-- check config revision
		if sender_revision == nil then
			if debug then
				self:Print("DEBUG: EventComm - Skipping. No config revision.")
			end
			
			return
		end
		
		-- sanity check
		if sender_revision > GetServerTime() then
			if debug then
				self:Printf("DEBUG: EventComm - Error: sender revision (%d) is in the future (now %d)!", sender_revision, GetServerTime())
			end
			
			return		
		end
		
		-- should we update?
		if sender_revision > db.sync_revision then
			self:RequestConf(sender)
		end
		
		-- should we send our config?
		if self:IsDataReady() and sender_revision < db.sync_revision then
			self:OfferConf(sender)
		end

	-- OFFER EVENT
	elseif event == "ConfigOffer" then
		if debug then
			self:Printf("DEBUG: EventComm - ConfigOffer event received from '%s'. Revision: '%s' AddonVer: '%s' Size: %d", sender, tostring(arg1), tostring(arg2), #tostring(arg3 or ""))
		end
		
		-- guild sync mode check
		if not db.guild_sync then
			-- done
			return
		end
		
		-- check config revision
		if sender_revision == nil then
			if debug then
				self:Printf("DEBUG: EventComm - Can not parse sender revision: %s", tostring(arg1))
			end
			
			return
		end

		-- check config key
		if sender_key ~= db.sync_key then
			if debug then
				self:Print("DEBUG: EventComm - Skipping. Different sync key.")
			end
			
			return
		end
		
		-- sanity check
		if sender_revision > GetServerTime() then
			if debug then
				self:Printf("DEBUG: EventComm - Error: sender revision (%d) is in the future (now %d)!", sender_revision, GetServerTime())
			end
			
			return		
		end
		
		-- should we update?
		if sender_revision > db.sync_revision then
			if self:AcceptConf(arg3) then
				self:Printf(L["GuildSync: Accepted configuration update from %s"], sender)
			else
				self:Printf(L["GuildSync: Error. Bad configuration received from %s"], sender)
			end
		end
		
		-- should we send our config?
		if self:IsDataReady() and sender_revision < db.sync_revision then
			self:OfferConf(sender)
		end
		
	-- REQUEST EVENT
	elseif event == "ConfigRequest" then
		if debug then
			self:Printf("DEBUG: EventComm - ConfigRequest event received from '%s'. Revision: '%s'", sender, tostring(arg1))
		end

		-- guild sync mode check
		if not db.guild_sync then
			-- done
			return
		end

		-- check config revision
		if sender_revision == nil then
			if debug then
				self:Printf("DEBUG: EventComm - Can not parse sender revision: %s", tostring(arg1))
			end
			
			return
		end

		-- check config key
		if sender_key ~= db.sync_key then
			if debug then
				self:Print("DEBUG: EventComm - Skipping. Different sync key.")
			end
			
			return
		end

		-- sanity check
		if sender_revision > GetServerTime() then
			if debug then
				self:Printf("DEBUG: EventComm - Error: sender revision (%d) is in the future (now %d)!", sender_revision, GetServerTime())
			end
			
			return		
		end
		
		-- should we send our config?
		if self:IsDataReady() and sender_revision < db.sync_revision then
			self:OfferConf(sender)
		end
	
	-- UNKNOWN EVENT
	elseif debug then
		self:Printf("DEBUG: EventComm - Unregistered event received from '%s'. Event: '%s' arg1: '%s' arg2: '%s' arg3: '%s'", sender, tostring(event), tostring(arg1), tostring(arg2), tostring(arg3))
	end
end

-- Fired when another player on your guild announce message to channels
-- DEPRECATED: this function considered obsolete as of patch 4.1, we should limit the use of different prefixes and remove this few versions later
function Module:CommAnnounceOld(prefix, message, distribution, sender)
	-- should we care?
	if not sender or sender == UnitName("player") then
		return
	end

	if db.guild_coop then
		self.guild_coop_by = sender
	end
	
	-- notify player that a newer version of addon available
	--@non-alpha@
	-- init notify list
	if type(self.old_CommAnnounce) ~= "table" then
		self.old_CommAnnounce = {}
	end
	--@end-non-alpha@
end
