-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
-- Auction Created/Removed additions courtesy of chutwig.
local Module = ElvUI_ChatTweaks:NewModule("Auction Message Filtering")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Auction Message Filtering"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db
local options
local defaults = {
	global = {
		auctionStarted = true,
		auctionRemoved = true,
		auctionSold = true,
		auctionOutbid = true,
		auctionExpired = true,
		auctionRemoved = true,
		auctionWon = true,
		bidAccepted = true,
	}
}

-- regular expressions to use
local AUCTION_WON = format(ERR_AUCTION_WON_S, "(.+)")
local AUCTION_SOLD = format(ERR_AUCTION_SOLD_S, "(.+)")
local AUCTION_OUTBID = format(ERR_AUCTION_OUTBID_S, "(.+)")
local AUCTION_EXPIRED = format(ERR_AUCTION_EXPIRED_S, "(.+)")
local AUCTION_REMOVED = format(ERR_AUCTION_REMOVED_S, "(.+)")

local function FilterAuctionMessages(self, event, message)
	if not message then return end
	
	-- do the filtering
	if message:match(AUCTION_WON) and db.auctionWon then return true end
	if message:match(AUCTION_SOLD) and db.auctionSold then return true end
	if message:match(AUCTION_OUTBID) and db.auctionOutbid then return true end
	if message:match(AUCTION_EXPIRED) and db.auctionExpired then return true end
	if message:match(AUCTION_REMOVED) and db.auctionRemoved then return true end
	if message:match(ERR_AUCTION_BID_PLACED) and db.bidAccepted then return true end
	if message:match(ERR_AUCTION_STARTED) and db.auctionStarted then return true end
	if message:match(ERR_AUCTION_REMOVED) and db.auctionRemoved then return true end
	
	return false
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", FilterAuctionMessages)
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", FilterAuctionMessages)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Filters out Auction House system messages."]
end

function Module:GetOptions()
	if not options then
		options = {
			auctionSold = {
				type = "toggle",
				name = L["Auction Sold"],
				desc = format(L["Filter the Auction Sold message.\n\n|cffffff00%s|r"], ERR_AUCTION_SOLD_S),
				get = function() return db.auctionSold end,
				set = function(_, value) db.auctionSold = value end,
			},
			auctionOutbid = {
				type = "toggle",
				name = L["Auction Outbid"],
				desc = format(L["Filter the Auction Outbid message.\n\n|cffffff00%s|r"], ERR_AUCTION_OUTBID_S),
				get = function() return db.auctionOutbid end,
				set = function(_, value) db.auctionOutbid = value end,
			},
			auctionExpired = {
				type = "toggle",
				name = L["Auction Expired"],
				desc = format(L["Filter the Auction Expired message.\n\n|cffffff00%s|r"], ERR_AUCTION_EXPIRED_S),
				get = function() return db.auctionExpired end,
				set = function(_, value) db.auctionExpired = value end,
			},
			auctionRemoved = {
				type = "toggle",
				name = L["Auction Removed"],
				desc = format(L["Filter the Auction Removed message.\n\n|cffffff00%s|r"], ERR_AUCTION_REMOVED_S),
				get = function() return db.auctionRemoved end,
				set = function(_, value) db.auctionRemoved = value end,
			},
			auctionWon = {
				type = "toggle",
				name = L["Auction Won"],
				desc = format(L["Filter the Auction Won message.\n\n|cffffff00%s|r"], ERR_AUCTION_WON_S),
				get = function() return db.auctionWon end,
				set = function(_, value) db.auctionWon = value end,
			},
			bidAccepted = {
				type = "toggle",
				name = L["Bid Accepted"],
				desc = format(L["Filter the Bid Accepted message.\n\n|cffffff00%s|r"], ERR_AUCTION_BID_PLACED),
				get = function() return db.bidAccepted end,
				set = function(_, value) db.bidAccepted = value end,
			},
			auctionStarted = {
				type = "toggle",
				name = L["Auction Created"],
				desc = format(L["Filter the Auction Created message.\n\n|cffffff00%s|r"], ERR_AUCTION_STARTED),
				get = function() return db.auctionStarted end,
				set = function(_, value) db.auctionStarted = value end,
			},
			auctionRemoved = {
				type = "toggle",
				name = L["Auction Removed"],
				desc = format(L["Filter the Auction Removed message.\n\n|cffffff00%s|r"], ERR_AUCTION_REMOVED),
				get = function() return db.auctionRemoved end,
				set = function(_, value) db.auctionRemoved = value end,
			},
		}
	end
	return options
end