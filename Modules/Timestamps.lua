-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Timestamps", "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Timestamps"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format
local strsub = string.sub
local strsplit = string.split

local db
local options
local defaults = {
	global = {
		format = "%X",
		customFormat = nil,
		copyLinks = true,
		colorByChannel = false,
		color = { r = 0.45, g = 0.45, b = 0.45 },
		frames = {
			[1] = true,
			[3] = true,
			[4] = true,
			[5] = true,
			[6] = true,
			[7] = true,
		}
	}
}

-- function is based on one used by easycopy
-- this sanitizes the link text so there arent any link issues
function Module:Sanitize(unclean)
	local msg, part, mode = "", "", 0
	
	for i = 1, 8 do
		unclean = unclean:gsub(("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(i), ("{rt%d}"):format(i))
	end
	
	while unclean:find("(%d-) |4(.-):(.-);") do
		local _, _, num, sing, plur = unclean:find("(%d-) |4(.-):(.-);")
		unclean = unclean:gsub("(%d-) |4(.-):(.-);", ("%s %s"):format(num, num == "1" and sing or plur), 1)
	end
	
	local retStat = 0
	for i = 1, #unclean do
		if unclean == "" then break end
		if mode == 0 then
			if unclean:sub(1, 2) == "|H" then
				mode = 1
				unclean = unclean:sub(3)
			elseif unclean:sub(1, 2) == "|T" then
				mode = 3
				retStat = 0
				unclean = unclean:sub(3)
				part = ""
			elseif unclean:sub(1, 2) == "||" then
				unclean = unclean:sub(3)
				msg = msg .. "||"
			elseif unclean:sub(1, 2) == "|c" or unclean:sub(1, 2) == "|C" then
				unclean = unclean:sub(11)
			elseif unclean:sub(1, 2) == "|r" or unclean:sub(1, 2) == "|R" then
				unclean = unclean:sub(3)
			else
				msg = msg .. unclean:sub(1, 1)
				unclean = unclean:sub(2)
			end
		elseif mode == 1 then
			if unclean:sub(1, 2) == "|h" then
				mode = 2
				unclean = unclean:sub(3)
			else
				unclean = unclean:sub(2)
			end
		elseif mode == 2 then
			if unclean:sub(1, 2) == "|h" then
				mode = 0
				unclean = unclean:sub(3)
			elseif unclean:sub(1, 2) == "|T" then
				mode = 3
				retStat = 2
				unclean = unclean:sub(3)
				part = ""
			elseif unclean:sub(1, 2) == "||" then
				unclean = unclean:sub(3)
				msg = msg .. "||"
			elseif unclean:sub(1, 2) == "|c" or unclean:sub(1, 2) == "|C" then
				unclean = unclean:sub(11)
			elseif unclean:sub(1, 2) == "|r" or unclean:sub(1, 2) == "|R" then
				unclean = unclean:sub(3)
			else
				msg = msg .. unclean:sub(1, 1)
				unclean = unclean:sub(2)
			end
		elseif mode == 3 then
			if unclean:sub(1, 2) == "|t" then
				mode = retStat
				unclean = unclean:sub(3)
				if part:sub(1, -4) == "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" then
					msg = msg .. ("{rt%s}"):format(part:sub(-3, -3))
				end
			else
				part = part .. unclean:sub(1, 1)
				unclean = unclean:sub(2)
			end
		end
	end
	msg = msg:gsub("/", "/1"):gsub("|", "/2")
	return msg
end

function Module:AddMessage(frame, text, ...)
	local id = frame:GetID()
	if id and db.frames[id] and not(CHAT_TIMESTAMP_FORMAT) then
		if not text then 
			return self.hooks[frame].AddMessage(frame, text, ...)
		end
		if not db.copyLinks then
			text = db.colorByChannel and ("[%s] %s"):format(date(db.customFormat or db.format), text) or ("|cff%02x%02x%02x[%s]|r %s"):format(db.color.r * 255, db.color.g * 255, db.color.b * 255, date(db.customFormat or db.format), text)
		else
			local color = db.colorByChannel and "" or ("|cff%02x%02x%02x"):format(db.color.r * 255, db.color.g * 255, db.color.b * 255)
			local link = "%s|Hctc:%s|h[%s]|h%s"
			text = link:format(color, ("[%s] %s"):format(date(db.customFormat or db.format), self:Sanitize(text)), date(db.customFormat or db.format), db.colorByChannel and "" or "|r") .. " " .. text
		end
	end
	return self.hooks[frame].AddMessage(frame, text, ...)
end

local SetItemRef_ = SetItemRef
SetItemRef = function(link, ...)
	if link:sub(1, 3) == "ctc" then
		local CFEB = ChatEdit_ChooseBoxForSend()
		local msg = link:sub(5):gsub("/1", "/"):gsub("/2", "|")
		if not IsShiftKeyDown() then
			if not CFEB:IsShown() then
				ChatEdit_ActivateChat(CFEB)
			end
			CFEB:Insert(msg)
			CFEB:HighlightText()
		else
			local chatType = CFEB:GetAttribute("chatType")
			if chatType == "CHANNEL" then
				SendChatMessage(msg, "CHANNEL", nil, CFEB:GetAttribute("channelTarget"))
			elseif chatType == "WHISPER" then
				SendChatMessage(msg, "WHISPER", nil, CFEB:GetAttribute("tellTarget"))
			elseif chatType == "BN_WHISPER" then
				local tellTarget = tonumber(strsub(select(2, strsplit("|", CFEB:GetAttribute("tellTarget"))), 3))
				if tellTarget > -1 then
					BNSendWhisper(tellTarget, msg)
				end
			else
				SendChatMessage(msg, chatType)
			end
		end
		return
	end
	--return
	SetItemRef_(link, ...)
end

function Module:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[format("ChatFrame%d", i)]
		if cf ~= COMBATLOG then
			self:RawHook(cf, "AddMessage", true)
		end
	end
	for _, frame in ipairs(self.TempChatFrames) do
		self:RawHook(_G[frame], "AddMessage", true)
	end
	
	-- disable blizzard's default timestamps
	if GetCVar("showTimestamps") ~= "none" then
		SetCVar("showTimestamps", "none")
	end
end

function Module:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[format("ChatFrame%d", i)]
		if cf ~= COMBATLOG and self:IsHooked(cf, "AddMessage") then
			self:Unhook(cf, "AddMessage")
		end
	end
	for _, frame in ipairs(self.TempChatFrames) do
		local cf = _G[frame]
		if self:IsHooked(cf, "AddMessage") then
			self:Unhook(cf, "AddMessage")
		end
	end
end

function Module:Decorate(frame)
	if not self:IsHooked(frame, "AddMesage") then
		self:RawHook(frame, "AddMessage", true)
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds a timestamp to each line of text."]
end

function Module:GetOptions()
	if not options then
		options = {
			format = {
				type = "select",
				order = 13,
				name = L["Timestamp format"],
				desc = L["Timestamp format"],
				values = {
					["%I:%M:%S %p"]	= L["HH:MM:SS AM (12-hour)"],
					["%I:%M:S"]		= L["HH:MM (12-hour)"],
					["%X"]			= L["HH:MM:SS (24-hour)"],
					["%I:%M"]		= L["HH:MM (12-hour)"],
					["%H:%M"]		= L["HH:MM (24-hour)"],
					["%M:%S"]		= L["MM:SS"],
				},
				get = function() return db.format end,
				set = function(_, value) db.format = value end,
			},
			customFormat = {
				type = "input",
				order = 14,		
				name = L["Custom format (advanced)"],
				desc = L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."],
				get = function() return db.customFormat end,
				set = function(_, value)
					if #value == 0 then value = nil end
					db.customFormat = value
				end,
			},
			dummy = {
				type = "description",
				order = 15,
				name = "",
			},
			useChannelColor = {
				type = "toggle",
				order = 16,
				name = L["Use channel color"],
				desc = L["Color timestamps the same as the channel they appear in."],
				get = function() return db.colorByChannel end,
				set = function(_, value) db.colorByChannel = value end,
			},
			color = {
				type = "color",
				order = 17,
				name = L["Timestamp color"],
				desc = L["Timestamp color"],
				disabled = function() return db.colorByChannel end,
				get = function() return db.color.r, db.color.g, db.color.b end,
				set = function(_, r, g, b) db.color.r = r; db.color.g = g; db.color.b = b; end,
			},
			copyLinks = {
				type = "toggle",
				order = 18,
				name = L["Copy Links"],
				desc = L["Turns the timestamps into a link.\n\nClick the link to copy the chat line.\nShift+Click the link to send the line to the last chat you used."],
				get = function() return db.copyLinks end,
				set = function(_, value) db.copyLinks = value; StaticPopup_Show("ECT_RLUI"); end,
			},
			frames = {
				type = "multiselect",
				order = 100,
				name = L["Chat Frame Settings"],
				desc = L["Choose which chat frames display timestamps"],
				values = function()
					local frameStr, display = "ChatFrame%d", L["ChatFrame %d"]
					local frames = {}
					for i = 1, 18 do
						local cf = _G[frameStr:format(i)]
						if cf and cf ~= COMBATLOG then
							frames[i] = display:format(i)
						end
					end
					return frames
				end,
				get = function(_, key) return db.frames[key] end,
				set = function(_, key, value) db.frames[key] = value end,
			},
		}
	end
	return options
end