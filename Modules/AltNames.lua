-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------

-- This module is only a slightly modified AltNames module from Chatter.
-- Only modified enough to work for with the different setup of this script.
local Module = ElvUI_ChatTweaks:NewModule("Alt Names", "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
local LA
Module.name = L["Alt Names"]
Module.namespace = string.gsub(Module.name, " ", "")

local NAMES, GUILDNOTES
local pairs = _G.pairs
local select = _G.select
local setmetatable = _G.setmetatable
local tinsert = _G.tinsert
local tremove = _G.tremove
local type = _G.type
local unpack = _G.unpack
local strlower = _G.string.lower
local gmatch = _G.string.gmatch

local leftBracket, rightBracket

local colorModes = {
	COLOR_MOD = L["Use PlayerNames Coloring"],
	CUSTOM = L["Use Custom Color"],
	CHANNEL = L["Use Channel Color"]
}

local customColorNames = setmetatable({}, {
	__index = function(t, v)
		local r, g, b = unpack(Module.db.global.color)
		t[v] = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, v)
		return t[v]
	end
})

local db, options
local defaults = {
	realm = {},
	global = {
		guildNotes = true,
		altNotesFallback = true,
		colorMode = "CHANNEL",
		color = {0.6, 0.6, 0.6},
		leftBracket = "[",
		rightBracket = "]",
		tooltip = true,
		showMain = true,
		showAlts = true,
	}
}

local accept = function(frame, char, editBox)
	if editBox then
		local main = editBox:GetText()
		Module:AddAlt(char, main, frame.data)
	end
	frame:Hide()
end

UnitPopupButtons["SET_MAIN"] = {
	text = L["Set Main"],
	dist = 0,
	func = Module.GetMainName
}

function Module:Accept(frame, char, editBox)
	accept(frame, char, editBox)
end

function Module.GetMainName()
	local alt = UIDROPDOWNMENU_INIT_MENU.name
	alt = alt:find("-") and alt:sub(1, alt:find("-") - 1) or alt -- strip realm, if necessary
	local popup = StaticPopup_Show("MENUITEM_SET_MAIN", alt)
	if popup then 
		popup.data = alt 
		local editbox = _G[popup:GetName().."EditBox"]
		editbox:SetText(NAMES[alt] or GUILDNOTES[alt] or "")
		editbox:HighlightText()
	end	
end

