-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Improved Auction Messages", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Improved Auction Messages"]
Module.namespace = string.gsub(Module.name, " ", "")

local format = string.format

local db, options
local defaults 	= {
	global = {
		improvedSold = true,
		improvedOutbid = true,
		improvedExpired = true,
		improvedRemoved = true,
		improvedWon = true,
	}
}

-- regular expressions to use
local AUCTION_WON = ERR_AUCTION_WON_S:format("(.+)")
local AUCTION_SOLD = ERR_AUCTION_SOLD_S:format("(.+)")
local AUCTION_OUTBID = ERR_AUCTION_OUTBID_S:format("(.+)")
local AUCTION_EXPIRED = ERR_AUCTION_EXPIRED_S:format("(.+)")
local AUCTION_REMOVED = ERR_AUCTION_REMOVED_S:format("(.+)")

local function ImproveAuctionMessages(self, event, message, ...)
	if not message then return end
	local item
	
	if message:find(AUCTION_WON) and db.improvedWon then
		item = message:match(AUCTION_WON)
		if item ~= nil then
			local _, link = GetItemInfo(item)
			if link ~= nil then
				message = ERR_AUCTION_WON_S:format(link)
			end
		end
	elseif message:find(AUCTION_SOLD) and db.improvedSold then
		item = message:match(AUCTION_SOLD)
		if item ~= nil then
			local _, link = GetItemInfo(item)
			if link ~= nil then
				message = ERR_AUCTION_SOLD_S:format(link)
			end
		end
	elseif message:find(AUCTION_OUTBID) and db.improvedOutbid then
		item = message:match(AUCTION_OUTBID)
		if item ~= nil then
			local _, link = GetItemInfo(item)
			if link ~= nil then
				message = ERR_AUCTION_OUTBID_S:format(link)
			end
		end
	elseif message:find(AUCTION_EXPIRED) and db.improvedExpired then
		item = message:match(AUCTION_EXPIRED)
		if item ~= nil then
			local _, link = GetItemInfo(item)
			if link ~= nil then
				message = ERR_AUCTION_EXPIRED_S:format(link)
			end
		end
	elseif message:find(AUCTION_REMOVED) and db.improvedRemoved then
		item = message:match(AUCTION_REMOVED)
		if item ~= nil then
			local _, link = GetItemInfo(item)
			if link ~= nil then
				message = ERR_AUCTION_REMOVED_S:format(link)
			end
		end
	end
	
	return false, message, ...
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ImproveAuctionMessages)
	
	if ElvUI_ChatTweaks.modules["Auction Message Filtering"] == true then
		ElvUI_ChatTweaks.modules["Auction Message Filtering"] = false
	end
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", ImprovedAuctionMessages)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["Adds item links to Auction House messages.  Enabling this module will automatically disable the Auction Message Filter module.\n\n|cffff0000If you do not have the item in your bags at the time of the system message firing then this will not be able to get the item link.  This is a limitation of the|r |cffffff00GetItemInfo()|r |cffff0000API function.  If this occurs, then the module will simple pass through the default message.|r"]
end

function Module:GetOptions()
	if not options then
		options = {
			improvedSold = {
				type = "toggle",
				name = L["Auction Sold"],
				desc = format(L["Improve the Auction Sold message.\n\n|cffffff00%s|r"], ERR_AUCTION_SOLD_S),
				get = function() return db.improvedSold end,
				set = function(_, value) db.improvedSold = value end,
			},
			improvedOutbid = {
				type = "toggle",
				name = L["Auction Outbid"],
				desc = format(L["Improve the Auction Outbid message.\n\n|cffffff00%s|r"], ERR_AUCTION_OUTBID_S),
				get = function() return db.improvedOutbid end,
				set = function(_, value) db.improvedOutbit = value end,
			},
			improvedExpired = {
				type = "toggle",
				name = L["Auction Expired"],
				desc = format(L["Improve the Auction Expired message.\n\n|cffffff00%s|r"], ERR_AUCTION_EXPIRED_S),
				get = function() return db.improvedExpired end,
				set = function(_, value) db.improvedExpired = value end,
			},
			improvedRemoved = {
				type = "toggle",
				name = L["Auction Removed"],
				desc = format(L["Improve the Auction Removed message.\n\n|cffffff00%s|r"], ERR_AUCTION_REMOVED_S),
				get = function() return db.improvedRemoved end,
				set = function(_, value) db.improvedRemoved = value end,
			},
			improvedWon = {
				type = "toggle",
				name = L["Auction Won"],
				desc = format(L["Improve the Auction Won message.\n\n|cffffff00%s|r"], ERR_AUCTION_WON_S),
				get = function() return db.improvedWon end,
				set = function(_, value) db.improvedWon = value end,
			},	
		}
	end
	return options
end