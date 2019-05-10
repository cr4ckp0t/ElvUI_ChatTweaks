-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
-- heavily influenced by prat's substitutions module
local Module = ElvUI_ChatTweaks:NewModule("Substitutions", "AceConsole-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Substitutions"]
Module.namespace = string.gsub(Module.name, " ", "")

local db, options
local defaults = {
	global = {
		highlight = false,
		color = {r = 0, g = 1, b = 0.59},
		frames = {
			[1] = true,
			[3] = true,
			[4] = true,
			[5] = true,
			[6] = true,
			[7] = true,
		},
	}
}

function Module:OnEnterPressed(object)
	local text = object:GetText()
	for index, value in pairs(self.patterns) do
		if value.func then
			text = text:gsub(index, value.func)
		end
	end
	object:SetText(text)
	self.hooks[object].OnEnterPressed(object)
end

function Module:AddMessage(frame, text, ...)
	local id = frame:GetID()
	local color = ("%02x%02x%02x"):format(db.color.r * 255, db.color.g * 255, db.color.b * 255)
	if id and db.frames[id] then
		if not text then
			return self.hooks[frame].AddMessage(frame, text, ...)
		end
		for index, value in pairs(self.patterns) do
			if value.func then
				if db.highlight then
					local result = value.func() or ""
					text = text:gsub(index, ("|cff%s%s|r"):format(color, value.func() or ""))
				else
					text = text:gsub(index, value.func)
				end
			end
		end
	end
	return self.hooks[frame].AddMessage(frame, text, ...)
end

function Module:Decorate(frame)
	if not self:IsHooked(frame, "AddMessage") then
		self:RawHook(frame, "AddMessage", true)
	end
end

function Module:OnEnable()
	-- hook the chat frame's addmessage method
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[("ChatFrame%d"):format(i)]
		if cf and cf ~= COMBATLOG then
			self:RawHook(cf, "AddMessage", true)
		end
	end
	for _, frame in ipairs(self.TempChatFrames) do
		self:RawHook(_G[frame], "AddMessage", true)
	end
end

