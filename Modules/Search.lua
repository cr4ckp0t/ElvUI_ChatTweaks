-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Search", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Search"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		scrape = 30,
		highlight = true,
		color = {r = 0, g = 1.0, b = 0.59},
	}
}

local foundLines, scrapeLines = {}, {}

local function AddLines(lines, ...)
	for i = select("#", ...), 1, -1 do
		local x = select(i, ...)
		if x:GetObjectType() == "FontString" and not x:GetName() then
			table.insert(lines, x:GetText())
		end
	end
end

local function ScrapeFrame(frame)
	table.wipe(scrapeLines)
	AddLines(scrapeLines, frame:GetRegions())
end

function Module:Error(msg)
	self:Print(("|cffff0000%s|r"):format(msg))
end

function Module:Find(msg, all, frame)
	local color = ("%02x%02x%02x"):format(db.color.r * 255, db.color.g * 255, db.color.b * 255)
	local colorString = "|cff%s%s|r"
	-- first, do some error checking
	if not frame or frame == nil then
		frame = SELECTED_CHAT_FRAME
	end
	if not msg then return end
	if #msg <= 2 then
		frame:ScrollToBottom()
		self:Error(L["Search term is too short."])
		return
	end
	if frame:GetNumMessages() == 0 then
		self:Error(L["Not Found"])
		return
	end
	
	local startTime = time()
	local runTime = 0
	
	if not all and self.lastSearch == msg then
		frame:PageUp()
	end
	
	if all then
		frame:ScrollToBottom()
	end
	
	self.lastSearch = msg
	
	-- do the actual search
	repeat
		ScrapeFrame(frame)
		for _, value in ipairs(scrapeLines) do
			if value:lower():find(msg:lower()) then
				if all then
					table.insert(foundLines, db.highlight and value:gsub(msg, colorString:format(color, msg)) or value)
				else
					self:Print(L["Search Results:"])
					frame:AddMessage(db.highlight and value:gsub(msg, colorString:format(color, msg)) or value)
					return
				end
			end
		end
		
		frame:PageUp()
		runTime = time() - startTime
		if runTime >= db.scrape then
			self:Print(L["Frame scraping timeout exceeded, results will be incomplete."])
			break
		end
	until frame:AtTop() or runTime >= db.scrape
	
	self.lastSearch = nil
	frame:ScrollToBottom()
	
	if all and #foundLines > 0 then
		self:Print((L["Search Results |cff9382c9(%d Found)|r:"]):format(#foundLines))
		
		for _, value in ipairs(foundLines) do
			frame:AddMessage(value)
		end
	else
		self:Error(L["Not Found"])
	end
	
	table.wipe(foundLines)
end

function Module:OnEnable()
	self:RegisterChatCommand("find", function(msg) self:Find(msg, false) end)
	self:RegisterChatCommand("findall", function(msg) self:Find(msg, true) end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("find")
	self:UnregisterChatCommand("findall")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debugging = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			scrape = {
				type = "range",
				order = 13,
				name = L["Scrape Time"],
				desc = L["Time, in seconds, you want the search to continue before it ends."],
				get = function() return db.scrape end,
				set = function(_, value) db.scrape = value end,
				min = 5, max = 120, step = 5,
			},
			highlight = {
				type = "toggle",
				order = 14,
				name = L["Highlight Term"],
				desc = L["Highlight the search term in the results."],
				get = function() return db.highlight end,
				set = function(_, value) db.highlight = value end,
			},
			color = {
				type = "color",
				order = 15,
				name = L["Highlight Color"],
				desc = L["The color to highlight the search term."],
				get = function() return db.color.r, db.color.g, db.color.b end,
				set = function(_, r, g, b) db.color.r = r; db.color.g = g; db.color.b = b; end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Adds the |cff00ff96/find|r and |cff00ff96/findall|r commands to search the chat history.\n\nUsage:\n    |cff00ff96/find <text>|r\n    |cff00ff96/findall <text>|r"]
end