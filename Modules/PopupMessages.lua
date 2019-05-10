-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Popup Messages", "AceConsole-3.0", "LibSink-2.0")
local E, _, _, _, _ = unpack(ElvUI)
local CH = E:GetModule("Chat")
local LSM = LibStub("LibSharedMedia-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Popup Messages"]
Module.namespace = string.gsub(Module.name, " ", "")

local keywords = {}

local db, options
local defaults = {
	global = {
		filterLine = true,
		colorByChannel = true,
		ignoreYours = true,
		color = {r = 1.0, g = 1.0, b = 0},	-- yellow
		output = "Popup",
		channels = {
			["CHANNEL"] = true,
			["EMOTE"] = true,
			["GUILD"] = true,
			["OFFICER"] = false,
			["PARTY"] = false,
			["PARTY_LEADER"] = false,
			["RAID"] = false,
			["RAID_LEADER"] = false,
			["RAID_WARNING"] = false,
			["INSTANCE_CHAT"] = false,
			["INSTANCE_CHAT_LEADER"] = false,
			["SAY"] = true,
			["YELL"] = true,
			["WHISPER"] = true,
		},
	}
}

local function UCWords(link)
	return link:lower():gsub("(%w+)", function(first)
		return first:gsub("^%l", string.upper)
	end)
end

local function FindKeywords(self, event, text, author, ...)

	-- ignore if message sent by the player
	if db.ignoreYours and author:lower() == UnitName("player"):lower() then return end
	
	local matchedWords, found = {}, false
	for i = 1, #{string.split(" ", text)} do
		local word = select(i, string.split(" ", text))
		if not word:find("|") then
			for keyword, _ in pairs(CH.Keywords) do
				if word:lower() == keyword:lower() then
					matchedWords[word] = E.media.hexvaluecolor .. word .. '|r'
					found = true
				end
			end
		end
	end
	
	if found then
		local channel = event:match("CHAT_MSG_(.+)")
		local r, g, b
		if db.colorByChannel then
			r, g, b = GetMessageTypeColor(channel == "CHANNEL" and "CHANNEL2" or channel)
		else
			r = db.color.r
			g = db.color.g
			b = db.color.b
		end
		
		if channel == "RAID_WARNING" then
			channel = "RW"
		elseif channel == "RAID_LEADER" then
			channel = "RL"
		elseif channel == "PARTY_LEADER" then
			channel = "PL"
		elseif channel == "INSTANCE_CHAT" then
			channel = "Instance"
		elseif channel == "INSTANCE_CHAT_LEADER" then
			channel = "IL"
		else
			channel = UCWords(channel)
		end
	
		for word, replaceWord in pairs(matchedWords) do
			if text == word then
				text = text:gsub(word, replaceWord)
			elseif text:find(" " .. word) then
				text = text:gsub(" " .. word, " " .. replaceWord)
			elseif text:find(word .. " ") then
				text = text:gsub(word .. " ", replaceWord .. " ")
			end
		end
		
		-- send the text to libsink
		Module:Pour(("[%s][%s]: %s"):format(channel, author, text), r, g, b)
		return db.filterLine
	else
		return false -- do not filter
	end
end

function Module:OnEnable()
	for index, value in pairs(db.channels) do
		if value == true then
			ChatFrame_AddMessageEventFilter(("CHAT_MSG_%s"):format(index:upper()), FindKeywords)
		end
	end
end

function Module:OnDisable()
	for index, value in pairs(db.channels) do
		if value == true then
			ChatFrame_RemoveMessageEventFilter(("CHAT_MSG_%s"):format(index:upper()), FindKeywords)
		end
	end
end

