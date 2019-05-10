-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Gold Calculator", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Gold Calculator"]
Module.namespace = string.gsub(Module.name, " ", "")

local insert = table.insert

local goldicon = "\124TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:1:0\124t"
local silvericon = "\124TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:1:0\124t"
local coppericon = "\124TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:1:0\124t"

local db, options
local defaults = {
	global = {
		coins = false,
		size = 12,
	}
}

local function StringToCopper(money)
	local gold, silver, copper = 0, 0, 0
	local original
	if not money:find("g") and not money:find("s") and not money:find("c") then
		return money	-- nothing to do
	end
	
	original = money
	if money:find("g") then
		gold = money:sub(1, money:find("g") - 1)
		gold = tonumber(gold) * 10000	-- gold -> copper
		money = money:sub(money:find("g") + 1)
	end
	
	if money:find("s") then
		silver = money:sub(1, money:find("s") - 1)
		silver = tonumber(silver) * 100	-- silver -> copper
		money = money:sub(money:find("s") + 1)
	end
	
	if money:find("c") then
		copper = money:sub(1, money:find("c") - 1)
		copper = tonumber(copper)
	end
	
	-- return the total
	return gold + silver + copper
end

local function SplitString(needle, haystack)
	local list = {}
	local pos = 1
	while 1 do
		local first, last = haystack:find(needle, pos)
		if first then
			insert(list, haystack:sub(pos, first - 1))
			pos = last + 1
		else
			insert(list, haystack:sub(pos))
			break
		end
	end
	return list
end

local function JoinString(needle, haystack)
	local len = getn(haystack)
	if len == 0 then return "" end
	local str = haystack[1]
	for i = 2, len do
		str = str .. needle .. haystack[i]
	end
	return str
end

local function FormatResult(result)
	local parts = SplitString(" ", result)
	if not parts or #parts == 0 then return result end
	local goldabbrev = db.coins == true and goldicon:format(db.size, db.size) or L["|cffffd700g|r"]
	local silverabbrev = db.coins == true and silvericon:format(db.size, db.size) or L["|cffc7c7cfs|r"]
	local copperabbrev = db.coins == true and coppericon:format(db.size, db.size) or L["|cffeda55fc|r"]
	for i = 1, #parts do
		if parts[i]:find("g") or parts[i]:find("s") or parts[i]:find("c") then
			local gold = parts[i]:match("(%d+)g") or ""
			local silver = parts[i]:match("(%d+)s") or ""
			local copper = parts[i]:match("(%d+)c") or ""
			parts[i] = ""
			if tonumber(gold) ~= nil then
				parts[i] = parts[i] .. gold .. goldabbrev .. " "
			end
			if tonumber(silver) ~= nil then
				parts[i] = parts[i] .. silver .. silverabbrev .. " "
			end
			if tonumber(copper) ~= nil then
				parts[i] = parts[i] .. copper .. copperabbrev .. " "
			end
			parts[i] = parts[i]:sub(1, -1)
			
			-- debugging
			if Module.debug then Module:Print(parts[i]) end
		end
	end
	return JoinString(" ", parts)
end

local function FormatMoney(money, color)
	local gold = floor(math.abs(money) / 10000)
	local silver = mod(floor(math.abs(money) / 100), 100)
	local copper = mod(floor(math.abs(money)), 100)
	
	if color == nil then color = "ffffff" end
	
	local goldabbrev = db.coins == true and goldicon:format(db.size, db.size) or L["|cffffd700g|r"]
	local silverabbrev = db.coins == true and silvericon:format(db.size, db.size) or L["|cffc7c7cfs|r"]
	local copperabbrev = db.coins == true and coppericon:format(db.size, db.size) or L["|cffeda55fc|r"]
	
	if gold ~= 0 then
		return format("|cff%s%s|r" .. goldabbrev .. " |cff%s%s|r" .. silverabbrev.." |cff%s%s|r" .. copperabbrev, color, gold, color, silver, color, copper)
	elseif silver ~= 0 then
		return format("|cff%s%s|r" .. silverabbrev.." |cff%s%s|r" .. copperabbrev, color, silver, color, copper)
	else
		return format("|cff%s%s|r" .. copperabbrev, color, copper)
	end
end

local function PrintError(errorStr)
	Module:Print(("|cffff0000%s|r"):format(errorStr))
end

function Module:OnEnable()
	self:RegisterChatCommand("gcalc", function(args)
		if not args or args == "" then
			self:Print((L["|cffffffffYou have %s.|r"]):format(FormatMoney(GetMoney())))
			return
		end
		
		local i, result, paramCount = 0, 0, 0
		local a, b, symbol, result = nil, nil, nil, nil
		
		for param in args:lower():gmatch("[^%s]+") do
			i = i + 1
			paramCount = paramCount + 1
			
			if param ~= "mymoney" then
				param = StringToCopper(param)
			else
				param = GetMoney()
			end
			
			if i == 1 then
				a = param
			elseif i == 2 then
				symbol = param
			elseif i == 3 then
				b = param
				
				-- some error checking before we proceed
				if symbol ~= "=" and not tonumber(a) then
					PrintError(args .. ": '" .. a .. "'" .. L[" isn't a number."])
					return
				elseif symbol ~= "=" and not tonumber(b) then
					PrintError(args .. ": '" .. b .. "'" .. L[" isn't a number."])
					return
				end
				
				if symbol == "+" then result = a + b
				elseif symbol == "-" then result = a - b
				elseif symbol == "*" then result = a * b
				elseif symbol == "/" then result = a / b
				else
					PrintError((L["Unrecognized Symbol: |cffffff00%s|r"]):format(symbol))
					if symbol == "x" then
						PrintError(L["Perhaps you meant '*' (multiplication)?"])
					end
					return
				end
				
				i = 1; symbol = nil; a = result; b = nil
			end
		end
		
		if symbol and not b then
			PrintError((L["Unbalanced parameter count. Trailing Symbol: |cffffff00%s|r"]):format(symbol))
		end
		
		if paramCount >= 3 then
			self:Print(FormatResult(args) .. " = " .. FormatMoney(result))
		end
	end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("gcalc")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	return L["A simple calculator used to perform basic operations on gold values.  Providing no parameters will show you how much gold you have.\n\nYou can include your current gold amount by using the |cff00ff00mymoney|r keyword.  For example |cff00ff00mymoney * 2|r.\n\n|cffff0000Money amounts can only be added or subtracted, multiplication or division can only be performed with money and a number.  For example:  4g * 4 is okay, where 4g * 4g is invalid."]
end

function Module:GetOptions()
	if not options then
		options = {
			coins = {
				type = "toggle",
				order = 13,
				name = L["Use Coins"],
				desc = L["Use coins in the answers instead of abbreviations."],
				get = function() return db.coins end,
				set = function(_, value) db.coins = value end,
			},
			size = {
				type = "range",
				order = 14,
				name = L["Coin Size"],
				desc = L["Size of the coin icons.  Generally you want to use your font size or smaller."],
				disabled = function() return not db.coins end,
				get = function() return db.size end,
				set = function(_, value) db.size = value end,
				min = 1, max = 32, step = 1, bigStep = 1,
			},
		}
	end
	return options
end