function Module:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData, ...)
	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
		local button = _G["DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i];
		if button.value == "SET_MAIN" then
		    button.func = UnitPopupButtons["SET_MAIN"].func
		end
	end
end

function Module:AddAlt(alt, main)
	if #main == 0 then
		if GUILDNOTES[alt] then
			-- blah
		else
			NAMES[alt] = nil
			LA:DeleteAlt(NAMES[alt], alt, nil)
			main = nil
		end
	end
	if main then LA:SetAlt(main, alt, nil) end
end

local function pName(msg, name)
	if name and #name > 0 then
		local alt = NAMES[name] or GUILDNOTES[name]
		if alt and alt ~= "" then		-- empty notes can be stored to override guildnote data
			local mode = db.colorMode
			if mode == "CUSTOM" then				
				alt = customColorNames[alt]
			elseif mode == "COLOR_MOD" and Module.colorMod and Module.colorMod:IsEnabled() then
				alt = Module.colorMod:ColorName(alt)
			end
			return ("%s%s%s%s"):format( msg, leftBracket, alt, rightBracket )
		end
	end
	return msg
end

function Module:AddMessage(frame, text, ...)
	if text and type(text) == "string" then 
		--text = text:gsub("(|Hplayer:([^:]+)[:%d+]*|h.-|h)", pName)
		text = text:gsub("(|Hplayer:([^:]+).-|h.-|h)", pName)
	end
	return self.hooks[frame].AddMessage(frame, text, ...)
end

function Module:EnableGuildNotes(enable)
	GUILDNOTES = {}
	if enable then
		Module:RegisterEvent("GUILD_ROSTER_UPDATE")
		if IsInGuild() then GuildRoster() end
		Module:ScanGuildNotes()
	else
		Module:UnregisterEvent("GUILD_ROSTER_UPDATE")
	end
end

local doscan = true -- always scan when we start
function Module:GUILD_ROSTER_UPDATE(event, arg1)
	if arg1 or (GuildFrame and GuildFrame:IsVisible()) or doscan then
		doscan = false
		Module:ScanGuildNotes()
	end
	
	if arg1 then doscan = true end
end

function Module:ScanGuildNotes()
	if not IsInGuild() then return end
	
	local gName = GetGuildInfo("player")
	local names = {}
	GUILDNOTES = {}
	
	-- #1: get all the names
	for i = 1, GetNumGuildMembers(true) do
		local name = GetGuildRosterInfo(i)
		names[strlower(name or "?")] = name
	end
	
	-- #2: scan all words in all guild notes, see if name is mentioned
	for i = 1,GetNumGuildMembers(true) do
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
		local success
		name = name:find("-") and name:sub(1, name:find("-") - 1) or name -- strip the realm, if exists
		for word in gmatch(strlower(note), "[%a\128-\255]+") do
			if names[word] then
				GUILDNOTES[name] = names[word]
				LA:SetAlt(name, names[word], LA.GUILD_PREFIX .. gName)
				success = true
				break
			end
		end
		if not success and db.altNotesFallback and note ~= "" then
			-- #3:  no joy? then if this is an 'alt' rank, use the entire note
			rank = strlower(rank)
			if strfind(rank, "alt") or
				strfind(rank, L["alt2"]) or
				strfind(rank, L["alt3"]) then
				GUILDNOTES[name] = note
				LA:SetAlt(name, note, LA.GUILD_PREFIX .. gName)
			end
		end
	end
end

function Module:LA_SetAlt(event, main, alt, source)
	if not source then
		NAMES[alt] = main
	end
end

function Module:LA_RemoveAlt(event, main, alt, source)
	if not source then
		NAMES[alt] = nil
	else
		GUILDNOTES[alt] = nil
	end
end	

function Module:Join(tbl, glue, gluebeforelast)
	if type(tbl) ~= "table" then return tbl end
	local list, index = {}, 1
	
	for i, v in pairs(tbl) do
		local vtype = type(v)
		local item = v
		if vtype ~= "string" then
			item = vtype
		end
		list[index] = item or vtype
		index = index + 1
	end
	
	-- some error checking
	if #list == 0 then return ""
	elseif #list == 1 then return list[1] end
	
	glue = glue or ", "
	gluebeforelast = gluebeforelast or (", %s "):format(L["and"])
	
	local last = table.remove(list) or ""
	local str = table.concat(list, glue)
	return str .. gluebeforelast .. last
end

function Module:OnTooltipSetUnit()
	if db.tooltip and GameTooltip and not self.showingTooltip then
		local char, uid = GameTooltip:GetUnit()
		if UnitIsPlayer(uid) then
			local main, tooltipAltered = "", false
			
			if db.showMain then
				main = LA:GetMain(char)
				if main and main ~= "" then
					GameTooltip:AddDoubleLine(L["Main: "], main, 1, 0.9, 0, 0.5, 0.5, 1)
					tooltipAltered = true
				end
			end
			
			local width = GameTooltip:GetWidth()
			if db.showAlts then
				local alts = LA:GetAlts(char) or LA:GetAlts(main)
				if alts then
					GameTooltip:AddLine((L["|cffffc080Alts:|r %s"]):format(self:Join(alts)), 1, 0.5, 0.5, 1)
					tooltipAltered = true
				end
			end
			
			if tooltipAltered then
				GameTooltip:SetWidth(width)
				GameTooltip:Show()
			end
			
			self.showingTooltip = true
		end
	end
end

function Module:OnTooltipCleared()
	self.showingTooltip = false
end

function Module:HookTooltip()
	if db.tooltip then
		self:SecureHookScript(GameTooltip, "OnTooltipSetUnit")
		self:SecureHookScript(GameTooltip, "OnTooltipCleared")
	else
		if self:IsHooked(GameTooltip, "OnTooltipSetUnit") then
			self:Unhook(GameTooltip, "OnTooltipSetUnit")
		end
		
		if self:IsHooked(GameTooltip, "OnTooltipCleared") then
			self:Unhook(GameTooltip, "OnTooltipCleared")
		end
	end
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnEnable()
	LA = LibStub("LibAlts-1.0")
	LA.RegisterCallback(self, "LibAlts_SetAlt", "LA_SetAlt")
	LA.RegisterCallback(self, "LibAlts_RemoveAlt", "LA_RemoveAlt")
	NAMES = self.db.realm
	
	for k, v in pairs(NAMES) do
		LA:SetAlt(v, k, nil)
	end
	
	UnitPopupButtons["SET_MAIN"].func = self.GetMainName
	tinsert(UnitPopupMenus["SELF"], #UnitPopupMenus["SELF"] - 1, "SET_MAIN")
	tinsert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"] - 1, "SET_MAIN")
	tinsert(UnitPopupMenus["FRIEND"], #UnitPopupMenus["FRIEND"] - 1, "SET_MAIN")
	tinsert(UnitPopupMenus["PARTY"], #UnitPopupMenus["PARTY"] - 1, "SET_MAIN")
	self:SecureHook("UnitPopup_ShowMenu")
	
	leftBracket, rightBracket = db.leftBracket, db.rightBracket
	
	Module:EnableGuildNotes(db.guildNotes)
	
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		if cf ~= COMBATLOG then
			self:RawHook(cf, "AddMessage", true)
		end
	end
	
	for index, name in ipairs(self.TempChatFrames) do
		local cf = _G[name]
		if cf then
			self:RawHook(cf, "AddMessage", true)
		end
	end
	self.colorMod = ElvUI_ChatTweaks:GetModule("Player Names")
	
	if db.tooltip then
		self:HookTooltip()
	end
end

local types = {"SELF", "PLAYER", "FRIEND", "PARTY"}
function Module:OnDisable()
	for j = 1, #types do
		local t = types[j]
		for i = 1, #UnitPopupMenus[t] do
			if UnitPopupMenus[t][i] == "SET_MAIN" then
				tremove(UnitPopupMenus[t], i)
				break
			end
		end
	end
	Module:EnableGuildNotes(false)
	
	if self:IsHooked(GameTooltip, "OnTooltipSetUnit") then
		self:Unhook(GameTooltip, "OnTooltipSetUnit")
	end
	
	if self:IsHooked(GameTooltip, "OnTooltipCleared") then
		self:Unhook(GameTooltip, "OnTooltipCleared")
	end
end

function Module:Decorate(frame)
	if not self:IsHooked(frame, "AddMessage") then
		self:RawHook(frame, "AddMessage", true)
	end
end

function Module:GetOptions()
	if not options then
		options = {
			guildNotes = {
				order=100,
				type = "toggle",
				name = L["Use guildnotes"],
				desc = L["Look in guildnotes for character names, unless a note is set manually"],
				get = function() return db.guildNotes end,
				set = function(info, v)
					db.guildNotes = v
					mod:EnableGuildNotes(v)
				end,
			},
			altNotesFallback = {
				order=101,
				type = "toggle",
				name = L["Alt note fallback"],
				desc = L["If no name can be found for an 'alt' rank character, use entire note"],
				disabled = function() return not db.guildNotes end,
				get = function() return db.altNotesFallback end,
				set = function(info, v)
					db.altNotesFallback = v
					mod:ScanGuildNotes()
				end,
			},	
			colorMode = {
				order=110,
				type = "select",
				name = L["Name color"],
				desc = L["Set the coloring mode for alt names"],
				values = colorModes,
				get = function() return db.colorMode end,
				set = function(info, v)
					db.colorMode = v
				end
			},
			color = {
				order=111,
				type = "color",
				name = L["Custom color"],
				desc = L["Select the custom color to use for alt names"],
				get = function() return unpack(db.color) end,
				set = function(info, r, g, b)
					db.color[1] = r
					db.color[2] = g
					db.color[3] = b
					for k, v in pairs(customColorNames) do
						customColorNames[k] = nil
					end
				end,
				disabled = function() return db.colorMode ~= "CUSTOM" end
			},
			leftbracket = {
				type = "input",
				name = L["Left Bracket"],
				desc = L["Character to use for the left bracket"],
				get = function() return db.leftBracket end,
				set = function(i, v)
					db.leftBracket = v
					leftBracket = v
				end
			},
			rightbracket = {
				type = "input",
				name = L["Right Bracket"],
				desc = L["Character to use for the right bracket"],
				get = function() return db.rightBracket end,
				set = function(i, v)
					db.rightBracket = v
					rightBracket = v
				end
			},
			resetNames = {
				type = "execute",
				order = -2,
				name = L["Reset Names"],
				desc = L["Reset saved mains/alts.\n\n|cffff0000This CANNOT be undone.|r"],
				width = "double",
				func = function()
					NAMES = {}; GUILDNOTES = {}
					Module.db.realm = {}
					if db.guildNotes then
						Module:ScanGuildNotes()
					end
					Module:Print(L["Reset alt names and their mains."])
				end,
			},
			hookTooltip = {
				type = "group",
				order = -1,
				guiInline = true,
				name = L["Tooltip"],
				args = {
					tooltip = {
						type = "toggle",
						order = 1,
						name = L["Hook Tooltip"],
						desc = L["Hook the tooltip to show the toon's main or alts."],
						get = function() return db.tooltip end,
						set = function(_, value)
							db.tooltip = value
							self:HookTooltip()
						end,
					},
					showMain = {
						type = "toggle",
						order = 2,
						name = L["Show Main"],
						desc = L["Add the player's main to the tooltip."],
						disabled = function() return not db.tooltip end,
						get = function() return db.showMain end,
						set = function(_, value) db.showMain = value end,
					},
					showAlts = {
						type = "toggle",
						order = 3,
						name = L["Show Alts"],
						desc = L["Add the player's alts to the tooltip."],
						disabled = function() return not db.tooltip end,
						get = function() return db.showAlts end,
						set = function(_, value) db.showAlts = value end,
					},
				},
			},
		}
	end
	return options
end

function Module:Info()
	return L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name.  Can also scan guild notes for character names to display, if no note has been manually set."]
end