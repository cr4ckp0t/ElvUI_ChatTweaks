-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Chat Fonts", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
local LSM = LibStub("LibSharedMedia-3.0")
Module.name = L["Chat Fonts"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db
local options
local defaults = {
	global = {
		fontFace = "ElvUI Font",
		fontOutline = "",
		fontSize = 15,
		oldFonts = {},
	}
}

function Module:RestoreChatFonts()
	for i = 1, NUM_CHAT_WINDOWS do
		local frame, oldFont = _G[format("ChatFrame%d", i)], db.oldFonts[format("FRAME_%d", i)]
		frame:SetFont(oldFont["face"], oldFont["size"], oldFont["outline"])
	end
	for i = 1, #self.TempChatFrames do
		local name = self.TempChatFrames[i]
		local frame, oldFont = _G[name], db.oldFonts[name]
		frame:SetFont(oldFont["face"], oldFont["size"], oldFont["outline"])
	end
	db.oldFonts = {}
end

function Module:SetChatFont(face, size, outline)
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%d", i)]
		frame:SetFont(LSM:Fetch("font", face), size, outline)
	end
	for index, frame in ipairs(self.TempChatFrames) do
		local cf = _G[frame]
		cf:SetFont(LSM:Fetch("font", face), size, outline)
	end
end

function Module:Decorate(frame)
	if not db.oldFonts[frame:GetName()] then
		local face, size, outline = frame:GetFont()
		db.oldFonts[frame:GetName()] = {
			face = face,
			size = size,
			outline = outline
		}
	end
end

function Module:OnEnable()
	-- save the current font info
	for i = 1, NUM_CHAT_WINDOWS do
		local s, frame = format("FRAME_%d", i), _G[format("ChatFrame%d", i)]
		local face, size, outline = frame:GetFont()
		db.oldFonts[s] = {
			face = face,
			size = size,
			outline = outline
		}
	end
	for i = 1, #self.TempChatFrames do
		local name = self.TempChatFrames[i]
		local frame = _G[name]
		local face, size, outline = frame:GetFont()
		db.oldfonts[name] = {
			face = face,
			size = size,
			outline = outline,
		}
	end
	self:SetChatFont(db.fontFace, db.fontSize, db.fontOutline)
end

function Module:OnDisable()
	self:RestoreChatFonts()
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Allows you to change the default font settings for the chat frames.\n\n|cffff0000Using another addon to do this will break this functionality.|r"]
end

function Module:GetOptions()
	if not options then
		options = {
			fontFace = {
				type = "select",
				order = 13,
				width = "full",
				dialogControl = "LSM30_Font",
				name = L["Font Face"],
				desc = L["Default font face for the chat frames."],
				values = AceGUIWidgetLSMlists.font,
				get = function() return db.fontFace end,
				set = function(_, value)
					db.fontFace = value
					Module:SetChatFont(db.fontFace, db.fontSize, db.fontOutline)
				end
			},
			fontSize = {
				type = "range",
				order = 14,
				width = "full",
				name = L["Font Size"],
				desc = L["Default font size for the chat frames."],
				get = function() return db.fontSize end,
				set = function(_, value)
					db.fontSize = value
					Module:SetChatFont(db.fontFace, db.fontSize, db.fontOutline)
				end,
				min = 9, max = 32, step = 1,
			},
			fontOutline = {
				type = "select",
				order = 15,
				width = "full",
				name = L["Outline"],
				desc = L["Default font outline for the chat frames."],
				values = {[""] = L["None"], ["OUTLINE"] = L["Outline"], ["THICKOUTLINE"] = L["Thick Outline"]},
				get = function() return db.fontOutline end,
				set = function(_, value)
					db.fontOutline = value
					Module:SetChatFont(db.fontFace, db.fontSize, db.fontOutline)
				end
			},
			fontReset = {
				type = "execute",
				name = L["Reset Font Data"],
				desc = L["Resets all chat frames to their original font settings."],
				confirm = function() return L["Are you sure you want to reset the chat fonts to defaults?"] end,
				func = function()
					Module:RestoreChatFonts()
					db.fontFace = db.oldFonts["FRAME_1"]["face"]
					db.fontSize = db.oldFonts["FRAME_1"]["size"]
					db.fontOutline = db.oldFonts["FRAME_1"]["outline"]
				end
			},
		}
	end
	return options
end