function Module:OnDisable()
	-- unhook the method
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G[("ChatFrame%d"):format(i)]
		if cf and cf ~= COMBATLOG and self:IsHooked(cf, "AddMessage") then
			self:Unhook(cf, "AddMessage")
		end
	end
	for _, frame in ipairs(self.TempChatFrames) do
		if self:IsHooked(_G[frame], "AddMessage") then
			self:Unhook(_G[frame], "AddMessage")
		end
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace("Substitutions", defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetKeywords()
	local str = ""
	local keyword = "%s %s(%s)|r, "
	for index, value in pairs(self.patterns) do
		str = str .. keyword:format(ElvUI_ChatTweaks.hexColor, value.name, index:gsub("%%%%", "%%"))
	end
	return str:sub(1, #str - 2)
end

function Module:Info()
	return L["Provides basic chat subtitutions."]
end

function Module:BuildPatterns(patterns)
	local out = {}
	for key, value in pairs(patterns) do
		out[#out + 1] = {
			name = value.name,
			pat = key:gsub("%%%%", "%%"),
		}
	end
	sort(out, function(a, b) return a.name < b.name end)
	return out
end

function Module:GetColumn(index)
	local out = ""
	local space = index == 1 and "" or "  "
	local patterns = self:BuildPatterns(self.patterns)
	local subString = "%s %s(%s)|r"
	local each = math.ceil(#patterns / 3)
	local start, finish
	
	if index == 1 then
		start = 1
		finish = each
	elseif index == 2 then
		start = each + 1
		finish = each * 2
	else
		start = (each * 2) + 1
		finish = #patterns
	end
	
	for i = start, finish do
		out = out .. space .. subString:format(ElvUI_ChatTweaks.hexColor, patterns[i].name, patterns[i].pat)
		if i ~= finish then
			out = out .. "\n"
		end
	end
	return out
end

function Module:GetOptions()
	if not options then
		options = {
			highlight = {
				type = "toggle",
				order = 13,
				name = L["Highlight Substitutions"],
				desc = L["Highlight the substitutions that are made by changing their color."],
				get = function() return db.highlight end,
				set = function(_, value) db.highlight = value end,
			},
			color = {
				type = "color",
				order = 14,
				name = L["Highlight Color"],
				desc = L["The color to use when highlighting a substitution."],
				disabled = function() return not db.highlight end,
				get = function() return db.color.r, db.color.g, db.color.b end,
				set = function(_, r, g, b) db.color.r = r; db.color.g = g; db.color.b = b; end,
			},
			frames = {
				type = "multiselect",
				order = 15,
				name = L["Chat Frames To Watch"],
				desc = L["Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number."],
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
			keywords = {
				type = "group",
				order = 100,
				name = L["Keywords"],
				guiInline = true,
				args = {
					about = {
						type = "description",
						order = 1,
						width = "full",
						name = L["Below are the keywords that the module will look for to substitute with the values described below."],
					},
					col1 = {
						type = "description",
						order = 2,
						width = "normal",
						name = Module:GetColumn(1),
					},
					col2 = {
						type = "description",
						order = 3,
						width = "normal",
						name = Module:GetColumn(2),
					},
					col3 = {
						type = "description",
						order = 4,
						width = "normal",
						name = Module:GetColumn(3),
					},
				}
			},
		}
	end
	return options
end

Module.patterns = {
	-- player information
	["%%pn%%"] = {
		name = L["Player's Name"],
		func = function() return UnitName("player") or "" end,
	},
	["%%pc%%"] = {
		name = L["Player's Class"],
		func = function()
			local class, _ = UnitClass("player")
			return class
		end,
	},
	["%%pg%%"] = {
		name = L["Player's Gender"],
		func = function() return UnitSex("player") == 2 and L["Male"] or L["Female"] end,
	},
	["%%pl%%"] = {
		name = L["Players Level"],
		func = function() return UnitLevel("player") end,
	},
	["%%pil%%"] = {
		name = L["Player's Average iLvl"],
		func = function() return math.floor(GetAverageItemLevel()) end,
	},
	
	-- player's health
	["%%ph%%"] = {
		name = L["Player's Health"],
		func = function() return UnitHealth("player") end,
	},
	["%%phm%%"] = {
		name = L["Player's Max Health"],
		func = function() return UnitHealthMax("player") end,
	},
	["%%php%%"] = {
		name = L["Player's Health Percent"],
		func = function() return math.floor(UnitHealth("player") / UnitHealthMax("player") * 100) end,
	},
	["%%phd%%"] = {
		name = L["Player's Health Deficit"],
		func = function() return UnitHealthMax("player") - UnitHealth("player") end,
	},
	
	-- players mana
	["%%pm%%"] = {
		name = L["Player's Mana"],
		func = function() return UnitMana("player") end,
	},
	["%%pmm%%"] = {
		name = L["Player's Max Mana"],
		func = function() return UnitManaMax("player") end,
	},
	["%%pmp%%"] = {
		name = L["Player's Mana Percent"],
		func = function() return math.floor(UnitMana("player") / UnitManaMax("player") * 100) end,
	},
	["%%pmd%%"] = {
		name = L["Player's Mana Deficit"],
		func = function() return UnitManaMax("player") - UnitMana("player") end,
	},
	
	-- location information
	["%%zon%%"] = {
		name = L["Player's Zone"],
		func = function() return GetRealZoneText() end,
	},
	["%%pos%%"] = {
		name = L["Player's Location"],
		func = function()
			local x, y = GetPlayerMapPosition("player")
			return ("%d, %d"):format(math.floor((x * 100) + 0.5), math.floor((y * 100) + 0.5))
		end,
	},
	["%%posx%%"] = {
		name = L["Player's X-Coordinate"],
		func = function()
			local x, _ = GetPlayerMapPosition("player")
			return math.floor((x * 100) + 0.5)
		end,
	},
	["%%posy%%"] = {
		name = L["Player's Y-Coordinate"],
		func = function()
			local _, y = GetPlayerMapPosition("player")
			return math.floor((y * 100) + 0.5)
		end,
	},
	
	-- target information
	["%%tn%%"] = {
		name = L["Target's Name"],
		func = function() return UnitExists("target") and UnitName("target") or L["<notarget>"] end,
	},
	["%%tc%%"] = {
		name = L["Target's Class"],
		func = function()
			if not UnitExists("target") then
				return L["<notarget>"]
			else
				local class, _ = UnitClass("target")
				return class
			end
		end,
	},
	["%%tl%%"] = {
		name = L["Target's Level"],
		func = function() return UnitExists("target") and UnitLevel("target") or L["<notarget>"] end,
	},
	["%%tg%%"] = {
		name = L["Target's Gender"],
		func = function()
			if not UnitExists("target") then
				return L["<notarget>"]
			else
				return UnitSex("target") == 2 and L["Male"] or L["Female"]
			end
		end,
	},
	
	-- target health
	["%%th%%"] = {
		name = L["Target's Health"],
		func = function() return UnitExists("target") and UnitHealth("target") or L["<notarget>"] end,
	},
	["%%thm%%"] = {
		name = L["Target's Max Health"],
		func = function() return UnitExists("target") and UnitHealthMax("target") or L["<notarget>"] end,
	},
	["%%thp%%"] = {
		name = L["Target's Health Percent"],
		func = function() return UnitExists("target") and math.floor(UnitHealth("target") / UnitHealthMax("target") * 100) or L["<notarget>"] end,
	},
	["%%thd%%"] = {
		name = L["Target's Health Deficit"],
		func = function() return UnitExists("target") and UnitHealthMax("target") - UnitHealth("target") or L["<notarget>"] end,
	},
	
	-- target mana
	["%%tm%%"] = {
		name = L["Target's Mana"],
		func = function() return UnitExists("target") and UnitMana("target") or L["<notarget>"] end,
	},
	["%%tmm%%"] = {
		name = L["Target's Max Mana"],
		func = function() return UnitExists("target") and UnitManaMax("target") or L["<notarget>"] end,
	},
	["%%tmp%%"] = {
		name = L["Target's Mana Percent"],
		func = function() return UnitExists("target") and math.floor(UnitMana("target") / UnitManaMax("target") * 100) or L["<notarget>"] end,
	},
	["%%tmd%%"] = {
		name = L["Target's Mana Deficit"],
		func = function() return UnitExists("target") and UnitManaMax("target") - UnitMana("target") or L["<notarget>"] end,
	},
	
	-- date/time subs
	["%%date%%"] = {
		name = L["Date"],
		func = function() return date("%Y-%m-%d") end,
	},
	["%%time%%"] = {
		name = L["Time"],
		func = function() return ("%s:%s%s"):format(date("%I"), date("%M"), date("%p"):lower()) end,
	},
	["%%day%%"] = {
		name = L["Day"],
		func = function() return date("%A") end,
	},
	["%%mon%%"] = {
		name = L["Month"],
		func = function() return date("%B") end,
	},
	["%%year%%"] = {
		name = L["Year"],
		func = function() return date("%Y") end,
	},
	["%%hour%%"] = {
		name = L["Hour (12hr)"],
		func = function() return date("%I") end,
	},
	["%%h24%%"] = {
		name = L["Hour (24hr)"],
		func = function() return date("%H") end,
	},
	["%%min%%"] = {
		name = L["Minute"],
		func = function() return date("%M") end,
	},
	["%%sec%%"] = {
		name = L["Second"],
		func = function() return date("%S") end,
	},
	
	-- misc
	["%%rand%%"] = {
		name = L["Random Number"],
		func = function() return math.random(1, 100) end,
	},
}