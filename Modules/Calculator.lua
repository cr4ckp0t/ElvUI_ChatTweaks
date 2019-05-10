-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Calculator", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Calculator"]
Module.namespace = string.gsub(Module.name, " ", "")

-- this addon wont run with SimpleCalc
if IsAddOnLoaded("SimpleCalc") then return end

local gsub 		= string.gsub

local db
local defaults = {
	global = {
		vars = {},
	}
}

local function PrintError(errorStr)
	Module:Print(("|cffff0000%s|r"):format(errorStr))
end

function Module:OnEnable()
	RequestPVPRewards()
	self:RegisterChatCommand("calc", function(args)
		if not args or args == "" then
			PrintError(L["You must provide a calculation or set a variable."])
			return
		end
		
		local i, result, paramCount = 0, 0, 0
		local a, b, original, symbol, calcVar = nil, nil, nil, nil, nil
		
		-- for our keywords
		local GetConquest = function() return select(2, GetCurrencyInfo(390)) or 0 end
		local GetHonor = function() return select(2, GetCurrencyInfo(392)) or 0 end
		local GetJustice = function() return select(2, GetCurrencyInfo(395)) or 0 end
		local GetValor = function() return select(2, GetCurrencyInfo(396)) or 0 end
		
		-- point caps
		local GetJusticeCap = function() return (select(5, GetCurrencyInfo(395)) / 100) - select(4, GetCurrencyInfo(395)) or 0 end
		local GetValorCap = function() return (select(5, GetCurrencyInfo(396)) / 100) - select(4, GetCurrencyInfo(396)) or 0 end
		local GetConquestCap = function() return select(2, GetPVPRewards()) - select(1, GetPVPRewards()) or 0 end
		RequestPVPRewards()

		for param in args:lower():gmatch("[^%s]+") do
			i = i + 1
			paramCount = paramCount + 1
			
			-- see if they used a keyword
			if i == 1 or i == 3 then
				if i == 1 then original = param end
				
				-- parameter is not a number
				if param:match("[^%d\.-]") then
					if param == "honour" or param == "honor" then param = GetHonor()
					elseif param == "conquest" or param == "cp" then param = GetConquest()
					elseif param == "justice" or param == "jp" then param = GetJustice()
					elseif param == "valor" or param == "vp" then param = GetValor()
					elseif param == "vpcap" then param = GetValorCap()
					elseif param == "jpcap" then param = GetJusticeCap()
					elseif param == "cpcap" then param = GetConquestCap()
					elseif param == "achieve" or param == "ap" then param = GetTotalAchievementPoints()
					elseif param == "health" then param = UnitHealthMax("player")
					elseif param == "power" or param == "mana" then param = UnitPowerMax("player")
					elseif param == "copper" then param = GetMoney()
					elseif param == "silver" then param = GetMoney() / 100
					elseif param == "gold" then param = GetMoney() / 1000
					elseif db.vars[param] then param = db.vars[param]
					end
					
					-- debugging
					if Module.debug then Module:Print((L["Parameter: |cffffff00%s|r"]):format(param)) end
				end
			end
			
			if i == 1 then
				a = param
			
			elseif i == 2 then
				symbol = param
				-- debugging
				if Module.debug then Module:Print((L["Symbol: |cffffff00%s|r"]):format(symbol)) end
				
			elseif i == 3 then
				b = param
				
				-- do some error checking
				if symbol ~= "=" and not tonumber(a) then
					PrintError(args .. ": '" .. a .. "'" .. L[" isn't a recognized variable or number."])
					return
				elseif symbol ~= "=" and not tonumber(b) then
					PrintError(args .. ": '" .. b .. "'" .. L[" isn't a recognized variable or number."])
					return
				end
				
				-- perform the operation
				if symbol == "+" then result = a + b
				elseif symbol == "-" then result = a - b
				elseif symbol == "*" then result = a * b
				elseif symbol == "/" then result = a / b
				elseif symbol == "^" then result = a ^ b
				elseif symbol == "=" and paramCount == 3 then
					if tonumber(b) == nil then
						PrintError((L["Can't set value '%s', doesn't look like a number."]):format(b))
						return
					end
					calcVar = original
					result = b
				elseif symbol == "=" then
					PrintError(L["When setting a variable the variable name must be the first parameter."])
				else
					PrintError((L["Unrecognized Symbol: |cffffff00%s|r"]):format(symbol))
					-- in case they tried x instead of *
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
			if not calcVar then
				self:Print(args .. " = " .. result)
			else
				if paramCount > 3 then
					args = args:sub(args:find("= ") + 2)
					self:Print(args .. " = " .. result)
				end
				
				-- handle variables
				if result ~= 0 then
					db.vars[calcVar] = result
					self:Print((L["Variable |cffffff00%s|r set to |cff00ff00%s|r."]):format(calcVar, result))
				else
					db.vars[calcVar] = nil
					self:Print((L["Unset variable |cffffff00%s|r."]):format(calcVar))
				end
				calcVar = nil
			end
		elseif db.vars[calcVar] then
			self:Print((L["Variable |cffffff00%s|r is set to |cff00ff00%s|r."]):format(args, db.vars[calcVar]))
		end
	end)
end

function Module:OnDisable()
	self:UnregisterChatCommand("calc")
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:Info()
	local varString = L["|cff00ff00%s|r"]
	local info = L["A simple command-line calculator.  Certain keywords, listed below, can be used and their in game value will be substituted.  You can also assign variables which are saved for later use.\n\n|cffffff00Keywords:|r\n"]
	info = info .. "    " .. (L["%s or %s"]):format(varString:format(L["honor"]), varString:format(L["honour"])) .. L["  Honor Points\n"]
	info = info .. "    " .. (L["%s or %s"]):format(varString:format(L["conquest"]), varString:format(L["cp"])) .. L["  Conquest Points\n"]
	info = info .. "    " .. (L["%s or %s"]):format(varString:format(L["justice"]), varString:format(L["jp"])) .. L["  Justice Points\n"]
	info = info .. "    " .. (L["%s or %s"]):format(varString:format(L["valor"]), varString:format(L["vp"])) .. L["  Valor Points\n"]
	info = info .. "    " .. (L["%s  Valor Cap\n"]):format(varString:format(L["vpcap"]))
	info = info .. "    " .. (L["%s  Justice Cap\n"]):format(varString:format(L["jpcap"]))
	info = info .. "    " .. (L["%s  Conquest Cap\n"]):format(varString:format(L["cpcap"]))
	info = info .. "    " .. (L["%s or %s"]):format(varString:format(L["achieve"]), varString:format(L["ap"])) .. L["  Achievement Points\n"]
	info = info .. "    " .. (L["%s, %s, %s  Player's Stats\n"]):format(varString:format(L["health"]), varString:format(L["mana"]), varString:format(L["power"]))
	info = info .. "    " .. (L["%s, %s, %s  Player's Money\n"]):format(varString:format(L["gold"]), varString:format(L["silver"]), varString:format(L["copper"]))
	return info
end