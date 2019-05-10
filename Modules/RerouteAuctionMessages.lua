-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Reroute Auction Messages", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Reroute Auction Messages"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		output = "ChatFrame3",
		won = true,
		sold = true,
		outbid = true,
		expired = true,
		removed = true,
		color = {r = 1.0, g = 1.0, b = 0},
	}
}

local frameString = "ChatFrame%d"
local frameList = L["Chat Frame %d"]

-- auction messages to look for
local AUCTION_WON = ERR_AUCTION_WON_S:format("(.+)")
local AUCTION_SOLD = ERR_AUCTION_SOLD_S:format("(.+)")
local AUCTION_OUTBID = ERR_AUCTION_OUTBID_S:format("(.+)")
local AUCTION_EXPIRED = ERR_AUCTION_EXPIRED_S:format("(.+)")
local AUCTION_REMOVED = ERR_AUCTION_REMOVED_S:format("(.+)")

local function RerouteMessages(self, event, message, ...)
	if not message or not _G[db.output] then return end
	
	if Module.debug then
		_G[db.output]:AddMessage("I'm using this ChatFrame.")
		print(message)
	end
	
	if (message:find(AUCTION_WON) and db.won) or
		(message:find(AUCTION_SOLD) and db.sold) or
		(message:find(AUCTION_OUTBID) and db.outbid) or
		(message:find(AUCTION_EXPIRED) and db.expired) or
		(message:find(AUCTION_REMOVED) and db.removed) then
		_G[db.output]:AddMessage(message, db.color.r, db.color.g, db.color.b)
		return true
	end
	return false
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", RerouteMessages)
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", RerouteMessages)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Allows you to reroute auction house messages to a different chat frame."]
end

function Module:GetOptions()
	if not options then
		options = {
			color = {
				type = "color",
				order = 13,
				name = L["Output Color"],
				desc = L["Output color of the rerouted messages."],
				get = function() return db.color.r, db.color.g, db.color.b end,
				set = function(_, r, g, b) db.color.r = r; db.color.g = g; db.color.b = b; end,
			},
			output = {
				type = "select",
				order = 14,
				name = L["Output Frame"],
				desc = L["Chat frame to route the auction house messages to."],
				get = function() return db.output end,
				set = function(_, value) db.output = value end,
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
			auctionTypes = {
				type = "group",
				order = 99,
				name = L["Auction Message Types"],
				guiInline = true,
				args = {
					expired = {
						type = "toggle",
						order = 1,
						name = L["Auction Expired"],
						get = function() return db.expired end,
						set = function(_, value) db.expired = value end,
					},
					outbid = {
						type = "toggle",
						order = 2,
						name = L["Auction Outbid"],
						get = function() return db.outbid end,
						set = function(_, value) db.outbid = value end,
					},
					removed = {
						type = "toggle",
						order = 3,
						name = L["Auction Removed"],
						get = function() return db.removed end,
						set = function(_, value) db.removed = value end,
					},
					sold = {
						type = "toggle",
						order = 4,
						name = L["Auction Sold"],
						get = function() return db.sold end,
						set = function(_, value) db.sold = value end,
					},
					won = {
						type = "toggle",
						order = 5,
						name = L["Auction Won"],
						get = function() return db.won end,
						set = function(_, value) db.won = value end,
					}
				},
			},
		}
	end
	return options
end