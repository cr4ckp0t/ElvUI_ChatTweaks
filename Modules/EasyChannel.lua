-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-- Module Created By Klix (EU, Twisting Nether)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Easy Channel", "AceConsole-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Easy Channel"]
Module.namespace = string.gsub(Module.name, " ", "")

local IsInGroup = _G["IsInGroup"]
local IsInRaid = _G["IsInRaid"]
local IsInGuild = _G["IsInGuild"]
local IsShiftKeyDown = _G["IsShiftKeyDown"]
local GetChannelName = _G["GetChannelName"]

local ipairs, select, tostring = ipairs, select, tostring
local strsub = string.sub
local IsInGroup = IsInGroup
local IsInGuild = IsInGuild
local IsInInstance = IsInInstance
local IsInRaid = IsInRaid
local IsShiftKeyDown = IsShiftKeyDown

local cycles = {
	{
		chatType = "SAY",
		use = function(self, editbox) return 1 end,
	},
	{
        chatType = "YELL",
        use = function(self, editbox) return 1 end,
    },
	{
		chatType = "PARTY",
		use = function(self, editbox) return IsInGroup() end,
	},
	{
		chatType = "RAID",
		use = function(self, editbox) return IsInRaid() end,
	},
	{
		chatType = "INSTANCE_CHAT",
		use = function(self, editbox) return select(2, IsInInstance()) == "pvp" end,
	},
	{
		chatType = "GUILD",
		use = function(self, editbox) return IsInGuild() end,
	},
	{
		chatType = "CHANNEL",
        use = function(self, editbox, currChatType)

                local currNum
                if currChatType ~= "CHANNEL" then
                    currNum = IsShiftKeyDown() and 21 or 0
                else
                    currNum = editbox:GetAttribute("channelTarget");
                end
                local h, r, step = currNum+1, 20, 1
                if IsShiftKeyDown() then h, r, step = currNum-1, 1, -1 end
                for i=h,r,step do
                    local channelNum, channelName = GetChannelName(i);
                    if channelNum > 0 and not channelName:find("local %-") then
                        editbox:SetAttribute("channelTarget", i);
                        return true;

                end
            end
        end,
    },
    {
        chatType = "SAY",
        use = function(self, editbox) return 1 end,
    },
}

function Module:ChatEdit_CustomTabPressed(self)
	if strsub(tostring(self:GetText()), 1, 1) == "/" then return end
	local currChatType = self:GetAttribute("chatType")
	
	if currChatType == "WHISPER" or currChatType == "BN_WHISPER" then
		self:SetAttribute("chatType", chatTypeBeforeSwitch or "SAY");
		ChatEdit_UpdateHeader(self)
    end
	
	for i, curr in ipairs(cycles) do
		if curr.chatType == currChatType then
			local h, r, step = i+1, #cycles, 1
			if IsShiftKeyDown() then h, r, step = i-1, 1, -1 end
			if currChatType=="CHANNEL" then h = i end
			for j = h, r, step do
				if cycles[j]:use(self, currChatType) then
					self:SetAttribute("chatType", cycles[j].chatType)
					ChatEdit_UpdateHeader(self)
					return
				end
			end
		end
	end
end

function Module:OnEnable()
	self:SecureHook("ChatEdit_CustomTabPressed")
end

function Module:OnInitialize()
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:OnDisable()
	self:Unhook("ChatEdit_CustomTabPressed")
end

function Module:Info()
	return L["Makes it easy to navigate through the different channels by pressing the 'TAB' Key."]
end