function Module:Popup(source, text, r, g, b, ...)
	if UIFrameIsFlashing(CT_PopupFrame) then
		UIFrameFlashRemoveFrame(CT_PopupFrame)
	end
	
	CT_PopupFrame.fadeOut = 5
	CT_PopupFrame:SetAlpha(1.0)
	CT_PopupFrameText:SetTextColor(r, g, b)
	CT_PopupFrameText:SetText(text)
	
	-- setup the font
	local font, _, style = ChatFrame1:GetFont()
	local _, fontSize = GameFontNormal:GetFont()
	CT_PopupFrameText:SetFont(font, fontSize, style)
	CT_PopupFrameText:SetNonSpaceWrap(false)
	CT_PopupFrame:SetWidth(math.min(math.max(64, CT_PopupFrameText:GetStringWidth() + 20), 520))
	CT_PopupFrame:SetHeight(64)
	CT_PopupFrame:SetBackdropBorderColor(r, g, b)
	
	CT_PopupFrameText:ClearAllPoints()
	CT_PopupFrameText:SetPoint("TOPLEFT", CT_PopupFrame, "TOPLEFT", 10, 10)
	CT_PopupFrameText:SetPoint("BOTTOMRIGHT", CT_PopupFrame, "BOTTOMRIGHT", -10, -10)
	CT_PopupFrameText:Show()
	
	-- setup the fade in/out
	local inTime, outTime, holdTime = 1, CT_PopupFrame.fadeOut, 4
	local fadeInfo, fadeInfoOut = {}, {}
	fadeInfo.timeToFade = inTime
	fadeInfo.mode = "IN"
	fadeInfo.fadeHoldTime = holdTime
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = 1.0
	fadeInfo.finishedFunc = UIFrameFade
	fadeInfo.finishedArg1 = CT_PopupFrame
	fadeInfo.finishedArg2 = fadeInfoOut
	
	fadeInfoOut.startAlpha = 1.0
	fadeInfoOut.endAlpha = 0
	fadeInfoOut.timeToFade = outTime
	fadeInfoOut.mode = "OUT"
	fadeInfoOut.finishedFunc = function() CT_PopupFrameText:Hide() end
	
	UIFrameFade(CT_PopupFrame, fadeInfo)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	self:SetSinkStorage(self.db.profile)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:RefreshChannels()
	for index, value in pairs(db.channels) do
		if value == true then
			ChatFrame_AddMessageEventFilter(("CHAT_MSG_%s"):format(index:upper()), FindKeywords)
		else
			ChatFrame_RemoveMessageEventFilter(("CHAT_MSG_%s"):format(index:upper()), FindKeywords)
		end
	end
end

function Module:GetOptions()
	if not options then
		options = {
			filterLine = {
				type = "toggle",
				order = 13,
				name = L["Filter Line"],
				desc = L["If a keyword is found should the module filter the line?"],
				get = function() return db.filterLine end,
				set = function(_, value) db.filterLine = value end,
			},
			colorByChannel = {
				type = "toggle",
				order = 14,
				name = L["Color by Channel"],
				desc = L["Color the messages by the channel the message came from."],
				get = function() return db.colorByChannel end,
				set = function(_, value) db.colorByChannel = value end,
			},
			ignoreYours = {
				type = "toggle",
				order = 15,
				name = L["Ignore Your Messages"],
				desc = L["Ignore any messages you send containing keywords."],
				get = function() return db.ignoreYours end,
				set = function(_, value) db.ignoreYours = value end,
			},
			color = {
				type = "color",
				order = 16,
				name = L["Font Color"],
				desc = L["Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel."],
				disabled = function() return not db.colorByChannel end,
				get = function() return db.color.r, db.color.g, db.color.b end,
				set = function(_, r, g, b) db.color.r = r; db.color.g = g; db.color.b = b; end,
			},
			playSound = {
				type = "toggle",
				order = 17,
				name = L["Play Sound"],
				desc = L["Play a sound when it pops up."],
				get = function() return db.playSound end,
				set = function(_, value) db.playSound = value end,
			},
			channels = {
				type = "multiselect",
				order = -1,
				name = L["Channels to Monitor"],
				desc = L["Select the channels you want monitored."],
				values = {
					["CHANNEL"] = L["Channel"],
					["EMOTE"] = CHAT_MSG_EMOTE,
					["GUILD"] = CHAT_MSG_GUILD,
					["OFFICER"] = CHAT_MSG_OFFICER,
					["PARTY"] = CHAT_MSG_PARTY,
					["PARTY_LEADER"] = CHAT_MSG_PARTY_LEADER,
					["RAID"] = CHAT_MSG_RAID,
					["RAID_LEADER"] = CHAT_MSG_RAID_LEADER,
					["RAID_WARNING"] = CHAT_MSG_RAID_WARNING,
					["INSTANCE_CHAT"] = INSTANCE_CHAT,
					["INSTANCE_CHAT_LEADER"] = INSTANCE_CHAT_LEADER,
					["SAY"] = CHAT_MSG_SAY,
					["YELL"] = CHAT_MSG_YELL,
					["WHISPER"] = CHAT_MSG_WHISPER_INFORM,
				},
				get = function(_, key) return db.channels[key] end,
				set = function(_, key, value)
					db.channels[key] = value
					Module:RefreshChannels()
				end,
			},
		}
		
		-- add our popup frame to libsink
		self:RegisterSink(L["Popup"], L["PopupMessage"], L["Shows messages in a popup frame."], "Popup")
		options.output = self:GetSinkAce3OptionsDataTable()
		options.output.name = L["Output To..."]
		options.output.order = 100
		options.output.guiInline = true
	end
	return options
end

function Module:Info()
	return L["When an ElvUI keyword is found it will show the message in a popup frame."]
end	