-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpot (US, Thrall)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local E, _, V, P, G = unpack(ElvUI)
local _G = getfenv(0)
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)

local unpack = _G["unpack"]
local GetAddOnMetadata = _G["GetAddOnMetadata"]
local UIDropDownMenu_AddButton = _G["UIDropDownMenu_AddButton"]
local collectgarbage = _G["collectgarbage"]
local IsAddOnLoaded = _G["IsAddOnLoaded"]
local C_ChatInfo_SendAddonMessage = C_ChatInfo.SendAddonMessage
local IsInRaid = _G["IsInRaid"]
local GetNumGroupMembers = _G["GetNumGroupMembers"]
local IsLFGModeActive = _G["IsLFGModeActive"]
local GetNumSubgroupMembers = _G["GetNumSubgroupMembers"]
local IsInGuild = _G["IsInGuild"]
local UnitName = _G["UnitName"]
local StaticPopup_Show = _G["StaticPopup_Show"]

-- load globals
ElvUI_ChatTweaks = LibStub("AceAddon-3.0"):NewAddon("ElvUI_ChatTweaks", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
ElvUI_ChatTweaks.version = GetAddOnMetadata("ElvUI_ChatTweaks", "Version")
ElvUI_ChatTweaks.addonName = "ElvUI_ChatTweaks"
ElvUI_ChatTweaks.hexColor = ""
ElvUI_ChatTweaks.abbrev = L["ElvUI_CT"]
ElvUI_ChatTweaks.options = {
	type = "group",
	name = ElvUI_ChatTweaks.addonName,
	args = {},
}
ElvUI_ChatTweaks.E = E
ElvUI_ChatTweaks.L = L
ElvUI_ChatTweaks.NewSign = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:14:14|t"
ElvUI_ChatTweaks.Icon = [[Interface\Addons\ElvUI_ChatTweaks\Textures\icon.tga]]
BINDING_HEADER_CTC = L["%sChat Tweaks|r"]:format(ElvUI_ChatTweaks.hexColor)

local DEFAULT_WIDTH = 890;
local DEFAULT_HEIGHT = 651;

local concat = table.concat
local insert = table.insert
local sort = table.sort

-- about page
--local fields = {"Title", "Version", "Author", "X-Category", "X-License", "X-Email", "Email", "eMail", "X-Website", "X-Credits", "X-Localizations", "X-Donate", "X-Paypal"}
--local fieldName = "|cff1784d1%s:|r"

-- for all modules
local prototype = {
	Decorate = function(self, chatframe) end,
	Popout = function(self, chatframe, srcchatframe) end,
	TempChatFrames = {},
	AddTempChat = function(self, name) insert(self.TempChatFrames, name) end,
	AlwaysDecorate = function(self, chatframe) end,
}

ElvUI_ChatTweaks:SetDefaultModulePrototype(prototype)
ElvUI_ChatTweaks:SetDefaultModuleState(false)

-- hook the print function of aceconsole
ElvUI_ChatTweaks.Print_ = ElvUI_ChatTweaks.Print
ElvUI_ChatTweaks.Print = function(self, ...)
	local tmp = {}
	local out = string.join("", ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.abbrev, "|r: %s")
	for i = 1, select("#", ...) do
		tmp[i] = tostring(select(i, ...))
	end
	DEFAULT_CHAT_FRAME:AddMessage(out:format(tostring(select(1, ...))))
end

local function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do insert(a, n) end
	sort(a, f)
	local i = 0
	local iter = function()
		i = i + 1
		if a[i] == nil then 
			return nil
		else 
			return a[i], t[a[i]]
		end
	end
	return iter
end

--[[ Ace3 Framework Events ]]--
function ElvUI_ChatTweaks:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("ElvUI_ChatTweaksDB", self.defaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "SetUpdateConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "SetUpdateConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "SetUpdateConfig")
	
	-- add to elvui's config
	LibStub("LibElvUIPlugin-1.0"):RegisterPlugin(self.addonName, function()
		if not E.Options.args.Crackpotx then
			E.Options.args.Crackpotx = {
				type = "group",
				order = -2,
				name = L["Plugins by |cff0070deCrackpotx|r"],
				args = {
					thanks = {
						type = "description",
						order = 1,
						name = L["Thanks for using and supporting my work!  -- |cff0070deCrackpotx|r\n\n|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."],
					},
				},
			}
		elseif not E.Options.args.Crackpotx.args.thanks then
			E.Options.args.Crackpotx.args.thanks = {
				type = "description",
				order = 1,
				name = L["Thanks for using and supporting my work!  -- |cff0070deCrackpotx|r\n\n|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."],
			}
		end
	
		E.Options.args.Crackpotx.args.chattweaks = {
			type = "group",
			name = L["Chat Tweaks"],
			args = {
				showect = {
					type = "execute",
					name = L["Show ElvUI Chat Tweaks Config Window"],
					desc = L["Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."],
					width = "double",
					func = function() ElvUI_ChatTweaks:ToggleConfig(true); E:ToggleOptionsUI(); end,
				},
			},
		}
	end)
end

function ElvUI_ChatTweaks:OnEnable()
	-- add the modules' options tables
	for k, v in self:IterateModules() do
		self.options.args[k:gsub(" ", "_")] = {
			type = "group",
			name = v.name or k,
			--guiInline = true,
			args = nil
		}
		local t
		if v.GetOptions then
			t = v:GetOptions()
			t.settingsHeader = {
				type = "header",
				name = L["Settings"],
				order = 12
			}
		end
		t = t or {}
		t.toggle = {
			type = "toggle",
			name = v.toggleLabel or (L["Enable "] .. (v.name or k)),
			width = "double",
			desc = v:Info() and v:Info() or (L["Enable "] .. (v.name or k)),
			order = 11,
			get = function() return self.db.global.modules[k] ~= false or false end,
			set = function(_, value)
				self.db.global.modules[k] = value
				if value then
					self:EnableModule(k)
					self:Print((L["Enabled %s%s|r module."]):format(self.hexColor, k))
				else
					self:DisableModule(k)
					self:Print((L["Disabled %s%s|r module."]):format(self.hexColor, k))
				end
			end
		}
		t.header = {
			type = "header",
			name = v.name or k,
			order = 9
		}
		if v.Info then
			t.description = {
				type = "description",
				name = v:Info() .. "\n\n",
				order = 10
			}
		end
		self.options.args[k:gsub(" ", "_")].args = t
	end

	for k, v in self:IterateModules() do
		if self.db.global.modules[k] ~= false then v:Enable() end
	end
	
	AceConfig:RegisterOptionsTable(self.addonName, self.options)
	AceConfigDialog:SetDefaultSize(self.addonName, DEFAULT_WIDTH, DEFAULT_HEIGHT)
	
	self:AddMenuHook(self, {
		text = L["ElvUI ChatTweaks"],
		func = function()
			local mode = "Close"
			if not AceConfigDialog.OpenFrames[self.addonName] then
				mode = "Open"
			end
			AceConfigDialog[mode](AceConfigDialog, self.addonName)
		end,
		notCheckable = 1
	})
	self:RawHook("FCF_Tab_OnClick", true)
	
	-- chat command
	self:RegisterChatCommand("ct", function(args)
		local cmd = self:GetArgs(args)
		if not cmd or cmd == "" or cmd == "config" then
			self:ToggleConfig()
		elseif cmd == "version" or cmd == "ver" then
			self:Print((L["You are running version |cff1784d1%s|r."]):format(self.version))
		elseif cmd == "modules" or cmd == "mods" then
			local modStatus, enabled, disabled = {}, 0, 0
			for name, module in self:IterateModules() do
				modStatus[name] = module:IsEnabled() and true or false
				if module:IsEnabled() then enabled = enabled + 1
				else disabled = disabled + 1 end
			end
			
			if not modStatus then
				self:Print(L["|cffff0000No modules found.|r"])
			else
				local moduleName = "    +|cff00ffff%s|r - %s"
				local enabledModule  = L["|cff00ff00Enabled|r"]
				local disabledModule = L["|cffff0000Disabled|r"]
				self:Print(format(L[" |cffffff00%d|r Total Modules (|cff00ff00%d|r Enabled, |cffff0000%d|r Disabled)"], (enabled + disabled), enabled, disabled))
				for name, status in pairsByKeys(modStatus) do
					print(format(moduleName, name, status == true and enabledModule or disabledModule))
				end
			end
		elseif cmd == "help"  or cmd == "?" then
			self:PrintHelp()
		end
	end)
	
	-- hook every module's print function
	for name, module in self:IterateModules() do
		module.Print_ = module.Print
		module.Print = function(self, ...)
			local out = string.join("", ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.abbrev, "|r: %s")
			DEFAULT_CHAT_FRAME:AddMessage(out:format(tostring(select(1, ...))))
		end
	end
end

function ElvUI_ChatTweaks:PrintHelp()
	local argStr  = L["   |cff00ff00/ct %s|r - %s"]
	local arg2Str = L["   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s"]
	local clrStr  = L["   |cff00ff00%s|r or |cff00ff00%s|r - %s"]
	local cmdStr  = L["   |cff00ff00%s|r - %s"]
	self:Print(L["Available Chat Command Arguments"])
	print(format(argStr, "config", L["Opens configuration window."]))
	print(format(arg2Str, "modules", "mods", L["Prints module status."]))
	print(format(arg2Str, "help", "?", L["Print this again."]))
	print(format(arg2Str, "version", "ver", L["Print Addon Version"]))
	-- determine if clear chat command module is enabled
	
	for name, module in self:IterateModules() do
		if module:IsEnabled() and name == "Clear Chat Commands" then
			print(format(clrStr, "/clr", "/clear", L["Clear current chat."]))
			print(format(clrStr, "/clrall", "/clearall", L["Clear all chat windows."]))
		elseif module:IsEnabled() and name == "GKick Command" then
			print(format(cmdStr, "/gkick", L["Alternate command to kick someone from guild."]))
		elseif module:IsEnabled() and name == "Group Say Command" then
			print(format(cmdStr, "/gs", L["Talk to your group based on party/raid status."]))
		elseif module:IsEnabled() and name == "Tell Target" then
			print(format(cmdStr, "/tt", L["Send a tell to your target."]))
		elseif module:IsEnabled() and name == "Developer Tools" then
			print(format(cmdStr, "/ctdev", L["Various Developer Tools"]))
		elseif module:IsEnabled() and name == "Fake Achievement" then
			print(format(cmdStr, "/fake", L["Generate fake achievement links."]))
		elseif module:IsEnabled() and name == "Token Price" then
			print(format(clrStr, "/tp", "/token", L["Show current token price."]))
		elseif module:IsEnabled() and name == "Who Whispered Me" then
			print(format(cmdStr, "/ws", L["Show how many whispers you've received this session."]))
		elseif module:IsEnabled() and name == "Keystone Progress" then
			print(format(cmdStr, "/ksm", L["Display Keystone Master achievement progress."]))
			print(format(cmdStr, "/ksc", L["Display Keystone Conqueror achievement progress."]))
		end
	end
end

do
	local info, menuHooks = {}, {}
	function ElvUI_ChatTweaks:AddMenuHook(module, hook)
		menuHooks[module] = hook
	end
	
	function ElvUI_ChatTweaks:RemoveMenuHook(module)
		menuHooks[module] = nil
	end
	
	function ElvUI_ChatTweaks:FCF_Tab_OnClick(...)
		self.hooks.FCF_Tab_OnClick(...)
		for module, v in pairs(menuHooks) do
			local menu
			if type(v) == "table" then
				menu = v
			else
				menu = module[v](module, ...)
			end
			UIDropDownMenu_AddButton(menu)
		end
	end
end

function ElvUI_ChatTweaks:FCF_OpenTemporaryWindow(chatType, chatTarget, sourceChatFrame, selectWindow)
	local frame = self.hooks.FCF_OpenTemporaryWindow(chatType, chatTarget, sourceChatFrame, selectWindow)
	if frame then
		for k, v in self:IterateModules() do
			if not frame.isDecorated then
				v:AddTempChat(frame:GetName())
			end
			if v:IsEnabled() and not frame.isDecorated then
				v:Decorate(frame)
			end
			if v:IsEnabled() then
				v:Popout(frame, sourceChatFrame or DEFAULT_CHAT_FRAME)
			end
			v:AlwaysDecorate(frame)
		end
	end
	FCFDock_ForceReanchoring(GENERAL_CHAT_DOCK)
	return frame
end

function ElvUI_ChatTweaks:ToggleConfig(dontPrint)
	--InterfaceOptionsFrame_OpenToCategory(ElvUI_ChatTweaks.frames.general)	
	local mode = "Close"
	if not AceConfigDialog.OpenFrames[self.addonName] then
		mode = "Open"
		
		if not dontPrint then
			self:Print(L["Showing Configuration Options"])
		end
		
	elseif AceConfigDialog.OpenFrames[self.addonName] then
		mode = "Close"
		
		if not dontPrint then
			self:Print(L["Hiding Configuration Options"])
		end
	end
	AceConfigDialog[mode](AceConfigDialog, self.addonName)
end


function ElvUI_ChatTweaks:SetUpdateConfig(dummy)
	self:DisableAllModules()
	self.db = LibStub("AceDB-3.0"):New("ElvUI_ChatTweaksDB", self.defaults)
	--self.db.RegisterCallback(self, "OnProfileChanged", "SetUpdateConfig")
	--self.db.RegisterCallback(self, "OnProfileCopied", "SetUpdateConfig")
	--self.db.RegisterCallback(self, "OnProfileReset", "SetUpdateConfig")
	for k, v in self:IterateModules() do
		v:OnInitialize()
		if self.db.global.modules[k] ~= false then 
			v:Enable()
		else
			v:Disable()
		end
	end
	collectgarbage('collect');
end

function ElvUI_ChatTweaks:UpdateConfig()
	for _, v in self:IterateModules() do
		if v:IsEnabled() then
			v:Disable()
			v:Enable()
		end
	end
end

function ElvUI_ChatTweaks:ModuleEnabled(module)
	for name, value in self:IterateModules() do
		if name:lower():gsub(" ", "") == module:lower():gsub(" ", "") then
			return value:IsEnabled()
		end
	end
	return false
end

function ElvUI_ChatTweaks:GetModuleStatus()
	local active, inactive, total = 0, 0, 0
	for _, value in self:IterateModules() do
		if value:IsEnabled() then
			active = active + 1
		else
			inactive = inactive + 1
		end
		total = total + 1
	end
	return active, inactive, total
end

function ElvUI_ChatTweaks:NumModules()
	local total = 0
	for _, value in self:IterateModules() do
		total = total + 1
	end
	return total
end

function ElvUI_ChatTweaks:EnableAllModules()
	for name, module in self:IterateModules() do
		if self.db.global.debugging then
			self:Print((L["Enabled %s%s|r module."]):format(self.hexColor, name))
		end
		module:Enable()
	end
end

function ElvUI_ChatTweaks:DisableAllModules()
	for name, module in self:IterateModules() do
		if self.db.global.debugging then
			self:Print((L["Disabled %s%s|r module."]):format(self.hexColor, name))
		end
		module:Disable()
	end
end

function ElvUI_ChatTweaks:PLAYER_ENTERING_WORLD(event, ...)
	self.abbrev = self.db.global.shorten and L["ElvUI_CT"] or L["ElvUI_ChatTweaks"]
	if self.db.global.welcome == true then
		self:Print((L["Version %s%s|r is loaded. Type %s/ct|r if you need help."]):format(self.hexColor, self.version, self.hexColor))
	end
	
	if IsAddOnLoaded("Prat-3.0") then
		print(L["You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it."])
	end
	
	if IsAddOnLoaded("Chatter") then
		print(L["You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it."])
	end
	
	self.NotifyTimer = self:ScheduleTimer("SendMessage", 12)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end
ElvUI_ChatTweaks:RegisterEvent("PLAYER_ENTERING_WORLD")

-- auto update notify
function ElvUI_ChatTweaks:SendMessage()
	local inInstance, instanceType = IsInInstance()
	
	if self.db.global.debugging then
		self:Print((L["Addon Version Sent, Version: |cffffff00%s|r"]):format(tostring(self.version)))
	end
	
	if inInstance and instanceType == "pvp" or instanceType == "arena" then
		C_ChatInfo_SendAddonMessage("self", self.version, "INSTANCE_CHAT")
	else
		if IsInRaid() and GetNumGroupMembers() > 0 then
			C_ChatInfo_SendAddonMessage("self", self.version, IsLFGModeActive(LE_LFG_CATEGORY_LFR) and "INSTANCE_CHAT" or "RAID")
		elseif not IsInRaid() and GetNumSubgroupMembers() > 0 then
			C_ChatInfo_SendAddonMessage("self", self.version, IsLFGModeActive(LE_LFG_CATEGORY_LFD) and "INSTANCE_CHAT" or "PARTY")
		elseif IsInGuild() then
			C_ChatInfo_SendAddonMessage("self", self.version, "GUILD")
		end
	end
	
	if self.NotifyTimer then
		self:CancelTimer(self.NotifyTimer)
		self.NotifyTimer = nil
	end
end

function ElvUI_ChatTweaks:CHAT_MSG_ADDON(event, prefix, message, channel, sender)
	if not self.db.global.notify then return end
	if sender == UnitName("player") then return end
	
	if prefix == "self" and not self.receivedOutOfDateMessage then
		if tonumber(message) ~= nil and tonumber(message) > tonumber(self.version) then
			if self.db.global.debugging then self:Print((L["Your Version: |cffffff00%d|r, Latest Version: |cffffff00%d|r"]):format(tonumber(self.version), tonumber(message))) end
			self:Print((L["Your version of %s is out of date.  Latest version is |cff1784d1%d|r."]):format(self.addon, message))
			self.receivedOutOfDateMessage = true	-- to prevent receiving this message more than once
		end
	end
end
ElvUI_ChatTweaks:RegisterEvent("CHAT_MSG_ADDON")

local function ValueColorUpdate(hex, r, g, b)
	ElvUI_ChatTweaks.hexColor = hex
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

function ElvUI_ChatTweaks:CreateText(f, layer, fontsize, flag, justifyh)
	local text = f:CreateFontString(nil, layer)
	text:SetFont(E.media.normFont, fontsize, flag)
	text:SetJustifyH(justifyh or "CENTER")
	return text
end

--[[ Ace3 Options ]]--
ElvUI_ChatTweaks.options.args = {
	header = {
		type = "header",
		order = 1,
		name = L["Version"] .. (": |cff99ff33%s|r"):format(ElvUI_ChatTweaks.version),
		width = "full",
	},
	description = {
		type = "description",
		order = 2,
		name = L["This addon is designed to add a lot of the functionality of full fledged chat addons like Prat or Chatter, but without a lot of the unneeded bloat.  I wrote it to be as lightweight as possible, while still powerful enough to accomplish it's intended function.\n"],
		width = "full",
	},
	welcome = {
		type = "toggle",
		order = 3,
		name = L["Welcome Message"],
		desc = L["Show welcome message when logging in."],
		get = function() return ElvUI_ChatTweaks.db.global.welcome end,
		set = function(_, value) ElvUI_ChatTweaks.db.global.welcome = value end,
	},
	shorten = {
		type = "toggle",
		order = 4,
		name = L["Use Short Name"],
		desc = (L["Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."]):format(ElvUI_ChatTweaks.hexColor, ElvUI_ChatTweaks.hexColor),
		get = function() return ElvUI_ChatTweaks.db.global.shorten end,
		set = function(_, value)
			ElvUI_ChatTweaks.db.global.shorten = value
			ElvUI_ChatTweaks.abbrev = value and L["ElvUI_CT"] or L["ElvUI_ChatTweaks"]
		end,
	},
	notify = {
		type = "toggle",
		order = 5,
		name = L["New Version Notify"],
		desc = L["Notify on new release?"],
		get = function() return ElvUI_ChatTweaks.db.global.notify end,
		set = function(_, value) ElvUI_ChatTweaks.db.global.notify = value end,
	},
	debugging = {
		type = "toggle",
		order = 6,
		name = L["Enable Debugging"],
		desc = L["Enable various debugging messages to help with errors or undesired functioning."],
		get = function() return ElvUI_ChatTweaks.db.global.debugging end,
		set = function(_, value) ElvUI_ChatTweaks.db.global.debugging = value; StaticPopup_Show("ECT_RLUI"); end,
	},
	Space1 = {
		order = 7,
		type = "description",
		name = "",
	},
	enableAll = {
		type = "execute",
		order = 8,
		name = L["Enable All Modules"],
		func = function() StaticPopup_Show("ECT_ENABLE_ALL") end,
	},
	disableAll = {
		type = "execute",
		order = 9,
		name = L["Disable All Modules"],
		func = function() StaticPopup_Show("ECT_DISABLE_ALL") end,
	},
	toggleEC = {
		type = "execute",
		order = 10,
		name = L["Open ElvUI's Config"],
		desc = L["Click to toggle ElvUI's config window.  This will also close this window."],
		func = function() ElvUI_ChatTweaks:ToggleConfig(); E:ToggleOptionsUI(); end,
	},
}

ElvUI_ChatTweaks.defaults = {
	global = {
		welcome = true,
		notify = true,
		debugging = false,
		shorten = true,
		modules  = {
			-- modules disabled by default
			["Achievement Filter"] = false,
			["Addon Messages"] = false,
			["Alt Names"] = false,
			["Auction Message Filtering"] = false,
			["Automatic Chat Logging"] = false,
			["Auto Congratulate"] = false,
			["Auto Ding"] = false,
			["Auto Farewell"] = false,
			["Auto Welcome"] = false,
			["Channel Names"] = false,
			["Channel Sounds"] = false,
			["Chat Tabs"] = false,
			["Combat Log Remover"] = false,
			["Data Broker"] = false,
			["Developer Tools"] = false,
			["Emote Filter"] = false,
			["Fun Filters"] = false,
			["Guild Recruitment"] = false,
			["Guild Spam"] = false,
			["Lost Control Disable"] = false,
			["Magic 8-Ball"] = false,
			["Materials Farming"] = false,
			["Pet Battles"] = false,
			["Popup Messages"] = false,
			["Rare Announce"] = false,
			["Reroute Auction Messages"] = false,
			["Spam Log"] = false,
			["Strip Links"] = false,
			["Substitutions"] = false,
			["Text Justification"] = false,
			["Talent Squelch"] = false,
			["Who Taunted"] = false,
		}
	}
}
