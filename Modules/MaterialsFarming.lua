-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Materials Farming", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Materials Farming"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		autoRemove = true,
		items = {},
		quantities = {},
		color = {r = 0.58, g = 0.51, b = 0.79},	-- warlock purple, maybe im biased...
		highlight = {r = 0, g = 1, b = 0.59},	-- monk class color
		frame = "ChatFrame3",
	}
}

local pattern = "\124c%x+\124Hitem:.-\124h\124r"
local frameString = "ChatFrame%d"
local frameList = L["Chat Frame %d"]

-- chat strings sent to the chat
local chatString = L["You have |cff%s%d|r of %s."]
local chatStringQuantity = L["You have |cff%s%d|r of %s, you need |cff%s%d|r more. |cff%s(%d/%d)|r"]
local chatStringFinished = L["You have met your quota of %s%s. |cff%s(%d/%d)|r"]

local function inArray(needle, haystack)
	for i = 1, #haystack do
		if Module.debug then
			print(haystack[i].id, needle, tonumber(haystack[i].id) == tonumber(needle))
		end
		
		if tonumber(haystack[i].id) == tonumber(needle) then
			return i
		end
	end
	return false
end

function Module:CHAT_MSG_LOOT(event, message, ...)
	local link = message:match(pattern)
	if not message or not link then return end

	local _, _, _, _, id, _, _, _, _, _, _, _, _, _ = link:find("|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
	local loc = inArray(id, db.items)
	
	if self.debug then
		print(loc, id, link)
	end
	
	if loc ~= false then
		-- figure out how many were looted
		local quantity = message:match("x(%d+)")
		local highlight = ("%02x%02x%02x"):format(db.highlight.r * 255, db.highlight.g * 255, db.highlight.b * 255)
		
		if self.debug then
			print(quantity)
		end
		
		-- tweak quantity if necessary
		quantity = quantity ~= nil and tonumber(quantity) or 1
		
		-- update the count, we have to add one because it hasnt registered in your inventory yet
		db.items[loc].count = GetItemCount(id, false, false) + quantity or 1
		
		-- now print the message
		if tonumber(db.quantities[loc]) > 0 then
			-- see if the quota was met
			if tonumber(db.quantities[loc]) <= db.items[loc].count then
				-- quota met
				local autoString = db.autoRemove == true and L[", removing from list"] or ""
				_G[db.frame]:AddMessage(chatStringFinished:format(db.items[loc].link, autoString, highlight, db.items[loc].count, db.quantities[loc]), db.color.r, db.color.g, db.color.b)
				
				-- remove the item from the list
				if db.autoRemove then
					db.items[loc] = nil
					db.quantities[loc] = nil
					self:RebuildTables()
				end
			else
				_G[db.frame]:AddMessage(chatStringQuantity:format(highlight, db.items[loc].count, db.items[loc].link, highlight, db.quantities[loc] - db.items[loc].count, highlight, db.items[loc].count, db.quantities[loc]), db.color.r, db.color.g, db.color.b)
			end
		else
			_G[db.frame]:AddMessage(chatString:format(highlight, db.items[loc].count, db.items[loc].link), db.color.r, db.color.g, db.color.b)
		end
	elseif not loc and self.debug then
		self:Print((L["Not tracking %s."]):format(link))
	end
end

function Module:OnEnable()
	self:RegisterEvent("CHAT_MSG_LOOT")
end

function Module:OnDisable()
	self:RegisterEvent("CHAT_MSG_LOOT")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["This module will send a chat message every time you loot an item on your list with how many you have, and if applicable it will tell you how many more you need based on your set quantity.  This is useful if you need X amount of Y to be able to cook Z."]
end

function Module:GetOptions()
	if not options then
		options = {
			autoRemove = {
				type = "toggle",
				order = 13,
				name = L["Automatically Remove Item When Finished"],
				desc = L["Do you want to automatically remove an item when you meet your quota?"],
				width = "full",
				get = function() return db.autoRemove end,
				set = function(_, value) db.autoRemove = value end,
			},
			items = {
				type = "input",
				order = 14,
				multiline = true,
				name = L["Materials to Track"],
				desc = L["The name or ID of the material you'd like to track.\n\n|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r"],
				get = function() return Module:TableToString("items") end,
				set = function(_, value) Module:PopulateTable("items", value) end,
			},
			quantities = {
				type = "input",
				order = 15,
				multiline = true,
				name = L["Material Quantities"],
				desc = L["The amount of each material you'd like to farm.  If you want an unlimited amount simply put a 0.  You must add a quantity for every entry, and it must correspond to the same line in the other box."],
				get = function() return Module:TableToString("quantities") end,
				set = function(_, value) Module:PopulateTable("quantities", value) end,
			},
			dummy = {
				type = "description",
				order = 16,
				width = "normal",
				name = "",
			},
			resetSettings = {
				type = "execute",
				order = 17,
				name = L["Reset Materials"],
				desc = L["Click to reset the materials you're tracking."],
				func = function()
					db.items = {}
					db.quantities = {}
				end,
			},
			chatSettings = {
				type = "group",
				order = 100,
				guiInline = true,
				name = L["Message Settings"],
				args = {
					color = {
						type = "color",
						order = 1,
						name = L["Color"],
						desc = L["Message color."],
						get = function() return db.color.r, db.color.g, db.color.b end,
						set = function(_, r, g, b) db.color.r = r; db.color.g = g; db.color.b = b; end,
					},
					highlight = {
						type = "color",
						order = 2,
						name = L["Highlight Color"],
						desc = L["Message highlight color."],
						get = function() return db.highlight.r, db.highlight.g, db.highlight.b end,
						set = function(_, r, g, b) db.highlight.r = r; db.highlight.g = g; db.highlight.b = b; end,
					},
					frame = {
						type = "select",
						order = 3,
						name = L["Chat Frame"],
						desc = L["Chat frame to send the messages to."],
						get = function() return db.frame end,
						set = function(_, value) db.frame = value end,
						values = function()
							local frames = {}
							for i = 1, 18 do
								if _G[frameString:format(i)] then
									frames[frameString:format(i)] = frameList:format(i)
								end
							end
							return frames
						end,
					},
				},
			},
		}
	end
	return options
end

function Module:RebuildTables()
	local dummy = {}
	-- remove any nil entries
	for i = 1, #db.items do
		if db.items[i] then
			dummy[#dummy + 1] = db.items[i]
		end
	end
	db.items = dummy
	dummy = {}
	for i = 1, #db.quantities do
		if db.quantities[i] then
			dummy[#dummy + 1] = db.quantities[i]
		end
	end
end

function Module:PopulateTable(array, value)
	db[array] = {}
	local dummy = {strsplit("\n", value:trim())}
	for i = 1, #dummy do
		if dummy[i] then
			if array == "quantities" then
				db[array][i] = tonumber(dummy[i])
			else
				local name, link, _, _, _, _, _, _, _, _, _ = GetItemInfo(dummy[i])
				
				-- warn them the item doesnt exist
				if not name or not link then
					self:Print((L["|cffff0000Item|r |cffffffff\"%s\"|r |cffff0000does not exist.|r"]):format(dummy[i]))
					return
				end
				
				local _, _, _, _, id, _, _, _, _, _, _, _, _, _ = link:find("|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
			
				-- add them to the db array
				db[array][i] = {
					id = tonumber(id) or -1,
					name = name or dummy[i],
					link = link or nil,
					count = GetItemCount(id, false, false) or 0,
				}
			end
		end
	end
end

function Module:TableToString(array)
	local out = ""
	if #db[array] == 0 then return out end
	for i = 1, #db[array] do
		if array == "items" then
			out = out .. db[array][i].name .. "\n"
		else
			out = out .. db[array][i] .. "\n"
		end
	end
	return out
end