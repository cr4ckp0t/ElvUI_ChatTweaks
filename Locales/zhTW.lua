-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-------------------------------------------------------------------------------
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI_ChatTweaks", "zhTW", false)
if not L then return end

L["   |cff00ff00%s|r - %s"] = true
L["   |cff00ff00%s|r or |cff00ff00%s|r - %s"] = "   |cff00ff00%s|r \230\136\150 |cff00ff00%s|r - %s"
L["   |cff00ff00/ct %s|r - %s"] = true
L["   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s"] = "   |cff00ff00/ct %s|r \230\136\150 |cff00ff00%s|r - %s"
L[ [=[  Achievement Points
]=] ] = [=[  \230\136\144\229\176\177\233\187\158\230\149\184
]=]
L[ [=[  Conquest Points
]=] ] = [=[  \229\190\129\230\156\141\233\187\158\230\149\184
]=]
L[ [=[  Honor Points
]=] ] = [=[  \230\166\174\232\173\189\233\187\158\230\149\184
]=]
L[ [=[  Justice Points
]=] ] = [=[  \230\173\163\231\190\169\233\187\158\230\149\184
]=]
L[ [=[  Valor Points
]=] ] = [=[  \229\139\135\230\176\163\233\187\158\230\149\184
]=]
--[[Translation missing --]]
L[" %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"] = " %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"
L[" |cFFff5a00(Upgrade)|r"] = " |cFFff5a00(\229\141\135\231\180\154)|r"
L[" |cffffff00%d|r Total Modules (|cff00ff00%d|r Enabled, |cffff0000%d|r Disabled)"] = "\231\184\189\229\133\177 |cffffff00%d|r \229\128\139\230\168\161\231\181\132 (|cff00ff00%d|r \229\183\178\229\149\159\231\148\168, |cffff0000%d|r \229\183\178\229\129\156\231\148\168)"
L[" isn't a number."] = " \228\184\141\230\152\175\228\184\128\229\128\139\230\149\184\229\173\151."
L[" isn't a recognized variable or number."] = " \228\184\141\230\152\175\228\184\128\229\128\139\229\143\175\232\190\168\232\173\152\231\154\132\232\174\138\230\149\184\230\136\150\230\149\184\229\173\151."
L[ [=[

|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.]=] ] = [=[

|cffff0000\230\143\144\231\164\186:|r  \229\166\130\230\158\156\230\173\164UI\233\150\139\229\167\139\228\189\191\231\148\168\229\164\167\233\135\143\231\154\132\232\168\152\230\134\182\233\171\148, \229\143\170\232\166\129\233\135\141\231\189\174\229\144\141\231\168\177\232\179\135\230\150\153\229\141\179\230\156\131\229\155\158\229\190\169.]=]
L[ [=[

|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.

Addon Usage: |cff00ff00%s|r]=] ] = [=[

|cffff0000\230\143\144\231\164\186:|r  \229\166\130\230\158\156\230\173\164UI\233\150\139\229\167\139\228\189\191\231\148\168\229\164\167\233\135\143\231\154\132\232\168\152\230\134\182\233\171\148, \229\143\170\232\166\129\233\135\141\231\189\174\229\144\141\231\168\177\232\179\135\230\150\153\229\141\179\230\156\131\229\155\158\229\190\169.

\230\143\146\228\187\182\228\189\191\231\148\168\230\150\185\230\179\149: |cff00ff00%s|r]=]
--[[Translation missing --]]
L["$EMPTY$"] = "$EMPTY$"
--[[Translation missing --]]
L["% Owned"] = "% Owned"
--[[Translation missing --]]
L["% Unowned"] = "% Unowned"
L[ [=[%s  Conquest Cap
]=] ] = true
L[ [=[%s  Justice Cap
]=] ] = true
L[ [=[%s  Valor Cap
]=] ] = true
L["%s or %s"] = true
L["%s reputation left until %s with %s."] = true
L["%s reputation needed until %s with %s."] = true
L[ [=[%s, %s, %s  Player's Money
]=] ] = true
L[ [=[%s, %s, %s  Player's Stats
]=] ] = true
--[[Translation missing --]]
L["%sChat Tweaks|r"] = "%sChat Tweaks|r"
--[[Translation missing --]]
L["%sElvUI Chat Tweaks|r by |cff0070deCrackpotx|r"] = "%sElvUI Chat Tweaks|r by |cff0070deCrackpotx|r"
--[[Translation missing --]]
L["(|HBNplayer.-|h): whispers:"] = "(|HBNplayer.-|h): whispers:"
--[[Translation missing --]]
L["(|Hplayer.-|h) says:"] = "(|Hplayer.-|h) says:"
--[[Translation missing --]]
L["(|Hplayer.-|h) whispers:"] = "(|Hplayer.-|h) whispers:"
L[", removing from list"] = true
L["/tt"] = true
--[[Translation missing --]]
L["|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"] = "|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"
--[[Translation missing --]]
L["|cff00ff00%d|r Custom %s Being Used"] = "|cff00ff00%d|r Custom %s Being Used"
L["|cff00ff00%s|r"] = true
--[[Translation missing --]]
L["|cff00ff00%s|r %s"] = "|cff00ff00%s|r %s"
L["|cff00ff00%s|r or |cff00ff00%s|r %s"] = "|cff00ff00%s|r \230\136\150 |cff00ff00%s|r %s"
--[[Translation missing --]]
L["|cff00ff00%s|r or |cff00ff00%s|r or |cff00ff00%s|r"] = "|cff00ff00%s|r or |cff00ff00%s|r or |cff00ff00%s|r"
L["|cff00ff00Enabled|r"] = "|cff00ff00\229\183\178\229\149\159\231\148\168|r"
--[[Translation missing --]]
L["|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r"] = "|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r"
--[[Translation missing --]]
L["|cFF5cb4f8Pet Battle - Tale of the Tape|r"] = "|cFF5cb4f8Pet Battle - Tale of the Tape|r"
L["|cffc7c7cfs|r"] = true
L["|cFFccff00Not Owned|r"] = "|cFFccff00\229\176\154\230\156\170\230\147\129\230\156\137|r"
L["|cffeda55fc|r"] = true
L["|cffff0000Disabled|r"] = "|cffff0000\229\183\178\229\129\156\231\148\168|r"
L["|cffff0000Item|r |cffffffff\"%s\"|r |cffff0000does not exist.|r"] = "|cffff0000\231\137\169\229\147\129|r |cffffffff\"%s\"|r |cffff0000\228\184\141\229\173\152\229\156\168.|r"
L["|cffff0000No modules found.|r"] = "|cffff0000\230\137\190\228\184\141\229\136\176\230\168\161\231\181\132.|r"
L["|cffff0000The Chat Frame you chose to output reputation changes,|r |cffffffff%s|r|cffff0000, does not exist."] = "|cffff0000\228\189\160\233\129\184\230\147\135\233\161\175\231\164\186\232\129\178\230\156\155\232\174\138\229\140\150\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151,|r |cffffffff%s|r|cffff0000, \228\184\141\229\173\152\229\156\168."
L["|cffff9000Not in Pet Journal|r"] = "|cffff9000\228\184\141\229\156\168\229\175\181\231\137\169\230\151\165\232\170\140\228\184\173|r"
L["|cffff9000Pet Journal:|r %s"] = "|cffff9000\229\175\181\231\137\169\230\151\165\232\170\140:|r %s"
--[[Translation missing --]]
L["|cffffc080Alts:|r %s"] = "|cffffc080Alts:|r %s"
L["|cffffd700g|r"] = true
L["|cffffff00Character already in a guild."] = "|cffffff00\232\167\146\232\137\178\229\183\178\229\156\168\228\184\128\229\128\139\229\133\172\230\156\131\228\184\173."
L["|cffffff00Character already in your guild."] = "|cffffff00\232\167\146\232\137\178\229\183\178\229\156\168\228\189\160\231\154\132\229\133\172\230\156\131."
--[[Translation missing --]]
L["|cffffff00This abbreviation is unknown."] = "|cffffff00This abbreviation is unknown."
L["|cffffff00Unable to execute secure command.|r |cffffffff%s|r"] = "|cffffff00\231\132\161\230\179\149\229\159\183\232\161\140\229\174\137\229\133\168\230\140\135\228\187\164.|r |cffffffff%s|r"
--[[Translation missing --]]
L["|cffffff00Usage: /ccolor <class>|r"] = "|cffffff00Usage: /ccolor <class>|r"
--[[Translation missing --]]
L["|cffffff00Usage: /fake <id or link> <date in MM/DD/YY format>|r"] = "|cffffff00Usage: /fake <id or link> <date in MM/DD/YY format>|r"
L["|cffffff00Usage: /ginvite <name>|r"] = "|cffffff00Usage: /ginvite <\229\144\141\229\173\151>|r"
L["|cffffff00Usage: /gkick <name>|r"] = "|cffffff00\231\148\168\230\179\149: /gkick <\229\144\141\229\173\151>|r"
--[[Translation missing --]]
L["|cffffff00Usage: /hextorgb <hex code>|r"] = "|cffffff00Usage: /hextorgb <hex code>|r"
L["|cffffff00Usage: /in <delay> <command>|r"] = "|cffffff00Usage: /in <\229\187\182\233\129\178> <\230\140\135\228\187\164>|r"
--[[Translation missing --]]
L["|cffffff00Usage: /rgbtohex <red> <green> <blue>|r"] = "|cffffff00Usage: /rgbtohex <red> <green> <blue>|r"
L["|cffffff00Usage: /rpt <times> <command>|r"] = "|cffffff00Usage: /rpt <\230\172\161\230\149\184> <\230\140\135\228\187\164>|r"
L["|cffffffffYou have %s.|r"] = "|cffffffff\228\189\160\230\156\137 %s.|r"
--[[Translation missing --]]
L["<ElvUI_CTC>"] = "<ElvUI_CTC>"
--[[Translation missing --]]
L["<no location>"] = "<no location>"
--[[Translation missing --]]
L["<notarget>"] = "<notarget>"
L[ [=[A simple calculator used to perform basic operations on gold values.  Providing no parameters will show you how much gold you have.

You can include your current gold amount by using the |cff00ff00mymoney|r keyword.  For example |cff00ff00mymoney * 2|r.

|cffff0000Money amounts can only be added or subtracted, multiplication or division can only be performed with money and a number.  For example:  4g * 4 is okay, where 4g * 4g is invalid.]=] ] = [=[\228\184\128\229\128\139\231\176\161\229\150\174\231\154\132\232\168\136\231\174\151\230\169\159\228\190\134\233\128\178\232\161\140\231\176\161\229\150\174\231\154\132\233\135\145\233\140\162\232\168\136\231\174\151. \229\166\130\230\158\156\230\178\146\230\156\137\230\143\144\233\151\156\229\143\131\230\149\184\230\153\130\230\156\131\233\161\175\231\164\186\228\189\160\230\137\128\230\147\129\230\156\137\231\154\132\233\135\145\233\140\162

\228\189\160\229\143\175\228\187\165\228\189\191\231\148\168 |cff00ff00mymoney|r \233\151\156\233\141\181\229\173\151\228\190\134\229\143\150\229\190\151\228\189\160\231\155\174\229\137\141\231\154\132\233\135\145\233\140\162\230\149\184\233\135\143.  \232\136\137\228\190\139 |cff00ff00mymoney * 2|r.

|cffff0000\229\140\133\229\144\171\229\150\174\228\189\141\231\154\132\230\149\184\233\135\143\229\143\170\232\131\189\229\129\154\229\138\160\230\179\149\229\146\140\230\184\155\230\179\149, \228\185\152\230\179\149\229\146\140\233\153\164\230\179\149\229\143\170\232\131\189\228\189\191\231\148\168\229\156\168\233\135\145\233\140\162\232\136\135\228\184\128\229\128\139\230\149\184\229\173\151\231\154\132\231\174\151\229\188\143.  \232\136\137\228\190\139:  4g * 4 \230\152\175\229\143\175\228\187\165\231\148\168\231\154\132, \228\189\134\230\152\175 4g * 4g \230\152\175\228\184\141\229\144\136\230\179\149\231\154\132.]=]
L[ [=[A simple command-line calculator.  Certain keywords, listed below, can be used and their in game value will be substituted.  You can also assign variables which are saved for later use.

|cffffff00Keywords:|r
]=] ] = [=[\228\184\128\229\128\139\231\176\161\229\150\174\231\154\132\229\176\141\232\169\177\229\188\143\232\168\136\231\174\151\230\169\159.  \229\186\149\228\184\139\230\137\128\229\136\151\231\154\132\233\151\156\233\141\181\229\173\151, \229\143\175\228\187\165\232\162\171\228\189\191\231\148\168\228\184\166\228\184\148\230\156\131\230\155\191\230\143\155\230\136\144\229\133\182\229\156\168\233\129\138\230\136\178\228\184\173\231\154\132\230\149\184\229\128\188.  \228\189\160\228\185\159\229\143\175\228\187\165\230\140\135\229\174\154\232\174\138\230\149\184\228\184\166\229\173\152\232\181\183\228\190\134\228\187\165\228\190\155\228\187\165\229\190\140\228\189\191\231\148\168.

|cffffff00\233\151\156\233\141\181\229\173\151:|r
]=]
--[[Translation missing --]]
L["A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears."] = "A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears."
--[[Translation missing --]]
L["A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r."] = "A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r."
--[[Translation missing --]]
L["A Test of Valor"] = "A Test of Valor"
--[[Translation missing --]]
L["Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN."] = "Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN."
--[[Translation missing --]]
L["Abbreviations"] = "Abbreviations"
L["achieve"] = true
L["Achievement Filter"] = "\230\136\144\229\176\177\233\129\142\230\191\190"
--[[Translation missing --]]
L["Achievement for %s%s|r: %s"] = "Achievement for %s%s|r: %s"
L["Achievement Messages"] = "\230\136\144\229\176\177\232\168\138\230\129\175"
--[[Translation missing --]]
L["Activate in 5-man instances."] = "Activate in 5-man instances."
--[[Translation missing --]]
L["Activate in guild."] = "Activate in guild."
--[[Translation missing --]]
L["Active in your selected community"] = "Active in your selected community"
--[[Translation missing --]]
L["Active Modules"] = "Active Modules"
L["Add |cff00ff00/emotes|r Command"] = "\230\150\176\229\162\158 |cff00ff00/emotes|r \230\140\135\228\187\164"
L["Add an |cff00ff00/emotes|r command to see what custom emotes you currently have running."] = "\230\150\176\229\162\158\228\184\128\229\128\139 |cff00ff00/emotes|r \230\140\135\228\187\164\228\190\134\231\156\139\231\156\139\228\189\160\231\143\190\229\156\168\230\173\163\229\156\168\228\189\191\231\148\168\231\154\132\232\161\168\230\131\133."
L[ [=[Add custom emotes.  Please remember that your character's name will always be the first word.

|cff00ff00%t|r is your current target.]=] ] = true
--[[Translation missing --]]
L["Add custom names to the chat messages in this custom channel."] = "Add custom names to the chat messages in this custom channel."
--[[Translation missing --]]
L["Add custom names to the guild chat messages. (also include officer chat)."] = "Add custom names to the guild chat messages. (also include officer chat)."
--[[Translation missing --]]
L["Add custom names to the instance chat messages, e.g., LFR and battlegrounds."] = "Add custom names to the instance chat messages, e.g., LFR and battlegrounds."
--[[Translation missing --]]
L["Add custom names to the party chat messages."] = "Add custom names to the party chat messages."
--[[Translation missing --]]
L["Add custom names to the raid chat messages."] = "Add custom names to the raid chat messages."
L["Add Group Trigger"] = "\230\150\176\229\162\158\231\181\132\233\154\138\233\151\156\233\141\181\229\173\151"
L["Add Guild Trigger"] = "\230\150\176\229\162\158\229\133\172\230\156\131\233\151\156\233\141\181\229\173\151"
L["Add item icons to loot received messages."] = "\229\156\168\230\136\176\229\136\169\229\147\129\232\168\138\230\129\175\229\137\141\229\162\158\229\138\160\231\137\169\229\147\129\229\156\150\231\164\186."
--[[Translation missing --]]
L["Add Percentage"] = "Add Percentage"
--[[Translation missing --]]
L["Add space after channels"] = "Add space after channels"
L["Add surrounding brackets to own charname in messages."] = "\229\156\168\228\189\160\230\147\129\230\156\137\231\154\132\232\167\146\232\137\178\229\144\141\231\168\177\229\138\160\228\184\138\230\139\172\229\188\167."
--[[Translation missing --]]
L["Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it."] = "Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it."
--[[Translation missing --]]
L["Add the player's alts to the tooltip."] = "Add the player's alts to the tooltip."
--[[Translation missing --]]
L["Add the player's main to the tooltip."] = "Add the player's main to the tooltip."
L["Add word to your group invite trigger list"] = "\230\150\176\229\162\158\233\151\156\233\141\181\229\173\151\229\136\176\232\135\170\229\139\149\231\181\132\233\154\138\230\184\133\229\150\174"
L["Add word to your guild invite trigger list."] = "\230\150\176\229\162\158\233\151\156\233\141\181\229\173\151\229\136\176\232\135\170\229\139\149\233\130\128\232\171\139\229\133\172\230\156\131\230\184\133\229\150\174."
--[[Translation missing --]]
L["Addon enabled, but no message or channels selected."] = "Addon enabled, but no message or channels selected."
--[[Translation missing --]]
L["Addon Messages"] = "Addon Messages"
L["Addon Version Sent, Version: |cffffff00%s|r"] = "\230\143\146\228\187\182\231\137\136\230\156\172\233\128\129\229\135\186, \231\137\136\230\156\172: |cffffff00%s|r"
--[[Translation missing --]]
L["Adds a |cff00ff00/fake|r command for generating fake achievements."] = "Adds a |cff00ff00/fake|r command for generating fake achievements."
--[[Translation missing --]]
L[ [=[Adds a gamemenu button.

|cffffff00To disable the button, simply disable this module.

Please do a full reload after disable or enable.|r]=] ] = [=[Adds a gamemenu button.

|cffffff00To disable the button, simply disable this module.

Please do a full reload after disable or enable.|r]=]
--[[Translation missing --]]
L[ [=[Adds a minimap button.

|cffffff00To disable the button, simply disable this module.|r]=] ] = [=[Adds a minimap button.

|cffffff00To disable the button, simply disable this module.|r]=]
L["Adds a timestamp to each line of text."] = "\230\175\143\232\161\140\229\162\158\229\138\160\230\153\130\233\150\147\230\136\179\232\168\152\227\128\130"
--[[Translation missing --]]
L["Adds an ElvUI datatext for this addon."] = "Adds an ElvUI datatext for this addon."
L["Adds chat commands |cff1784d1/chatframes|r and |cff1784d1/cf|r to help you identify the chat frames and their numbers."] = "\230\150\176\229\162\158\229\176\141\232\169\177\230\140\135\228\187\164 |cff1784d1/chatframes|r \229\146\140 |cff1784d1/cf|r \228\190\134\229\185\171\229\138\169\228\189\160\232\190\168\229\136\165\229\176\141\232\169\177\232\166\150\231\170\151\232\153\159\231\162\188."
L[ [=[Adds chat commands to clear the chat windows.

]=] ] = [=[\230\150\176\229\162\158\230\184\133\233\153\164\229\176\141\232\169\177\232\166\150\231\170\151\231\154\132\229\176\141\232\169\177\230\140\135\228\187\164\227\128\130

]=]
--[[Translation missing --]]
L[ [=[Adds chat commands to show the current server token price in the chat windows.

]=] ] = [=[Adds chat commands to show the current server token price in the chat windows.

]=]
L[ [=[Adds item links to Auction House messages.  Enabling this module will automatically disable the Auction Message Filter module.

|cffff0000If you do not have the item in your bags at the time of the system message firing then this will not be able to get the item link.  This is a limitation of the|r |cffffff00GetItemInfo()|r |cffff0000API function.  If this occurs, then the module will simple pass through the default message.|r]=] ] = [=[\230\150\176\229\162\158\231\137\169\229\147\129\233\128\163\231\181\144\232\135\179\230\139\141\232\179\163\229\160\180\232\168\138\230\129\175.  \229\149\159\229\139\149\230\173\164\230\168\161\231\181\132\230\156\131\232\135\170\229\139\149\229\129\156\231\148\168\230\139\141\232\179\163\232\168\138\230\129\175\233\129\142\230\191\190\230\168\161\231\181\132.

|cffff0000\229\129\135\228\189\191\232\168\138\230\129\175\232\167\184\231\153\188\230\153\130\228\189\160\231\154\132\232\131\140\229\140\133\229\133\167\230\178\146\230\156\137\232\169\178\231\137\169\229\147\129\239\188\140\229\137\135\231\132\161\230\179\149\231\148\162\231\148\159\231\137\169\229\147\129\233\128\163\231\181\144.  \233\128\153\230\152\175|r |cffffff00GetItemInfo()|r |cffff0000API \231\154\132\233\153\144\229\136\182.  \229\129\135\229\166\130\233\128\153\231\139\128\230\179\129\231\153\188\231\148\159\239\188\140\230\173\164\230\168\161\231\181\132\230\156\131\231\155\180\230\142\165\233\161\175\231\164\186\229\142\159\230\156\172\231\154\132\232\168\138\230\129\175.|r]=]
--[[Translation missing --]]
L["Adds itemlevel to linked items in chat messages."] = "Adds itemlevel to linked items in chat messages."
L["Adds tell target slash command, |cff00ff00/tt|r."] = "\230\150\176\229\162\158\229\175\134\232\170\158\231\155\174\230\168\153\229\176\141\232\177\161\230\140\135\228\187\164, |cff00ff00/tt|r."
--[[Translation missing --]]
L[ [=[Adds the |cff00ff96/find|r and |cff00ff96/findall|r commands to search the chat history.

Usage:
    |cff00ff96/find <text>|r
    |cff00ff96/findall <text>|r]=] ] = [=[Adds the |cff00ff96/find|r and |cff00ff96/findall|r commands to search the chat history.

Usage:
    |cff00ff96/find <text>|r
    |cff00ff96/findall <text>|r]=]
--[[Translation missing --]]
L["Adds the |cff00ff96/role|r command for initiating a role poll in raids."] = "Adds the |cff00ff96/role|r command for initiating a role poll in raids."
--[[Translation missing --]]
L["Adds the chat commands |cff00ff96/zonelist|r, |cff00ff96/pets|r and |cff00ff96/mounts|r to provide information about your mounts and pets."] = "Adds the chat commands |cff00ff96/zonelist|r, |cff00ff96/pets|r and |cff00ff96/mounts|r to provide information about your mounts and pets."
L["AFK"] = "\230\154\171\233\155\162"
L["AFK Messages"] = "\230\154\171\233\155\162\232\168\138\230\129\175"
L["AFK/DND Filter"] = "\230\154\171\233\155\162/\229\139\191\230\147\190 \233\129\142\230\191\190"
L["After"] = "\228\185\139\229\190\140"
--[[Translation missing --]]
L["against"] = "against"
L["Alchemy"] = "\231\133\137\233\135\145\232\161\147"
L["All"] = true
--[[Translation missing --]]
L["All Modules"] = "All Modules"
--[[Translation missing --]]
L["AllCommunity"] = "AllCommunity"
--[[Translation missing --]]
L["Allow guild synchronization"] = "Allow guild synchronization"
L["Allow someone to request a link of all your professions."] = "\229\133\129\232\168\177\229\133\182\228\187\150\228\186\186\232\166\129\230\177\130\228\189\160\230\137\128\230\156\137\228\186\164\230\152\147\230\138\128\232\131\189\231\154\132\233\128\163\231\181\144."
L[ [=[Allows you to change the default font settings for the chat frames.

|cffff0000Using another addon to do this will break this functionality.|r]=] ] = [=[\229\133\129\232\168\177\228\189\160\230\155\180\230\148\185\233\160\144\232\168\173\229\176\141\232\169\177\232\166\150\231\170\151\229\173\151\229\158\139.

|cffff0000\229\166\130\230\158\156\228\189\191\231\148\168\229\133\182\228\187\150\231\155\184\229\144\140\229\138\159\232\131\189\230\143\146\228\187\182\230\156\131\231\160\180\229\163\158\230\173\164\229\138\159\232\131\189.|r]=]
--[[Translation missing --]]
L["Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command."] = "Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command."
L[ [=[Allows you to color the pet battle info messages, and determine which chat frame to send them to.

I am aware that some of the features of this module don't really pertain to the chat, but I couldn't really justify an entirely new addon.  So I just snuck them into here.]=] ] = [=[\228\184\138\232\137\178\229\175\181\231\137\169\230\136\176\233\172\165\232\179\135\232\168\138\239\188\140\228\184\166\230\177\186\229\174\154\232\166\129\233\161\175\231\164\186\229\156\168\229\147\170\229\128\139\229\176\141\232\169\177\232\166\150\231\170\151.

\230\136\145\231\159\165\233\129\147\233\128\153\230\168\161\231\181\132\231\154\132\228\184\128\228\186\155\229\138\159\232\131\189\232\183\159\229\176\141\232\169\177\231\132\161\233\151\156, \228\189\134\230\152\175\230\136\145\231\156\159\231\154\132\231\132\161\230\179\149\232\173\137\230\152\142\228\187\150\230\152\175\228\184\128\229\128\139\230\150\176\231\154\132\230\143\146\228\187\182.  \230\137\128\228\187\165\230\136\145\229\129\183\229\129\183\231\154\132\230\138\138\229\174\131\230\148\190\229\156\168\233\128\153.]=]
L["Allows you to reroute auction house messages to a different chat frame."] = "\229\133\129\232\168\177\228\189\160\229\176\135\230\139\141\232\179\163\229\160\180\232\168\138\230\129\175\233\135\141\229\153\181\229\136\176\229\136\165\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151."
--[[Translation missing --]]
L[ [=[Allows you to use some fun filters on various chat channels.

|cffff0000This will break any links in the chat message.|r

|cffffff00Filters:|r
13375p34|<, ALL UPPERCASE, all lowercase, Capitalize Words, AlTeRnAtInG CaPs, BeTTeR ALTeRNaTiNG CaPS, sretteL esreveR, Gràvè Lèttèrs, Ácúté Léttérs, Ðïärësïs Lëttërs, Cîrcûmflêx Lêttêrs]=] ] = [=[Allows you to use some fun filters on various chat channels.

|cffff0000This will break any links in the chat message.|r

|cffffff00Filters:|r
13375p34|<, ALL UPPERCASE, all lowercase, Capitalize Words, AlTeRnAtInG CaPs, BeTTeR ALTeRNaTiNG CaPS, sretteL esreveR, Gr\195\160v\195\168 L\195\168tt\195\168rs, \195\129c\195\186t\195\169 L\195\169tt\195\169rs, \195\144\195\175\195\164r\195\171s\195\175s L\195\171tt\195\171rs, C\195\174rc\195\187mfl\195\170x L\195\170tt\195\170rs]=]
--[[Translation missing --]]
L["Alt + Left Click"] = "Alt + Left Click"
--[[Translation missing --]]
L["Alt + Right Click"] = "Alt + Right Click"
L["Alt Names"] = "\229\136\134\232\186\171\229\167\147\229\144\141"
L["Alt note fallback"] = "\229\136\134\232\186\171\232\168\187\232\168\152\229\155\158\233\165\139"
L["alt2"] = "\229\136\134\232\186\1712"
L["alt3"] = "\229\136\134\232\186\1713"
L["Alt-click name to invite"] = "ALT+\229\183\166\233\141\181\233\187\158\233\129\184\229\167\147\229\144\141\233\130\128\232\171\139"
L["Alternate command to kick someone from guild."] = "\228\184\128\229\128\139\230\155\191\228\187\163\231\154\132\230\140\135\228\187\164\228\190\134\229\176\135\230\159\144\228\186\186\232\184\162\229\135\186\229\133\172\230\156\131."
--[[Translation missing --]]
L["AlTeRnAtInG CaPs"] = "AlTeRnAtInG CaPs"
--[[Translation missing --]]
L["Always"] = "Always"
--[[Translation missing --]]
L["Always set your DND status while announcing to channels"] = "Always set your DND status while announcing to channels"
--[[Translation missing --]]
L["and"] = "and"
--[[Translation missing --]]
L["Announce in chat who taunted."] = "Announce in chat who taunted."
--[[Translation missing --]]
L["Announce interval, minutes"] = "Announce interval, minutes"
--[[Translation missing --]]
L["Announce settings"] = "Announce settings"
--[[Translation missing --]]
L["Announce to General"] = "Announce to General"
--[[Translation missing --]]
L["Announce to LFG"] = "Announce to LFG"
--[[Translation missing --]]
L["Announce to Trade"] = "Announce to Trade"
--[[Translation missing --]]
L["Announce your message to city trade channel."] = "Announce your message to city trade channel."
--[[Translation missing --]]
L["Announce your message to General channel when out of a city."] = "Announce your message to General channel when out of a city."
--[[Translation missing --]]
L["Announce your message to LFG channel."] = "Announce your message to LFG channel."
--[[Translation missing --]]
L["Announcements"] = "Announcements"
--[[Translation missing --]]
L["Announcing to General channel. Trade: %d LFG: %d"] = "Announcing to General channel. Trade: %d LFG: %d"
--[[Translation missing --]]
L["Announcing to LFG channel. Trade: %d LFG: %d"] = "Announcing to LFG channel. Trade: %d LFG: %d"
--[[Translation missing --]]
L["Announcing to Trade channel. Trade: %d LFG: %d"] = "Announcing to Trade channel. Trade: %d LFG: %d"
--[[Translation missing --]]
L["Anounce AOE Taunts"] = "Anounce AOE Taunts"
--[[Translation missing --]]
L["Anounce AOE Taunts Output:"] = "Anounce AOE Taunts Output:"
--[[Translation missing --]]
L["Anounce AOE Taunts."] = "Anounce AOE Taunts."
--[[Translation missing --]]
L["Anounce Fails"] = "Anounce Fails"
--[[Translation missing --]]
L["Anounce Fails Output:"] = "Anounce Fails Output:"
--[[Translation missing --]]
L["Anounce Taunts"] = "Anounce Taunts"
--[[Translation missing --]]
L["Anounce Taunts Output:"] = "Anounce Taunts Output:"
--[[Translation missing --]]
L["Anounce taunts that fail."] = "Anounce taunts that fail."
--[[Translation missing --]]
L["Anounce taunts."] = "Anounce taunts."
--[[Translation missing --]]
L["AOE"] = "AOE"
L["ap"] = true
L["Are you sure you want to delete all your saved class/level data?"] = "\228\189\160\231\162\186\229\174\154\228\189\160\232\166\129\229\136\170\233\153\164\230\137\128\230\156\137\228\189\160\231\180\128\233\140\132\231\154\132 \232\129\183\230\165\173/\231\173\137\231\180\154 \232\179\135\230\150\153?"
--[[Translation missing --]]
L["Are you sure you want to disable all of the modules?"] = "Are you sure you want to disable all of the modules?"
--[[Translation missing --]]
L["Are you sure you want to enable all of the modules?"] = "Are you sure you want to enable all of the modules?"
L["Are you sure you want to reset the chat fonts to defaults?"] = "\228\189\160\231\162\186\229\174\154\228\189\160\232\166\129\233\135\141\231\189\174\229\176\141\232\169\177\229\173\151\229\158\139\231\130\186\233\160\144\232\168\173\229\128\188?"
--[[Translation missing --]]
L["As I see it, yes."] = "As I see it, yes."
--[[Translation missing --]]
L["Ask again later."] = "Ask again later."
--[[Translation missing --]]
L["Auction Created"] = "Auction Created"
L["Auction Expired"] = "\230\139\141\232\179\163\229\147\129\233\129\142\230\156\159"
L["Auction Message Filtering"] = "\230\139\141\232\179\163\232\168\138\230\129\175\233\129\142\230\191\190"
L["Auction Message Types"] = "\230\139\141\232\179\163\232\168\138\230\129\175\231\168\174\233\161\158"
L["Auction Outbid"] = "\230\139\141\232\179\163\229\147\129\230\144\182\230\168\153"
L["Auction Removed"] = "\230\139\141\232\179\163\229\147\129\231\167\187\233\153\164"
L["Auction Sold"] = "\230\139\141\232\179\163\229\147\129\229\148\174\229\135\186"
L["Auction Won"] = "\232\180\143\229\190\151\230\139\141\232\179\163\229\147\129"
L["Auto Congratulate"] = "\232\135\170\229\139\149\230\129\173\232\179\128"
L["Auto Ding"] = "\232\135\170\229\139\149 Ding"
L["Auto Farewell"] = "\232\135\170\229\139\149\233\129\147\229\136\165"
L["Auto Profession Link"] = "\232\135\170\229\139\149\230\143\144\228\190\155\228\186\164\230\152\147\230\138\128\232\131\189"
--[[Translation missing --]]
L["Auto Set Role"] = "Auto Set Role"
L["Auto Welcome"] = "\232\135\170\229\139\149\230\173\161\232\191\142"
L["Automatic Chat Logging"] = "\232\135\170\229\139\149\228\191\157\229\173\152\229\176\141\232\169\177\232\168\152\233\140\132"
L["Automatically bid someone farewell when they leave your guild."] = "\231\149\182\230\159\144\228\186\186\233\155\162\233\150\139\229\133\172\230\156\131\230\153\130\232\135\170\229\139\149\233\129\147\229\136\165."
L["Automatically congratulate someone when they, or others, complete an achievement."] = "\231\149\182\229\133\182\228\187\150\228\186\186\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\232\135\170\229\139\149\230\129\173\232\179\128."
L["Automatically congratulates someone when they say \"ding\" in chat."] = "\231\149\182\230\159\144\228\186\186\229\156\168\229\176\141\232\169\177\228\184\173\232\170\170 \"ding\" \230\153\130\232\135\170\229\139\149\229\155\158\230\135\137."
--[[Translation missing --]]
L["Automatically enable tracking of pets for battles."] = "Automatically enable tracking of pets for battles."
--[[Translation missing --]]
L["Automatically enable tracking of Stable Masters to help you revive and/or heal your pets."] = "Automatically enable tracking of Stable Masters to help you revive and/or heal your pets."
L["Automatically enables chat logging."] = "\232\135\170\229\139\149\229\149\159\231\148\168\229\176\141\232\169\177\231\180\128\233\140\132"
L["Automatically link someone the profession they requested via various keywords."] = "\232\135\170\229\139\149\230\160\185\230\147\154\233\151\156\233\141\181\229\173\151\230\143\144\228\190\155\230\159\144\228\186\186\228\187\150\229\128\145\232\166\129\230\177\130\231\154\132\228\186\164\230\152\147\230\138\128\232\131\189\233\128\163\231\181\144."
L["Automatically Remove Item When Finished"] = "\231\149\182\231\137\169\229\147\129\229\174\140\230\136\144\230\153\130\232\135\170\229\139\149\231\167\187\233\153\164"
L["Automatically welcomes someone to your guild."] = "\231\149\182\230\156\137\228\186\186\229\138\160\229\133\165\229\133\172\230\156\131\230\153\130\232\135\170\229\139\149\230\173\161\232\191\142."
L["Available Chat Command Arguments"] = "\229\143\175\231\148\168\231\154\132\229\176\141\232\169\177\230\140\135\228\187\164\229\143\131\230\149\184"
--[[Translation missing --]]
L["Available communities"] = "Available communities"
L["Available parameters are |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."] = "\229\143\175\231\148\168\231\154\132\229\143\131\230\149\184\229\140\133\230\139\172 |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."
--[[Translation missing --]]
L["Battle.Net Convo"] = "Battle.Net Convo"
L["Battle.Net Options"] = "Battle.Net \233\129\184\233\160\133"
--[[Translation missing --]]
L["Battle.Net Whisper"] = "Battle.Net Whisper"
L["Before"] = "\228\185\139\229\137\141"
--[[Translation missing --]]
L["Below are the keywords that the module will look for to substitute with the values described below."] = "Below are the keywords that the module will look for to substitute with the values described below."
--[[Translation missing --]]
L["BeTTeR ALTeRNaTiNG CaPS"] = "BeTTeR ALTeRNaTiNG CaPS"
--[[Translation missing --]]
L["Better not tell you now."] = "Better not tell you now."
L["Bid Accepted"] = "\229\135\186\229\131\185\230\142\165\229\143\151"
L["Blacksmithing"] = "\233\141\155\233\128\160"
--[[Translation missing --]]
L["Bloodlust Announce"] = "Bloodlust Announce"
--[[Translation missing --]]
L["Bloodlust Announce is disabled, locate it under |cfff960d9KlixUI|r settings instead."] = "Bloodlust Announce is disabled, locate it under |cfff960d9KlixUI|r settings instead."
L["Build Date: |cff1784d1%s|r"] = "\231\181\132\229\187\186\230\151\165\230\156\159: |cff1784d1%s|r"
L["Build: |cff1784d1%s|r"] = "\231\181\132\229\187\186: |cff1784d1%s|r"
L["Busy"] = "\229\191\153\231\162\140"
L["Calculator"] = "\232\168\136\231\174\151\230\169\159"
--[[Translation missing --]]
L["Cannot predict now."] = "Cannot predict now."
L["Can't set value '%s', doesn't look like a number."] = "\231\132\161\230\179\149\232\168\173\229\174\154\230\149\184\229\128\188 '%s', \231\156\139\232\181\183\228\190\134\228\184\141\229\131\143\230\152\175\229\128\139\230\149\184\229\173\151."
--[[Translation missing --]]
L["Capitalize Words"] = "Capitalize Words"
--[[Translation missing --]]
L["Capture Delay"] = "Capture Delay"
L["Center"] = "\231\189\174\228\184\173"
L["Changed Channel"] = "\232\174\138\230\155\180\233\160\187\233\129\147"
L["Channel"] = "\233\160\187\233\129\147"
L["Channel %d"] = "\233\160\187\233\129\147 %d"
L["Channel Colors"] = "\233\160\187\233\129\147\233\161\143\232\137\178"
--[[Translation missing --]]
L["Channel Names"] = "Channel Names"
L["Channel Notice Filter"] = "\233\160\187\233\129\147\230\143\144\233\134\146\233\129\142\230\191\190"
L["Channel Sounds"] = "\233\160\187\233\129\147\233\159\179\230\149\136"
--[[Translation missing --]]
L["Channel to send the reminder to."] = "Channel to send the reminder to."
L["Channels"] = "\233\160\187\233\129\147"
--[[Translation missing --]]
L["Channels to Filter"] = "Channels to Filter"
--[[Translation missing --]]
L["Channels to look for questions."] = "Channels to look for questions."
L["Channels to Monitor"] = "\231\155\163\232\166\150\233\160\187\233\129\147"
--[[Translation missing --]]
L["Channels to Watch"] = "Channels to Watch"
L["Character to use between the name and level"] = "\229\144\141\231\168\177\232\136\135\231\173\137\231\180\154\233\150\147\233\154\148\229\173\151\229\133\131"
L["Character to use for the left bracket"] = "\229\183\166\230\139\172\229\188\167\229\173\151\229\133\131"
L["Character to use for the right bracket"] = "\229\143\179\230\139\172\229\188\167\229\173\151\229\133\131"
--[[Translation missing --]]
L["Chat Events"] = "Chat Events"
L["Chat Fonts"] = "\229\176\141\232\169\177\229\173\151\229\158\139"
L["Chat Frame "] = "\229\176\141\232\169\177\232\166\150\231\170\151 "
L["Chat Frame"] = "\229\176\141\232\169\177\232\166\150\231\170\151"
L["Chat Frame %d"] = "\229\176\141\232\169\177\232\166\150\231\170\151 %d"
L["Chat Frame Settings"] = "\229\176\141\232\169\177\232\166\150\231\170\151\232\168\173\229\174\154"
L["Chat frame to output the message to.  Default is |cffffff00ChatFrame3|r, which is the default frame for ElvUI XP messages."] = "\232\188\184\229\135\186\232\168\138\230\129\175\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151.  \233\160\144\232\168\173\231\130\186 |cffffff00\229\176\141\232\169\177\232\166\150\231\170\1513|r, \230\152\175 ElvUI \233\160\144\232\168\173\231\154\132\232\129\178\230\156\155\232\168\138\230\129\175\232\188\184\229\135\186\232\166\150\231\170\151."
L["Chat frame to output the messages.  Default is ChatFrame3, which is the default output frame for reputation messages in ElvUI."] = "\232\188\184\229\135\186\232\168\138\230\129\175\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151.  \233\160\144\232\168\173\231\130\186 \229\176\141\232\169\177\232\166\150\231\170\1513, \230\152\175 ElvUI \233\160\144\232\168\173\231\154\132\232\129\178\230\156\155\232\168\138\230\129\175\232\188\184\229\135\186\232\166\150\231\170\151."
L["Chat frame to route the auction house messages to."] = "\233\135\141\229\176\142\230\139\141\232\179\163\229\160\180\232\168\138\230\129\175\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151."
L["Chat frame to route the messages to."] = "\233\135\141\229\176\142\232\168\138\230\129\175\232\163\189\229\176\141\232\169\177\232\166\150\231\170\151."
--[[Translation missing --]]
L["Chat frame to send the list to."] = "Chat frame to send the list to."
L["Chat frame to send the messages to."] = "\231\153\188\233\128\129\232\168\138\230\129\175\232\163\189\229\176\141\232\169\177\232\166\150\231\170\151."
--[[Translation missing --]]
L["Chat Frames To Watch"] = "Chat Frames To Watch"
--[[Translation missing --]]
L["Chat Tabs"] = "Chat Tabs"
--[[Translation missing --]]
L["Chat Tweaks"] = "Chat Tweaks"
--[[Translation missing --]]
L["Chat Window"] = "Chat Window"
L["ChatFrame %d"] = "\229\176\141\232\169\177\232\166\150\231\170\151%d"
L["Chats To Monitor"] = true
L["Cheats Color"] = "\228\189\156\229\188\138\233\161\143\232\137\178"
--[[Translation missing --]]
L["Choose the filter to use."] = "Choose the filter to use."
L["Choose which chat frames display timestamps"] = "\233\129\184\230\147\135\229\147\170\228\184\128\229\128\139\232\129\138\229\164\169\232\166\150\231\170\151\233\161\175\231\164\186\230\153\130\233\150\147\230\136\179\232\168\152"
L["Class"] = "\232\129\183\230\165\173"
L["Clear all chat windows."] = "\230\184\133\233\153\164\230\137\128\230\156\137\229\176\141\232\169\177\232\166\150\231\170\151."
L["Clear Chat Commands"] = "\230\184\133\233\153\164\229\176\141\232\169\177\230\140\135\228\187\164"
L["Clear current chat."] = "\230\184\133\233\153\164\231\155\174\229\137\141\229\176\141\232\169\177\232\168\138\230\129\175"
--[[Translation missing --]]
L["Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."] = "Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."
L["Click to reset the materials you're tracking."] = "\233\187\158\233\129\184\228\187\165\233\135\141\231\189\174\228\189\160\230\137\128\232\191\189\232\185\164\231\154\132\232\179\135\230\186\144."
--[[Translation missing --]]
L["Click to send the reminder to the select channel that the Magic 8-Ball is listening."] = "Click to send the reminder to the select channel that the Magic 8-Ball is listening."
--[[Translation missing --]]
L["Click to toggle ElvUI's config window.  This will also close this window."] = "Click to toggle ElvUI's config window.  This will also close this window."
L["Client Locale: |cff1784d1%s|r"] = "\229\174\162\230\136\182\231\171\175\232\170\158\232\168\128: |cff1784d1%s|r"
--[[Translation missing --]]
L["Coin Size"] = "Coin Size"
L["Color"] = "\233\161\143\232\137\178"
--[[Translation missing --]]
L["Color a roll game loss, aka when you roll a one (1)."] = "Color a roll game loss, aka when you roll a one (1)."
--[[Translation missing --]]
L["Color a roll game win, aka when someone else rolls a one (1)."] = "Color a roll game win, aka when someone else rolls a one (1)."
--[[Translation missing --]]
L["Color by Channel"] = "Color by Channel"
L["Color Cheats"] = "\228\184\138\232\137\178\228\189\156\229\188\138"
--[[Translation missing --]]
L["Color Level"] = "Color Level"
L["Color Loss"] = "\228\184\138\232\137\178\229\164\177\230\149\151"
L["Color Name"] = "\228\184\138\232\137\178\229\144\141\231\168\177"
L["Color of other's rolls."] = "\228\187\150\228\186\186\230\147\178\233\170\176\233\161\143\232\137\178."
L["Color of the base reputation messages."] = "\232\129\178\230\156\155\232\168\138\230\129\175\229\159\186\231\164\142\233\161\143\232\137\178."
L["Color of the faction."] = "\233\153\163\231\135\159\231\154\132\233\161\143\232\137\178."
L["Color of the output message."] = "\232\188\184\229\135\186\232\168\138\230\129\175\231\154\132\233\161\143\232\137\178."
L["Color of the reputation needed/left."] = "\232\129\178\230\156\155 \230\137\128\233\156\128/\229\137\169\233\164\152 \233\161\143\232\137\178."
L["Color of the standing (honored, revered, etc.)."] = "\233\154\142\230\174\181\233\161\143\232\137\178 (\229\176\138\230\149\172, \229\180\135\230\149\172, \231\173\137\231\173\137.)."
L["Color own charname in messages."] = "\229\156\168\232\168\138\230\129\175\228\184\173\231\130\186\232\135\170\229\183\177\229\144\141\229\173\151\228\184\138\232\137\178"
L["Color Player Names By..."] = "\228\184\138\232\137\178\232\167\146\232\137\178\229\144\141\231\168\177\228\190\157\230\147\154..."
L["Color regular rolls by others."] = "\228\184\138\232\137\178\229\133\182\228\187\150\228\186\186\231\154\132\230\173\163\229\184\184\230\147\178\233\170\176."
L["Color Rolls"] = "\230\147\178\233\170\176\228\184\138\232\137\178"
L["Color rolls differently to make tracking the roll game easier on the eyes."] = "\229\176\135\230\147\178\233\170\176\232\168\138\230\129\175\229\161\151\228\184\138\228\184\141\229\144\140\231\154\132\233\161\143\232\137\178\228\187\165\228\190\191\232\167\128\229\175\159."
L["Color rolls that do not start at 1."] = "\228\184\138\232\137\178\228\184\141\230\152\175\229\190\1581\233\150\139\229\167\139\231\154\132\230\147\178\233\170\176."
L["Color self in messages"] = "\229\156\168\232\168\138\230\129\175\228\184\173\228\184\138\232\137\178\232\135\170\229\183\177"
--[[Translation missing --]]
L["Color the messages by the channel the message came from."] = "Color the messages by the channel the message came from."
L["Color the name of the pets during a pet battle relative to their rarity.  If you have the pet you're currently battling it will also add the quality of the pet you have in your journal."] = "\229\156\168\229\175\181\231\137\169\230\136\176\233\172\165\228\184\173\228\190\157\231\133\167\229\147\129\232\179\170\228\184\138\232\137\178\228\187\150\229\128\145\231\154\132\229\144\141\231\168\177.  \229\166\130\230\158\156\228\189\160\229\183\178\231\182\147\230\147\129\230\156\137\232\169\178\229\175\181\231\137\169\228\185\159\230\156\131\233\161\175\231\164\186\228\189\160\229\183\178\231\182\147\230\147\129\230\156\137\231\154\132\229\147\129\232\179\170."
L["Color timestamps the same as the channel they appear in."] = "\229\176\135\230\153\130\233\150\147\230\136\179\232\168\152\228\190\157\232\169\178\233\160\187\233\129\147\233\161\143\232\137\178\228\184\138\232\137\178."
--[[Translation missing --]]
L[ [=[Color to change the filtered message to.

|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r.]=] ] = [=[Color to change the filtered message to.

|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r.]=]
L["Color to designate a cheating roll."] = "\228\189\156\229\188\138\233\161\143\232\137\178."
L["Color to designate a roll game loss."] = "\232\188\184\230\142\137\230\147\178\233\170\176\233\161\143\232\137\178."
L["Color to designate a roll game win."] = "\232\180\143\229\190\151\230\147\178\233\170\176\233\161\143\232\137\178."
L["Color to use for your rolls."] = "\228\189\160\231\154\132\230\147\178\233\170\176\233\161\143\232\137\178."
L["Color Win"] = "\228\184\138\232\137\178\229\139\157\229\136\169"
L["Color Your Rolls"] = "\228\184\138\232\137\178\228\189\160\231\154\132\230\147\178\233\170\176"
L["Color your rolls to set them apart."] = "\229\176\135\228\189\160\231\154\132\230\147\178\233\170\176\228\184\138\232\137\178\228\187\165\229\146\140\229\133\182\228\187\150\228\186\186\229\141\128\229\136\165."
L["Colorize"] = true
--[[Translation missing --]]
L["Combat Log Remover"] = "Combat Log Remover"
--[[Translation missing --]]
L["Command Help"] = "Command Help"
--[[Translation missing --]]
L["Companions"] = "Companions"
--[[Translation missing --]]
L["Complete"] = "Complete"
L["Compress"] = "\229\163\147\231\184\174"
--[[Translation missing --]]
L["Concentrate and ask again."] = "Concentrate and ask again."
L["Congratulate achievements earned by guildmates."] = "\229\133\172\230\156\131\230\136\144\229\147\161\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\230\129\173\232\179\128."
L["Congratulate achievements earned by people in your party."] = "\233\154\138\228\188\141\230\136\144\229\147\161\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\230\129\173\232\179\128."
L["Congratulate achievements earned by people in your raid."] = "\229\156\152\233\154\138\230\136\144\229\147\161\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\230\129\173\232\179\128."
L["Congratulate achievements earned by people near you."] = "\233\153\132\232\191\145\231\154\132\228\186\186\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\230\129\173\232\179\128."
L["Congratulations Messages"] = "\230\129\173\232\179\128\232\168\138\230\129\175"
L["conquest"] = true
--[[Translation missing --]]
L["Control + Left Click"] = "Control + Left Click"
--[[Translation missing --]]
L["Control + Right Click"] = "Control + Right Click"
--[[Translation missing --]]
L["Control when Talented should silence Learned/Unlearned system messages"] = "Control when Talented should silence Learned/Unlearned system messages"
L["Cooking"] = "\231\131\185\233\163\170"
L["copper"] = true
--[[Translation missing --]]
L["Copy Links"] = "Copy Links"
L["cp"] = true
L["cpcap"] = true
L["Creates a button to click that will return you to the bottom of the chat frame."] = "\229\162\158\229\138\160\228\184\128\229\128\139\231\155\180\230\142\165\229\136\176\229\176\141\232\169\177\229\186\149\233\131\168\231\154\132\230\140\137\233\136\149"
L["Custom Chat Filters"] = "\232\135\170\232\168\130\229\176\141\232\169\177\233\129\142\230\191\190"
L["Custom chat filters."] = true
L["Custom color"] = "\232\135\170\232\168\130\233\161\143\232\137\178"
L["Custom Emote: |cffffff00%s|r"] = "\232\135\170\232\168\130\232\161\168\230\131\133: |cffffff00%s|r"
L["Custom Emotes"] = "\232\135\170\232\168\130\232\161\168\230\131\133"
L["Custom format (advanced)"] = "\232\135\170\232\168\130\230\160\188\229\188\143 (\233\128\178\233\154\142)"
--[[Translation missing --]]
L["Custom Named Chat Filters"] = "Custom Named Chat Filters"
--[[Translation missing --]]
L["Custom Names"] = "Custom Names"
L["Damage Meters"] = "\230\136\176\233\172\165\231\180\128\233\140\132\230\143\146\228\187\182"
--[[Translation missing --]]
L["Datatext"] = "Datatext"
--[[Translation missing --]]
L["Datatext Display"] = "Datatext Display"
--[[Translation missing --]]
L["Date"] = "Date"
--[[Translation missing --]]
L["Day"] = "Day"
L["Death Knight"] = "\230\173\187\228\186\161\233\168\142\229\163\171"
--[[Translation missing --]]
L["DEATHKNIGHT"] = "DEATHKNIGHT"
L["Default font face for the chat frames."] = "\233\160\144\232\168\173\229\176\141\232\169\177\232\166\150\231\170\151\229\173\151\229\158\139."
L["Default font outline for the chat frames."] = "\233\160\144\232\168\173\229\176\141\232\169\177\232\166\150\231\170\151\229\173\151\229\158\139\230\143\143\233\130\138."
L["Default font size for the chat frames."] = "\233\160\144\232\168\173\229\176\141\232\169\177\232\166\150\231\170\151\229\173\151\229\158\139\229\164\167\229\176\143."
L["Default Name Color"] = "\233\160\144\232\168\173\232\167\146\232\137\178\229\144\141\231\168\177\233\161\143\232\137\178"
L["Destroys all your saved class/level data"] = "\230\145\167\230\175\128\230\137\128\230\156\137\228\189\160\229\132\178\229\173\152\231\154\132 \232\129\183\230\165\173/\231\173\137\231\180\154 \232\179\135\230\150\153"
L["Developer Tools"] = "\233\150\139\231\153\188\229\183\165\229\133\183"
L["Ding Messages"] = "Ding \232\168\138\230\129\175"
--[[Translation missing --]]
L["Disable All Modules"] = "Disable All Modules"
--[[Translation missing --]]
L["Disable if you completed the achievement."] = "Disable if you completed the achievement."
--[[Translation missing --]]
L["Disable if you say ding."] = "Disable if you say ding."
L["Disable if..."] = "\228\187\128\233\186\188\230\162\157\228\187\182\230\153\130\229\129\156\231\148\168..."
--[[Translation missing --]]
L["Disable in Battlegrounds"] = "Disable in Battlegrounds"
--[[Translation missing --]]
L["Disable in PvP Zones"] = "Disable in PvP Zones"
L["Disable while you're AFK flagged."] = "\231\149\182\228\189\160\230\154\171\233\155\162\230\153\130\229\129\156\231\148\168."
L["Disable while you're DND flagged."] = "\231\149\182\228\189\160\229\139\191\230\147\190\230\153\130\229\129\156\231\148\168."
L["Disabled"] = "\229\183\178\229\129\156\231\148\168"
--[[Translation missing --]]
L["Disabled %s%s|r module."] = "Disabled %s%s|r module."
--[[Translation missing --]]
L["Disabled Modules"] = "Disabled Modules"
--[[Translation missing --]]
L["Disables while you are in a battleground."] = "Disables while you are in a battleground."
--[[Translation missing --]]
L["Disables while you are in PvP Zones such as Ashran."] = "Disables while you are in PvP Zones such as Ashran."
--[[Translation missing --]]
L["Display a tooltip by hovering over a link in chat."] = "Display a tooltip by hovering over a link in chat."
--[[Translation missing --]]
L["Display Ability"] = "Display Ability"
--[[Translation missing --]]
L["Display armor/weapon type (Plate, Leather, ...)"] = "Display armor/weapon type (Plate, Leather, ...)"
--[[Translation missing --]]
L["Display equip location (Head, Trinket, ...)"] = "Display equip location (Head, Trinket, ...)"
--[[Translation missing --]]
L["Display item level"] = "Display item level"
--[[Translation missing --]]
L["Display itemlevellinks when someone links an item in chat."] = "Display itemlevellinks when someone links an item in chat."
--[[Translation missing --]]
L["Display itemlevellinks when someone loots an item."] = "Display itemlevellinks when someone loots an item."
--[[Translation missing --]]
L["Display Keystone Conqueror achievement progress."] = "Display Keystone Conqueror achievement progress."
--[[Translation missing --]]
L["Display Keystone Master achievement progress."] = "Display Keystone Master achievement progress."
--[[Translation missing --]]
L["Display the ability that was used to taunt."] = "Display the ability that was used to taunt."
L["Displays reputation numbers and progress in the chat frame."] = "\229\156\168\232\129\138\229\164\169\232\166\150\231\170\151\233\161\175\231\164\186\232\129\178\230\156\155\230\149\184\229\173\151\229\146\140\233\128\178\229\186\166."
L["DND Messages"] = "\229\139\191\230\147\190\232\168\138\230\129\175"
--[[Translation missing --]]
L["Do not reply while in M+ dungeons."] = "Do not reply while in M+ dungeons."
--[[Translation missing --]]
L["Do not use alphanumerical characters."] = "Do not use alphanumerical characters."
L["Do Nothing"] = true
L["Do you want to automatically remove an item when you meet your quota?"] = "\231\149\182\228\189\160\233\129\148\229\136\176\232\166\129\230\177\130\230\149\184\233\135\143\230\153\130\228\189\160\230\131\179\232\166\129\232\135\170\229\139\149\231\167\187\233\153\164\232\169\178\231\137\169\229\147\129\229\151\142?"
--[[Translation missing --]]
L["Doesn't allow multiple announces from your guild members at the same time."] = "Doesn't allow multiple announces from your guild members at the same time."
--[[Translation missing --]]
L["Doesn't send anything to channels, simulating only."] = "Doesn't send anything to channels, simulating only."
L["Dont Always Run"] = true
--[[Translation missing --]]
L["Don't count on it."] = "Don't count on it."
--[[Translation missing --]]
L["Don't show your own failed taunts."] = "Don't show your own failed taunts."
--[[Translation missing --]]
L["Don't show your own taunts."] = "Don't show your own taunts."
--[[Translation missing --]]
L["DRUID"] = "DRUID"
L["Druid"] = "\229\190\183\233\173\175\228\188\138"
--[[Translation missing --]]
L["Dungeon Guide"] = "Dungeon Guide"
--[[Translation missing --]]
L["Easy Channel"] = "Easy Channel"
--[[Translation missing --]]
L["EditBox Alt Key Arrows"] = "EditBox Alt Key Arrows"
L["ElvUI ChatTweaks"] = "ElvUI \229\176\141\232\169\177\229\162\158\229\188\183"
--[[Translation missing --]]
L["ElvUI_ChatTweaks"] = "ElvUI_ChatTweaks"
--[[Translation missing --]]
L["ElvUI_CT"] = "ElvUI_CT"
L["Emote"] = "\232\161\168\230\131\133"
L["Emote Filter"] = "\232\161\168\230\131\133\233\129\142\230\191\190"
L["Emphasize Self"] = "\229\188\183\232\170\191\232\135\170\229\183\177"
L["Enable "] = "\229\149\159\231\148\168"
L["Enable"] = true
--[[Translation missing --]]
L["Enable All Modules"] = "Enable All Modules"
L["Enable Debugging"] = "\229\149\159\231\148\168\229\129\181\233\140\175"
--[[Translation missing --]]
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always congratulate."] = "Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always congratulate."
--[[Translation missing --]]
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always run."] = "Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always run."
--[[Translation missing --]]
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always welcome."] = "Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always welcome."
L["Enable to filter custom emotes made using |cff00ff00/emote|r or |cff00ff00/e|r."] = "\229\149\159\231\148\168\233\129\142\230\191\190\232\135\170\232\168\130\232\161\168\230\131\133\228\190\139\229\166\130\228\189\191\231\148\168 |cff00ff00/emote|r \230\136\150 |cff00ff00/e|r."
L["Enable to filter standard emotes such as |cff00ff00/dance|r or |cff00ff00/flirt|r."] = "\229\149\159\231\148\168\233\129\142\230\191\190\233\160\144\232\168\173\232\161\168\230\131\133\228\190\139\229\166\130 |cff00ff00/\232\183\179\232\136\158|r \230\136\150 |cff00ff00/\232\170\191\230\131\133|r."
L["Enable various debugging messages to help with errors or undesired functioning."] = "\229\149\159\231\148\168\229\144\132\231\168\174\229\129\181\233\140\175\232\168\138\230\129\175\228\190\134\229\185\171\229\138\169\230\170\162\230\159\165\233\140\175\232\170\164\229\146\140\229\138\159\232\131\189."
L["Enabled"] = "\229\183\178\229\149\159\231\148\168"
--[[Translation missing --]]
L["Enabled %s%s|r module."] = "Enabled %s%s|r module."
--[[Translation missing --]]
L["Enabled Modules"] = "Enabled Modules"
--[[Translation missing --]]
L["Enables the whoing of friends."] = "Enables the whoing of friends."
--[[Translation missing --]]
L["Enables the whoing of Guildmates."] = "Enables the whoing of Guildmates."
--[[Translation missing --]]
L[ [=[Enables you to replace channel names with your own names. You can use '%s' to force an empty string.

|cffffff00Please disable ElvUI Short Channel option for this to work, you'll find the option under /ec - Chat - General - Short Channels.]=] ] = [=[Enables you to replace channel names with your own names. You can use '%s' to force an empty string.

|cffffff00Please disable ElvUI Short Channel option for this to work, you'll find the option under /ec - Chat - General - Short Channels.]=]
--[[Translation missing --]]
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name.  Can also scan guild notes for character names to display, if no note has been manually set."] = "Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name.  Can also scan guild notes for character names to display, if no note has been manually set."
--[[Translation missing --]]
L["Enabling this will send a message to your chat whenever you change a zone with a list of the Battle Pets that are obtainable in the zone.  You have the option to filter them based on whether or not you own them.  This will also add the chat command |cff00ff96/zonelist|r to send the list whenever.  Even if you disable this the chat commands will still work."] = "Enabling this will send a message to your chat whenever you change a zone with a list of the Battle Pets that are obtainable in the zone.  You have the option to filter them based on whether or not you own them.  This will also add the chat command |cff00ff96/zonelist|r to send the list whenever.  Even if you disable this the chat commands will still work."
L["Enchanting"] = "\233\153\132\233\173\148"
L["Engineering"] = "\229\183\165\231\168\139\229\173\184"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "\232\188\184\229\133\165\232\135\170\232\168\130\230\153\130\233\150\147\230\160\188\229\188\143. \229\143\131\233\150\177 http://www.lua.org/pil/22.1.html \228\190\134\229\143\150\229\190\151\228\184\128\228\187\189\230\156\137\230\149\136\230\160\188\229\188\143\231\154\132\229\136\151\232\161\168."
--[[Translation missing --]]
L["Enter a value in seconds."] = "Enter a value in seconds."
--[[Translation missing --]]
L["Equip Location"] = "Equip Location"
--[[Translation missing --]]
L["etc"] = "etc"
L["Exclude level display for max level characters"] = "\228\184\141\233\161\175\231\164\186\229\183\178\233\129\148\230\156\128\233\171\152\231\173\137\231\180\154\232\167\146\232\137\178\231\173\137\231\180\154"
L["Exclude max levels"] = "\230\142\146\233\153\164\230\156\128\233\171\152\231\173\137\231\180\154"
L["Execution Interval"] = "\229\159\183\232\161\140\233\150\147\233\154\148"
L["Faction Color"] = "\233\153\163\231\135\159\233\161\143\232\137\178"
--[[Translation missing --]]
L["Failed:"] = "Failed:"
--[[Translation missing --]]
L["Fake Achievement"] = "Fake Achievement"
--[[Translation missing --]]
L["Female"] = "Female"
--[[Translation missing --]]
L["Filter achievement message spam!"] = "Filter achievement message spam!"
L["Filter achievements earned by guildmates."] = "\233\129\142\230\191\190\229\133\172\230\156\131\230\136\144\229\147\161\230\137\128\229\143\150\229\190\151\231\154\132\230\136\144\229\176\177."
L["Filter achievements earned by nearby people."] = "\233\129\142\230\191\190\233\153\132\232\191\145\231\154\132\228\186\186\230\137\128\229\143\150\229\190\151\231\154\132\230\136\144\229\176\177."
L["Filter AFK messages."] = "\233\129\142\230\191\190\230\154\171\233\155\162\232\168\138\230\129\175."
L["Filter AFK/DND auto responses.  This module is compatible with WIM."] = "\233\129\142\230\191\190 \230\154\171\233\155\162/\229\139\191\230\147\190 \232\135\170\229\139\149\229\155\158\230\135\137.  \230\173\164\230\168\161\231\181\132\231\155\184\229\174\185\230\150\188 WIM."
L["Filter by Player Level"] = "\230\160\185\230\147\154\231\142\169\229\174\182\231\173\137\231\180\154\233\129\142\230\191\190"
L["Filter changed channel message."] = "\233\129\142\230\191\190\232\174\138\230\155\180\233\160\187\233\129\147\232\168\138\230\129\175."
--[[Translation missing --]]
L["Filter Color"] = "Filter Color"
L["Filter DND messages."] = "\233\129\142\230\191\190\229\139\191\230\147\190\232\168\138\230\129\175."
L["Filter Guild Achievements"] = "\233\129\142\230\191\190\229\133\172\230\156\131\230\136\144\229\176\177"
L["Filter joined channel message."] = "\233\129\142\230\191\190\229\138\160\229\133\165\233\160\187\233\129\147\232\168\138\230\129\175."
L["Filter left channel message."] = "\233\129\142\230\191\190\233\155\162\233\150\139\233\160\187\233\129\147\232\168\138\230\129\175."
--[[Translation missing --]]
L["Filter Line"] = "Filter Line"
--[[Translation missing --]]
L["Filter Mode"] = "Filter Mode"
L["Filter Nearby Achievements"] = "\233\129\142\230\191\190\233\153\132\232\191\145\230\136\144\229\176\177"
--[[Translation missing --]]
L["Filter Pets"] = "Filter Pets"
L["Filter spam throttle notices."] = "\233\129\142\230\191\190\229\191\171\233\128\159\231\153\188\232\168\128\230\143\144\231\164\186."
L["Filter standard and/or custom emotes."] = "\233\129\142\230\191\190\233\160\144\232\168\173 \229\146\140/\230\136\150 \232\135\170\232\168\130\232\161\168\230\131\133."
--[[Translation missing --]]
L[ [=[Filter the Auction Created message.

|cffffff00%s|r]=] ] = [=[Filter the Auction Created message.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Expired message.

|cffffff00%s|r]=] ] = [=[\233\129\142\230\191\190\230\139\141\232\179\163\229\147\129\233\129\142\230\156\159\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Outbid message.

|cffffff00%s|r]=] ] = [=[\233\129\142\230\191\190\230\139\141\232\179\163\229\147\129\230\144\182\230\168\153\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Removed message.

|cffffff00%s|r]=] ] = [=[\233\129\142\230\191\190\230\139\141\232\179\163\229\147\129\231\167\187\233\153\164\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Sold message.

|cffffff00%s|r]=] ] = [=[\233\129\142\230\191\190\230\139\141\232\179\163\229\147\129\229\148\174\229\135\186\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Won message.

|cffffff00%s|r]=] ] = [=[\233\129\142\230\191\190\232\180\143\229\190\151\230\139\141\232\179\163\229\147\129\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Filter the Bid Accepted message.

|cffffff00%s|r]=] ] = [=[\233\129\142\230\191\190\230\142\165\229\143\151\230\139\141\232\179\163\229\147\129\232\168\138\230\129\175.

|cffffff00%s|r]=]
--[[Translation missing --]]
L["Filter the line containing the question."] = "Filter the line containing the question."
--[[Translation missing --]]
L[ [=[Filter what item quality should be displayed in chat.
|cfff960d9Quality steps: 0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary & 6 = Artifact|r]=] ] = [=[Filter what item quality should be displayed in chat.
|cfff960d9Quality steps: 0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary & 6 = Artifact|r]=]
L["Filtering Mode"] = "\233\129\142\230\191\190\230\168\161\229\188\143"
--[[Translation missing --]]
L["Filters"] = "Filters"
L["Filters out Auction House system messages."] = "\233\129\142\230\191\190\228\190\134\232\135\170\230\139\141\232\179\163\229\160\180\231\154\132\232\168\138\230\129\175"
L["Filters the channel notices."] = "\233\129\142\230\191\190\232\135\170\232\168\130\233\160\187\233\129\147\230\143\144\231\164\186."
--[[Translation missing --]]
L["Font Color"] = "Font Color"
L["Font Face"] = "\229\173\151\229\158\139"
L["Font Size"] = "\229\173\151\229\158\139\229\164\167\229\176\143"
--[[Translation missing --]]
L["Frame scraping timeout exceeded, results will be incomplete."] = "Frame scraping timeout exceeded, results will be incomplete."
--[[Translation missing --]]
L["Frame to output the messages to."] = "Frame to output the messages to."
--[[Translation missing --]]
L["Frame to send the addon messages to."] = "Frame to send the addon messages to."
L["Friends"] = "\230\156\139\229\143\139"
--[[Translation missing --]]
L["Friends Whispers"] = "Friends Whispers"
--[[Translation missing --]]
L["Fun Filters"] = "Fun Filters"
--[[Translation missing --]]
L["Gamemenu Button"] = "Gamemenu Button"
--[[Translation missing --]]
L["General"] = "General"
--[[Translation missing --]]
L["General Tab Channels"] = "General Tab Channels"
--[[Translation missing --]]
L["Generate fake achievement links."] = "Generate fake achievement links."
--[[Translation missing --]]
L["ginv"] = "ginv"
--[[Translation missing --]]
L["ginvite"] = "ginvite"
L["GInvite Alternate Command"] = "\229\133\172\230\156\131\233\130\128\232\171\139\230\140\135\228\187\164"
--[[Translation missing --]]
L["Gives the ability to add custom names to the chat messages for better recognition."] = "Gives the ability to add custom names to the chat messages for better recognition."
L["Gives you more flexibility in how you invite people to your group and guild."] = "\231\149\182\228\189\160\233\130\128\230\133\182\228\186\186\232\135\179\229\133\172\230\156\131\230\136\150\233\154\138\228\188\141\230\153\130\231\181\166\228\186\136\228\189\160\230\155\180\229\164\154\231\154\132\229\189\136\230\128\167."
L["GKick Command"] = "\232\184\162\229\135\186\229\133\172\230\156\131\230\140\135\228\187\164"
L["GKick Target: |cffffff00%s|r"] = "\232\184\162\229\135\186\229\133\172\230\156\131 \231\155\174\230\168\153: |cffffff00%s|r"
L["gold"] = true
L["Gold Calculator"] = "\233\135\145\229\185\163\232\168\136\231\174\151\230\169\159"
L["Group"] = "\233\154\138\228\188\141"
L["Group Invite Links"] = "\233\154\138\228\188\141\233\130\128\232\171\139\233\128\163\231\181\144"
L["Group Say Command"] = "\232\135\170\229\139\149\233\154\138\228\188\141\230\140\135\228\187\164"
L["Guild"] = "\229\133\172\230\156\131"
L["Guild Channel"] = "\229\133\172\230\156\131\233\160\187\233\129\147"
L["Guild Chat"] = "\229\133\172\230\156\131\229\176\141\232\169\177"
--[[Translation missing --]]
L["Guild cooperation mode"] = "Guild cooperation mode"
L["Guild Invite Links"] = "\229\133\172\230\156\131\233\130\128\232\171\139\233\128\163\231\181\144"
L["Guild Messages"] = "\229\133\172\230\156\131\232\168\138\230\129\175"
L["Guild Options"] = "\229\133\172\230\156\131\233\129\184\233\160\133"
--[[Translation missing --]]
L["Guild Recruitment"] = "Guild Recruitment"
--[[Translation missing --]]
L["Guild Whispers"] = "Guild Whispers"
L["Guildmates"] = "\229\133\172\230\156\131\230\156\131\229\147\161"
--[[Translation missing --]]
L["GuildSync: Accepted configuration update from %s"] = "GuildSync: Accepted configuration update from %s"
--[[Translation missing --]]
L["GuildSync: Error. Bad configuration received from %s"] = "GuildSync: Error. Bad configuration received from %s"
--[[Translation missing --]]
L["Handles chat tab flashing."] = "Handles chat tab flashing."
L["health"] = true
--[[Translation missing --]]
L["Here you can select which channels this module will scan for the keygroupWords to trigger the invite."] = "Here you can select which channels this module will scan for the keygroupWords to trigger the invite."
L["HH:MM (12-hour)"] = "HH:MM (12-\229\176\143\230\153\130\229\136\182)"
L["HH:MM (24-hour)"] = "HH:MM (24-\229\176\143\230\153\130\229\136\182)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24-\229\176\143\230\153\130\229\136\182)"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12-\229\176\143\230\153\130\229\136\182)"
--[[Translation missing --]]
L["Hide Compatibility Message"] = "Hide Compatibility Message"
--[[Translation missing --]]
L["Hide name if it matches your character's name"] = "Hide name if it matches your character's name"
--[[Translation missing --]]
L["Hide Own Failed Taunts"] = "Hide Own Failed Taunts"
--[[Translation missing --]]
L["Hide Own Taunts"] = "Hide Own Taunts"
--[[Translation missing --]]
L["Hide the compatibility message in chat when KlixUI is installed."] = "Hide the compatibility message in chat when KlixUI is installed."
--[[Translation missing --]]
L["Hiding Configuration Options"] = "Hiding Configuration Options"
L["Highlight Color"] = "\233\171\152\228\186\174\233\161\143\232\137\178"
--[[Translation missing --]]
L["Highlight Substitutions"] = "Highlight Substitutions"
--[[Translation missing --]]
L["Highlight Term"] = "Highlight Term"
--[[Translation missing --]]
L["Highlight the search term in the results."] = "Highlight the search term in the results."
--[[Translation missing --]]
L["Highlight the substitutions that are made by changing their color."] = "Highlight the substitutions that are made by changing their color."
L["honor"] = true
L["honour"] = true
L["Hook the GameTooltip to add information to pet tooltips."] = "Hook \233\129\138\230\136\178\230\143\144\231\164\186\228\190\134\229\162\158\229\138\160\229\175\181\231\137\169\230\143\144\231\164\186."
--[[Translation missing --]]
L["Hook the tooltip to show the toon's main or alts."] = "Hook the tooltip to show the toon's main or alts."
L["Hook Tooltip"] = "Hook \230\143\144\231\164\186"
--[[Translation missing --]]
L["Hour (12hr)"] = "Hour (12hr)"
--[[Translation missing --]]
L["Hour (24hr)"] = "Hour (24hr)"
--[[Translation missing --]]
L["Hover Links"] = "Hover Links"
--[[Translation missing --]]
L["How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command."] = "How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command."
--[[Translation missing --]]
L["How often announce your message to channel."] = "How often announce your message to channel."
--[[Translation missing --]]
L["How to filter any matches."] = "How to filter any matches."
L["Hunter"] = "\231\141\181\228\186\186"
--[[Translation missing --]]
L["HUNTER"] = "HUNTER"
L["I am |cff1784d1%s|r"] = true
L["Icon Orientation"] = "\229\156\150\231\164\186\230\150\185\229\144\145"
L["Icon Size"] = "\229\156\150\231\164\186\229\164\167\229\176\143"
L["Icon to the left or right of the item link."] = "\229\156\168\231\137\169\229\147\129\233\128\163\231\181\144\229\183\166\230\150\185\230\136\150\229\143\179\230\150\185\233\161\175\231\164\186\229\156\150\231\164\186."
L["Identify Chat Frames"] = "\232\190\168\232\173\152\229\176\141\232\169\177\232\166\150\231\170\151"
--[[Translation missing --]]
L["If a keyword is found should the module filter the line?"] = "If a keyword is found should the module filter the line?"
--[[Translation missing --]]
L["If no name can be found for an 'alt' rank character, use entire note"] = "If no name can be found for an 'alt' rank character, use entire note"
--[[Translation missing --]]
L["If the name specified above matches your current character's name, this module will not add it again if this option is checked."] = "If the name specified above matches your current character's name, this module will not add it again if this option is checked."
--[[Translation missing --]]
L["Ignore any messages you send containing keywords."] = "Ignore any messages you send containing keywords."
--[[Translation missing --]]
L["Ignore Your Messages"] = "Ignore Your Messages"
L[ [=[Improve the Auction Expired message.

|cffffff00%s|r]=] ] = [=[\229\188\183\229\140\150\230\139\141\232\179\163\229\147\129\233\129\142\230\156\159\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Improve the Auction Outbid message.

|cffffff00%s|r]=] ] = [=[\229\188\183\229\140\150\230\139\141\232\179\163\229\147\129\230\144\182\230\168\153\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Improve the Auction Removed message.

|cffffff00%s|r]=] ] = [=[\229\188\183\229\140\150\230\139\141\232\179\163\229\147\129\231\167\187\233\153\164\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Improve the Auction Sold message.

|cffffff00%s|r]=] ] = [=[\229\188\183\229\140\150\230\139\141\232\179\163\229\147\129\229\148\174\229\135\186\232\168\138\230\129\175.

|cffffff00%s|r]=]
L[ [=[Improve the Auction Won message.

|cffffff00%s|r]=] ] = [=[\229\188\183\229\140\150\232\180\143\229\190\151\230\139\141\232\179\163\229\147\129\232\168\138\230\129\175.

|cffffff00%s|r]=]
L["Improved Auction Messages"] = "\229\188\183\229\140\150\230\139\141\232\179\163\232\168\138\230\129\175"
L["In Command"] = "In \230\140\135\228\187\164"
--[[Translation missing --]]
L["Inactive Modules"] = "Inactive Modules"
L["Include level"] = "\229\140\133\229\144\171\231\173\137\231\180\154"
--[[Translation missing --]]
L["Include Prefix"] = "Include Prefix"
--[[Translation missing --]]
L["Include the"] = "Include the"
L["Include the player's level"] = "\229\140\133\229\144\171\232\167\146\232\137\178\231\173\137\231\180\154"
--[[Translation missing --]]
L["Incomplete"] = "Incomplete"
L["Inscription"] = "\233\138\152\230\150\135\229\173\184"
--[[Translation missing --]]
L["Instance"] = "Instance"
--[[Translation missing --]]
L["Instance Channel"] = "Instance Channel"
--[[Translation missing --]]
L["Instance Leader"] = "Instance Leader"
--[[Translation missing --]]
L[ [=[Instantly send the information of whom whispered you.

]=] ] = [=[Instantly send the information of whom whispered you.

]=]
--[[Translation missing --]]
L["inv"] = "inv"
--[[Translation missing --]]
L["Invalid achievement ID for %s%d|r."] = "Invalid achievement ID for %s%d|r."
--[[Translation missing --]]
L["Invalid achievement link provided."] = "Invalid achievement link provided."
--[[Translation missing --]]
L["Invalid format found on entry \"%s\"."] = "Invalid format found on entry \"%s\"."
--[[Translation missing --]]
L["invite"] = "invite"
L["Invite Links"] = "\232\135\170\229\139\149\233\130\128\232\171\139"
--[[Translation missing --]]
L["It is certain."] = "It is certain."
--[[Translation missing --]]
L["It is decidedly so."] = "It is decidedly so."
--[[Translation missing --]]
L["Item Level"] = "Item Level"
--[[Translation missing --]]
L["Item Level Link"] = "Item Level Link"
L["Jewelcrafting"] = "\231\143\160\229\175\182\229\138\160\229\183\165"
L["Joined Channel"] = "\233\160\187\233\129\147\229\138\160\229\133\165"
L["jp"] = true
L["jpcap"] = true
--[[Translation missing --]]
L["Just one character."] = "Just one character."
L["justice"] = true
--[[Translation missing --]]
L["Keeps your channel colors by name rather than by number."] = "Keeps your channel colors by name rather than by number."
L["Keybinds"] = "\229\191\171\230\141\183\233\141\181"
--[[Translation missing --]]
L["Keystone Announce"] = "Keystone Announce"
--[[Translation missing --]]
L["Keystone Conqueror Completion Status"] = "Keystone Conqueror Completion Status"
--[[Translation missing --]]
L["Keystone Master Completion Status"] = "Keystone Master Completion Status"
--[[Translation missing --]]
L["Keystone Progress"] = "Keystone Progress"
--[[Translation missing --]]
L["Keyword Sounds"] = "Keyword Sounds"
--[[Translation missing --]]
L["Keywords"] = "Keywords"
L["Leatherworking"] = "\232\163\189\231\154\174"
L["Left"] = "\233\157\160\229\183\166"
L["Left Bracket"] = "\229\183\166\230\139\172\229\188\167"
L["Left Channel"] = "\229\183\166\233\130\138\233\160\187\233\129\147"
--[[Translation missing --]]
L["Left Click"] = "Left Click"
L["Lets you alt-click player names to invite them to your party."] = "\232\174\147\228\189\160ALT+\229\183\166\233\141\181\233\187\158\233\129\184\229\144\141\231\168\177\228\190\134\233\130\128\232\171\139\228\187\150\229\128\145\229\138\160\229\133\165\233\154\138\228\188\141."
L["Lets you set the justification of text in your chat frames."] = "\232\174\147\228\189\160\232\168\173\229\174\154\229\176\141\232\169\177\232\166\150\231\170\151\231\154\132\229\176\141\233\189\138\230\150\185\229\188\143."
--[[Translation missing --]]
L["Level Difference"] = "Level Difference"
L["Level Location"] = "\231\173\137\231\180\154\228\189\141\231\189\174"
L["Level: |cffffff00%s|r, Message: |cffffff00%s|r"] = "\231\173\137\231\180\154: |cffffff00%s|r, \232\168\138\230\129\175: |cffffff00%s|r"
L["Link All Professions"] = "\233\128\163\231\181\144\230\137\128\230\156\137\228\186\164\230\152\147\230\138\128\232\131\189"
--[[Translation missing --]]
L["Login"] = "Login"
L["Look in guildnotes for character names, unless a note is set manually"] = "\229\156\168\229\133\172\230\156\131\232\168\187\232\168\152\228\184\173\230\159\165\232\169\162\232\167\146\232\137\178\229\144\141\231\168\177, \233\153\164\233\157\158\229\183\178\230\137\139\229\139\149\232\168\173\229\174\154"
L["Loot Icons"] = "\230\136\176\229\136\169\229\147\129\229\156\150\231\164\186"
L["Loss Color"] = "\232\188\184\230\142\137\233\161\143\232\137\178"
--[[Translation missing --]]
L["lowercase"] = "lowercase"
--[[Translation missing --]]
L["MAGE"] = "MAGE"
L["Mage"] = "\230\179\149\229\184\171"
--[[Translation missing --]]
L["Magic 8-Ball"] = "Magic 8-Ball"
--[[Translation missing --]]
L["Magic 8-Ball says: %s"] = "Magic 8-Ball says: %s"
--[[Translation missing --]]
L["Magic 8-Ball Says: I am ready to answer your questions!  Do \"%s <question>\" to ask me a question."] = "Magic 8-Ball Says: I am ready to answer your questions!  Do \"%s <question>\" to ask me a question."
--[[Translation missing --]]
L["Main: "] = "Main: "
--[[Translation missing --]]
L["Makes it easy to identify which person popped bloodlust/heroism."] = "Makes it easy to identify which person popped bloodlust/heroism."
--[[Translation missing --]]
L["Makes it easy to navigate through the different channels by pressing the 'TAB' Key."] = "Makes it easy to navigate through the different channels by pressing the 'TAB' Key."
--[[Translation missing --]]
L["Male"] = "Male"
L["mana"] = true
L["Material Quantities"] = "\232\179\135\230\186\144\230\149\184\233\135\143"
L["Materials Farming"] = "\232\179\135\230\186\144\232\146\144\233\155\134"
L["Materials to Track"] = "\232\191\189\232\185\164\232\179\135\230\186\144"
L["Maximum Delay"] = "\230\156\128\229\164\167\229\187\182\233\129\178"
L["Maximum time, in seconds, to wait before bidding someone farewell."] = "\233\129\147\229\136\165\229\137\141\231\173\137\229\190\133\230\156\128\229\164\167\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Maximum time, in seconds, to wait before congratulating someone."] = "\230\129\173\232\179\128\229\137\141\231\173\137\229\190\133\230\156\128\229\164\167\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Maximum time, in seconds, to wait before welcoming someone."] = "\230\173\161\232\191\142\229\137\141\231\173\137\229\190\133\230\156\128\229\164\167\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Maximum time, in seconds, to wait before whispering someone the link."] = "\229\155\158\232\166\134\233\128\163\231\181\144\229\137\141\231\173\137\229\190\133\230\156\128\229\164\167\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Message Color"] = "\232\168\138\230\129\175\233\161\143\232\137\178"
L["Message color."] = "\232\168\138\230\129\175\233\161\143\232\137\178."
L["Message highlight color."] = "\232\168\138\230\129\175\233\171\152\228\186\174\233\161\143\232\137\178."
L["Message Settings"] = "\232\168\138\230\129\175\232\168\173\229\174\154"
--[[Translation missing --]]
L["Message Throttle"] = "Message Throttle"
--[[Translation missing --]]
L["Message to announce, 2 lines max"] = "Message to announce, 2 lines max"
L[ [=[Messages for when multiple people complete achievements.  A random one will always be selected.

|cffff0000Wildcards do not apply for multiple achievements.|r]=] ] = true
L[ [=[Messages for when someone completes an achievement.  A random one will always be selected.

|cffFA6400Wildcards|r
|cff00ff00#name#|r  - Name of the person.
|cff00ff00#achieve#|r - Achievement they completed.]=] ] = true
L[ [=[Messages to use in guild chat when someone leaves your guild.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Person who left.
|cff00ff00#guild#|r - Name of your guild.]=] ] = true
L[ [=[Messages to use in the whisper when someone leaves your guild.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Person who left.
|cff00ff00#guild#|r - Name of your guild.]=] ] = true
L[ [=[Messages to use when someone joins your guild.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Person who joined.
|cff00ff00#guild#|r - Name of your guild.]=] ] = true
L[ [=[Messages to use when someone says "ding".

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Who said ding.
|cff00ff00#guild#|r - Their current level.]=] ] = true
--[[Translation missing --]]
L["Minimap Button"] = "Minimap Button"
L["Minimum Delay"] = "\230\156\128\229\176\143\229\187\182\233\129\178"
L["Minimum Level"] = "\230\156\128\228\189\142\231\173\137\231\180\154"
L["Minimum level required for an achievement to not be filtered."] = "\230\156\128\229\176\143\228\184\141\233\129\142\230\191\190\230\136\144\229\176\177\231\173\137\231\180\154."
L["Minimum time, in seconds, to wait before bidding someone farewell."] = "\233\129\147\229\136\165\229\137\141\230\156\128\229\176\143\231\173\137\229\190\133\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Minimum time, in seconds, to wait before congratulating someone."] = "\230\129\173\232\179\128\229\137\141\230\156\128\229\176\143\231\173\137\229\190\133\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Minimum time, in seconds, to wait before welcoming someone."] = "\230\173\161\232\191\142\229\137\141\230\156\128\229\176\143\231\173\137\229\190\133\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Minimum time, in seconds, to wait before whispering someone the link."] = "\229\155\158\232\166\134\233\128\163\231\181\144\229\137\141\230\156\128\229\176\143\231\173\137\229\190\133\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
--[[Translation missing --]]
L["Minute"] = "Minute"
L["MM:SS"] = true
--[[Translation missing --]]
L["Monitor Chat Events"] = "Monitor Chat Events"
L["Monitor guild chat."] = "\231\155\163\230\142\167\229\133\172\230\156\131\229\176\141\232\169\177."
L["Monitor party chat."] = "\231\155\163\230\142\167\233\154\138\228\188\141\230\156\131\229\176\141\232\169\177."
L["Monitor raid chat."] = "\231\155\163\230\142\167\229\156\152\233\154\138\229\176\141\232\169\177."
L["Monitor say chat."] = "\231\155\163\230\142\167\232\170\170."
--[[Translation missing --]]
L["Monitor text in this channel for link triggers."] = "Monitor text in this channel for link triggers."
L["Monitor whispers."] = "\231\155\163\230\142\167\229\175\134\232\170\158."
L["Monitor yell chat."] = "\231\155\163\230\142\167\229\164\167\229\150\138."
--[[Translation missing --]]
L["Monk"] = "Monk"
--[[Translation missing --]]
L["MONK"] = "MONK"
L["Monster Emote"] = "\230\128\170\231\137\169\232\161\168\230\131\133"
L["Monster Say"] = "\230\128\170\231\137\169\232\170\170"
--[[Translation missing --]]
L["Month"] = "Month"
--[[Translation missing --]]
L["Most likely."] = "Most likely."
L["Multiple Achievement Messages"] = "\229\164\154\233\135\141\230\136\144\229\176\177\232\168\138\230\129\175"
--[[Translation missing --]]
L["Multiple Invite Command"] = "Multiple Invite Command"
--[[Translation missing --]]
L["My reply is no."] = "My reply is no."
--[[Translation missing --]]
L["My sources say no."] = "My sources say no."
L["Name"] = "\229\144\141\231\168\177"
L["Name color"] = "\229\144\141\231\168\177\228\184\138\232\137\178"
L["Nearby People"] = "\233\153\132\232\191\145\231\154\132\228\186\186"
--[[Translation missing --]]
L["Never"] = "Never"
L["New Version Notify"] = "\230\150\176\231\137\136\233\128\154\231\159\165"
--[[Translation missing --]]
L["No"] = "No"
L["No custom emotes are currently being used."] = "\230\178\146\230\156\137\232\135\170\232\168\130\232\161\168\230\131\133\230\173\163\229\156\168\232\162\171\228\189\191\231\148\168."
--[[Translation missing --]]
L["No Filter"] = "No Filter"
L["No RealNames"] = "\228\184\141\233\161\175\231\164\186\231\156\159\229\175\166\229\167\147\229\144\141"
L["None"] = "\231\132\161"
--[[Translation missing --]]
L["Not Capturable"] = "Not Capturable"
--[[Translation missing --]]
L["Not Found"] = "Not Found"
--[[Translation missing --]]
L["Not Owned"] = "Not Owned"
L["Not tracking %s."] = "%s \230\156\170\232\162\171\232\191\189\232\185\164."
L["NoTarget"] = "\231\132\161\231\155\174\230\168\153"
--[[Translation missing --]]
L["Notifies your party or raid if people are taking a lot of avoidable damage from ground auras."] = "Notifies your party or raid if people are taking a lot of avoidable damage from ground auras."
--[[Translation missing --]]
L["Notify on new release?"] = "Notify on new release?"
--[[Translation missing --]]
L["Notify on Role Set"] = "Notify on Role Set"
--[[Translation missing --]]
L["Num Channels"] = "Num Channels"
--[[Translation missing --]]
L["Numbered Channels"] = "Numbered Channels"
--[[Translation missing --]]
L["Off"] = "Off"
L["Officer"] = "\229\185\185\233\131\168"
L["Officer Channel"] = "\229\185\185\233\131\168\233\160\187\233\129\147"
L["Officer Chat"] = "\229\185\185\233\131\168\229\176\141\232\169\177"
--[[Translation missing --]]
L["On"] = "On"
--[[Translation missing --]]
L["On (%d min)"] = "On (%d min)"
--[[Translation missing --]]
L["On (%d sec)"] = "On (%d sec)"
L["One or more of the changes you have made require you to reload your UI."] = "\228\184\128\229\128\139\230\136\150\229\164\154\229\128\139\232\174\138\230\155\180\233\156\128\232\166\129\228\189\160\233\135\141\232\188\137UI."
L["Only filter achievements earned by players below a certain level."] = "\229\131\133\233\129\142\230\191\190\228\189\142\230\150\188\231\137\185\229\174\154\231\173\137\231\180\154\231\142\169\229\174\182\229\143\150\229\190\151\231\154\132\230\136\144\229\176\177."
--[[Translation missing --]]
L["Open Config"] = "Open Config"
--[[Translation missing --]]
L["Open ElvUI Config"] = "Open ElvUI Config"
--[[Translation missing --]]
L["Open ElvUI's Config"] = "Open ElvUI's Config"
L["Opens configuration window."] = "\233\150\139\229\149\159\232\168\173\229\174\154\232\166\150\231\170\151."
L["Other Channels"] = "\229\133\182\229\174\131\233\160\187\233\129\147"
L["Ouput Frame"] = "\232\188\184\229\135\186\232\166\150\231\170\151"
L["Outline"] = "\230\143\143\233\130\138"
--[[Translation missing --]]
L["Outlook good."] = "Outlook good."
--[[Translation missing --]]
L["Outlook not so good."] = "Outlook not so good."
--[[Translation missing --]]
L["Output Channel"] = "Output Channel"
L["Output Color"] = "\232\188\184\229\135\186\233\161\143\232\137\178"
L["Output color of the rerouted messages."] = "\233\135\141\229\176\142\232\168\138\230\129\175\232\188\184\229\135\186\233\161\143\232\137\178."
L["Output Frame"] = "\232\188\184\229\135\186\232\166\150\231\170\151"
L["Output Message Every..."] = true
L["Output the message every X times you gain XP."] = "\230\175\143 X \230\172\161\228\189\160\231\141\178\229\190\151\231\182\147\233\169\151\230\153\130\233\161\175\231\164\186\232\168\138\230\129\175."
--[[Translation missing --]]
L["Output To..."] = "Output To..."
--[[Translation missing --]]
L["Owned Only"] = "Owned Only"
--[[Translation missing --]]
L["PALADIN"] = "PALADIN"
L["Paladin"] = "\232\129\150\233\168\142\229\163\171"
L["Parameter: |cffffff00%s|r"] = "\229\143\131\230\149\184: |cffffff00%s|r"
L["Party"] = "\233\154\138\228\188\141"
L["Party Channel"] = "\233\154\138\228\188\141\233\160\187\233\129\147"
L["Party Leader"] = "\233\154\138\228\188\141\233\154\138\233\149\183"
L["Party Members"] = "\233\154\138\228\188\141\230\136\144\229\147\161"
L["Percent Chance"] = "%\230\169\159\230\156\131"
L["Perhaps you meant '*' (multiplication)?"] = "\228\189\160\231\154\132\230\132\143\230\128\157\230\152\175 '*' (\228\185\152\230\179\149)?"
L["Pet Battle Info"] = "\229\175\181\231\137\169\229\176\141\230\136\176\232\168\138\230\129\175"
L["Pet Battles"] = "\229\175\181\231\137\169\230\136\176\233\172\165"
L["Pet Combat Log"] = "\229\175\181\231\137\169\229\176\141\230\136\176\231\180\128\233\140\132"
--[[Translation missing --]]
L["Pets Per Line"] = "Pets Per Line"
L["Place the level before or after the player's name."] = "\229\156\168\232\167\146\232\137\178\229\144\141\231\168\177\229\137\141\230\136\150\229\190\140\233\161\175\231\164\186\231\173\137\231\180\154."
--[[Translation missing --]]
L["Play a sound when it pops up."] = "Play a sound when it pops up."
--[[Translation missing --]]
L["Play Sound"] = "Play Sound"
--[[Translation missing --]]
L["Player Class"] = "Player Class"
L["Player Level"] = "\231\142\169\229\174\182\231\173\137\231\180\154"
L["Player level display options."] = "\231\142\169\229\174\182\231\173\137\231\180\154\233\161\175\231\164\186\233\129\184\233\160\133."
L["Player Names"] = "\231\142\169\229\174\182\229\167\147\229\144\141"
--[[Translation missing --]]
L["Player's Average iLvl"] = "Player's Average iLvl"
--[[Translation missing --]]
L["Player's Class"] = "Player's Class"
--[[Translation missing --]]
L["Player's Gender"] = "Player's Gender"
--[[Translation missing --]]
L["Player's Health"] = "Player's Health"
--[[Translation missing --]]
L["Player's Health Deficit"] = "Player's Health Deficit"
--[[Translation missing --]]
L["Player's Health Percent"] = "Player's Health Percent"
--[[Translation missing --]]
L["Players Level"] = "Players Level"
--[[Translation missing --]]
L["Player's Location"] = "Player's Location"
--[[Translation missing --]]
L["Player's Mana"] = "Player's Mana"
--[[Translation missing --]]
L["Player's Mana Deficit"] = "Player's Mana Deficit"
--[[Translation missing --]]
L["Player's Mana Percent"] = "Player's Mana Percent"
--[[Translation missing --]]
L["Player's Max Health"] = "Player's Max Health"
--[[Translation missing --]]
L["Player's Max Mana"] = "Player's Max Mana"
--[[Translation missing --]]
L["Player's Name"] = "Player's Name"
--[[Translation missing --]]
L["Player's X-Coordinate"] = "Player's X-Coordinate"
--[[Translation missing --]]
L["Player's Y-Coordinate"] = "Player's Y-Coordinate"
--[[Translation missing --]]
L["Player's Zone"] = "Player's Zone"
--[[Translation missing --]]
L["Plays a sound when one of your ElvUI keywords is found."] = "Plays a sound when one of your ElvUI keywords is found."
L["Plays a sound, of your choosing (via LibSharedMedia-3.0), whenever a message is received in a given channel."] = "\231\149\182\230\140\135\229\174\154\233\160\187\233\129\147\230\142\165\230\148\182\229\136\176\232\168\138\230\129\175\230\153\130\239\188\140\230\146\165\230\148\190\228\189\160\230\140\135\229\174\154\231\154\132\233\159\179\230\149\136(\233\128\143\233\129\142 LibSharedMedia-3.0)."
--[[Translation missing --]]
L["Plugins by |cff0070deCrackpotx|r"] = "Plugins by |cff0070deCrackpotx|r"
--[[Translation missing --]]
L["Popup"] = "Popup"
--[[Translation missing --]]
L["Popup Messages"] = "Popup Messages"
--[[Translation missing --]]
L["PopupMessage"] = "PopupMessage"
L["power"] = true
--[[Translation missing --]]
L["Prefix Character"] = "Prefix Character"
--[[Translation missing --]]
L["prefix when a message's output is"] = "prefix when a message's output is"
--[[Translation missing --]]
L["PRIEST"] = "PRIEST"
L["Priest"] = "\231\137\167\229\184\171"
L["Print Addon Version"] = "\233\161\175\231\164\186\230\143\146\228\187\182\231\137\136\230\156\172"
--[[Translation missing --]]
L["Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues."] = "Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues."
--[[Translation missing --]]
L["Print this again."] = "Print this again."
--[[Translation missing --]]
L["Prints a link you can click to congratulate when someone obtains an achievement."] = "Prints a link you can click to congratulate when someone obtains an achievement."
L["Prints a message in the chat with your remain XP needed to level up."] = "\229\156\168\232\129\138\229\164\169\232\166\150\231\170\151\228\184\173\233\161\175\231\164\186\228\189\160\233\130\132\233\156\128\229\164\154\229\176\145\231\182\147\233\169\151\229\128\188\228\187\165\229\141\135\231\180\154."
--[[Translation missing --]]
L["Prints module status."] = "Prints module status."
--[[Translation missing --]]
L["Progress Updates"] = "Progress Updates"
L["Provides |cff00ff00/ginv|r, an alternative to |cff00ff00/ginvite|r command, for us lazy folks."] = "\230\143\144\228\190\155 |cff00ff00/ginv|r, \228\184\128\229\128\139\229\130\153\231\148\168 |cff00ff00/ginvite|r \230\140\135\228\187\164, \231\181\166\233\130\163\228\186\155\230\135\182\230\131\176\231\154\132\229\130\162\228\188\153."
--[[Translation missing --]]
L[ [=[Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.

Module Written by Björn Benjamin Hiller <bjoern.hiller@gmail.com>]=] ] = [=[Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.

Module Written by Bj\195\182rn Benjamin Hiller <bjoern.hiller@gmail.com>]=]
L["Provides a /in command to delay the execution of code in macros and other settings."] = "\230\143\144\228\190\155 a /in \230\140\135\228\187\164\228\190\134\230\154\171\231\183\169\229\156\168\229\183\168\233\155\134\230\136\150\229\133\182\228\187\150\232\168\173\229\174\154\228\184\173\231\154\132\230\140\135\228\187\164."
L["Provides a |cff00ff00/gkick|r command, as it should be."] = "\230\143\144\228\190\155 |cff00ff00/gkick|r \230\140\135\228\187\164, \230\156\172\228\190\134\229\176\177\230\135\137\232\169\178\230\156\137\231\154\132."
--[[Translation missing --]]
L["Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically."] = "Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically."
--[[Translation missing --]]
L[ [=[Provides a few tools to help me (Crackpotx), develop this addon as well as diagnose and fix any errors that are reported.

|cff00ff00You can leave this addon disabled unless I (Crackpotx) ask you to enable it for some debugging.|r]=] ] = [=[Provides a few tools to help me (Crackpotx), develop this addon as well as diagnose and fix any errors that are reported.

|cff00ff00You can leave this addon disabled unless I (Crackpotx) ask you to enable it for some debugging.|r]=]
--[[Translation missing --]]
L["Provides basic chat subtitutions."] = "Provides basic chat subtitutions."
L["Provides keybinds to make talking in a specific chat easier."] = "\230\143\144\228\190\155\229\191\171\230\141\183\233\141\181\232\174\147\232\129\138\229\164\169\230\155\180\231\176\161\229\150\174."
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "\230\143\144\228\190\155\233\129\184\233\160\133\228\190\134\228\184\138\232\137\178\232\167\146\232\137\178\229\144\141\231\168\177,\233\161\175\231\164\186\231\142\169\229\174\182\231\173\137\231\180\154,\229\146\140\230\150\176\229\162\158TAB\232\135\170\229\139\149\229\174\140\230\136\144\232\167\146\232\137\178\229\144\141\231\168\177."
L[ [=[Put each emote on a separate line.
Separate the command from the text with a colon (":").]=] ] = [=[\230\138\138\230\175\143\229\128\139\232\161\168\230\131\133\230\148\190\229\156\168\228\184\141\229\144\140\232\161\140.
\231\148\168\229\134\146\232\153\159\229\136\134\233\154\148\230\175\143\229\128\139\230\140\135\228\187\164 (":").]=]
--[[Translation missing --]]
L["Quality"] = "Quality"
L["Quality Notification"] = "\229\147\129\232\179\170\230\143\144\233\134\146"
L["Raid"] = "\229\156\152\233\154\138"
L["Raid Boss Emote"] = "\233\166\150\233\160\152\232\161\168\230\131\133"
L["Raid Channel"] = "\229\156\152\233\154\138\233\160\187\233\129\147"
L["Raid Leader"] = "\229\156\152\233\154\138\233\154\138\233\149\183"
L["Raid Members"] = "\229\156\152\233\154\138\233\154\138\229\147\161"
L["Raid Warning"] = "\229\156\152\233\154\138\232\173\166\229\145\138"
L["Raid Warning Channel"] = "\229\156\152\233\154\138\232\173\166\229\145\138\233\160\187\233\129\147"
--[[Translation missing --]]
L["Random Number"] = "Random Number"
--[[Translation missing --]]
L["Ready Check Command"] = "Ready Check Command"
L["RealID Brackets"] = "RealID \230\139\172\229\188\167"
L["Really remove this word from your trigger list?"] = true
--[[Translation missing --]]
L["Release Command"] = "Release Command"
--[[Translation missing --]]
L["ReloadUI"] = "ReloadUI"
--[[Translation missing --]]
L["Remaining: %s, Cost: $%d"] = "Remaining: %s, Cost: $%d"
--[[Translation missing --]]
L["Reminder"] = "Reminder"
L["Remove"] = true
L["Remove a word from your group invite trigger list"] = true
L["Remove a word from your guild invite trigget list."] = true
L["Remove Group Trigger"] = true
L["Remove Guild Trigger"] = true
--[[Translation missing --]]
L["Removes the combat log chattab from the chat window."] = "Removes the combat log chattab from the chat window."
L["Repeat Command"] = "\233\135\141\232\164\135\230\140\135\228\187\164"
--[[Translation missing --]]
L["Repeat Question"] = "Repeat Question"
--[[Translation missing --]]
L["Repeat the question when giving a response."] = "Repeat the question when giving a response."
--[[Translation missing --]]
L["Replace this channel name with..."] = "Replace this channel name with..."
--[[Translation missing --]]
L["Reply hazy, try again."] = "Reply hazy, try again."
L["Reported by %s"] = true
L["Reputation"] = "\232\129\178\230\156\155"
L["Reputation Color"] = "\232\129\178\230\156\155\233\161\143\232\137\178"
--[[Translation missing --]]
L["Require the alt key to be pressed to use the arrow keys on editboxes."] = "Require the alt key to be pressed to use the arrow keys on editboxes."
L["Reroute Auction Messages"] = "\230\139\141\232\179\163\229\160\180\232\168\138\230\129\175\233\135\141\229\176\142"
--[[Translation missing --]]
L["Reset alt names and their mains."] = "Reset alt names and their mains."
L["Reset ChatFrame text justifications to defaults (left)."] = "\233\135\141\231\189\174\232\129\138\229\164\169\232\166\150\231\170\151\229\176\141\233\189\138\232\135\179\233\160\144\232\168\173\229\128\188 (\229\183\166)."
L["Reset Data"] = "\233\135\141\231\189\174\232\179\135\230\150\153"
L["Reset Font Data"] = true
L["Reset Materials"] = true
--[[Translation missing --]]
L["Reset Names"] = "Reset Names"
--[[Translation missing --]]
L[ [=[Reset saved mains/alts.

|cffff0000This CANNOT be undone.|r]=] ] = [=[Reset saved mains/alts.

|cffff0000This CANNOT be undone.|r]=]
L["Reset Text Justitification"] = "\233\135\141\231\189\174\230\150\135\229\173\151\229\176\141\233\189\138\230\150\185\229\188\143"
L["Resets all chat frames to their original font settings."] = true
L["Right"] = "\233\157\160\229\143\179"
L["Right Bracket"] = "\229\143\179\230\139\172\229\188\167"
--[[Translation missing --]]
L["Right Click"] = "Right Click"
L["Rogue"] = "\231\155\156\232\179\138"
--[[Translation missing --]]
L["ROGUE"] = "ROGUE"
--[[Translation missing --]]
L["Role Poll Command"] = "Role Poll Command"
--[[Translation missing --]]
L["Role Set: %s%s|r"] = "Role Set: %s%s|r"
--[[Translation missing --]]
L["Role will not be set while in combat."] = "Role will not be set while in combat."
L["Roll Color"] = "\230\147\178\233\170\176\233\161\143\232\137\178"
L["Roll Pattern: |cffffff00%s|r"] = "\230\147\178\233\170\176 Pattern: |cffffff00%s|r"
--[[Translation missing --]]
L["'s"] = "'s"
L["Save all /who data"] = true
L["Save class data from /who queries between sessions."] = true
L["Save class data from friends between sessions."] = true
L["Save class data from groups between sessions."] = true
L["Save class data from guild between sessions."] = true
L["Save class data from target/mouseover between sessions."] = true
L["Save Data"] = "\229\132\178\229\173\152\232\179\135\230\150\153"
L["Save data between sessions. Will increase memory usage"] = true
L["Say"] = "\232\170\170"
L["Say Chat"] = true
--[[Translation missing --]]
L["Scrape Time"] = "Scrape Time"
L["Scroll Reminder"] = "\232\135\179\229\186\149\230\140\137\233\136\149"
--[[Translation missing --]]
L["Search"] = "Search"
--[[Translation missing --]]
L["Search Results |cff9382c9(%d Found)|r:"] = "Search Results |cff9382c9(%d Found)|r:"
--[[Translation missing --]]
L["Search Results:"] = "Search Results:"
--[[Translation missing --]]
L["Search term is too short."] = "Search term is too short."
--[[Translation missing --]]
L["Second"] = "Second"
L["Select a color for this channel."] = true
L["Select a method for coloring player names"] = true
--[[Translation missing --]]
L["Select an option if you want the zone list to only contain pets you own or do not own."] = "Select an option if you want the zone list to only contain pets you own or do not own."
--[[Translation missing --]]
L["Select channels"] = "Select channels"
--[[Translation missing --]]
L["Select how you want the player's level colored."] = "Select how you want the player's level colored."
--[[Translation missing --]]
L["Select the channels to apply the filter to."] = "Select the channels to apply the filter to."
--[[Translation missing --]]
L["Select the channels you want monitored."] = "Select the channels you want monitored."
--[[Translation missing --]]
L["Select the channels you want to monitor."] = "Select the channels you want to monitor."
--[[Translation missing --]]
L["Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number."] = "Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number."
L["Select the custom color to use for alt names"] = true
--[[Translation missing --]]
L["Select which channels to flash when a message is received."] = "Select which channels to flash when a message is received."
L["Select which factions you would like to receive notifications for."] = true
--[[Translation missing --]]
L["Self"] = "Self"
--[[Translation missing --]]
L["Semi-Auto Congratulate"] = "Semi-Auto Congratulate"
--[[Translation missing --]]
L["Send a chat message when a role is set/changed."] = "Send a chat message when a role is set/changed."
L["Send a tell to your target."] = true
L["Send a whisper to the person who left."] = true
L["Send Guild Messages"] = true
--[[Translation missing --]]
L["Send guild recruitment messages to various chat channels."] = "Send guild recruitment messages to various chat channels."
L["Send messages to guild chat when someone leaves."] = true
--[[Translation missing --]]
L["Send Reminder"] = "Send Reminder"
L["Send Whisper"] = true
L["Separator"] = "\229\136\134\233\155\162\229\153\168"
--[[Translation missing --]]
L["Set DND"] = "Set DND"
--[[Translation missing --]]
L["Set DND message"] = "Set DND message"
L["Set Main"] = true
L["Set the coloring mode for alt names"] = true
--[[Translation missing --]]
L["Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel."] = "Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel."
--[[Translation missing --]]
L["Set the sound to play."] = "Set the sound to play."
L["Settings"] = true
L["Shaman"] = "\232\150\169\230\187\191"
--[[Translation missing --]]
L["SHAMAN"] = "SHAMAN"
--[[Translation missing --]]
L["Shift + Left Click"] = "Shift + Left Click"
--[[Translation missing --]]
L["Shift + Right Click"] = "Shift + Right Click"
--[[Translation missing --]]
L["Short Format"] = "Short Format"
--[[Translation missing --]]
L["Short format (P for plate, L for leather, ...)"] = "Short format (P for plate, L for leather, ...)"
--[[Translation missing --]]
L["Show Alts"] = "Show Alts"
--[[Translation missing --]]
L["Show Armor Type"] = "Show Armor Type"
L["Show current to total XP percentage."] = true
--[[Translation missing --]]
L["Show current token price at login."] = "Show current token price at login."
--[[Translation missing --]]
L["Show current token price."] = "Show current token price."
--[[Translation missing --]]
L["Show ElvUI Chat Tweaks Config Window"] = "Show ElvUI Chat Tweaks Config Window"
--[[Translation missing --]]
L["Show how many whispers you've received this session."] = "Show how many whispers you've received this session."
--[[Translation missing --]]
L["Show how many whispers, you've received this session."] = "Show how many whispers, you've received this session."
--[[Translation missing --]]
L["Show Main"] = "Show Main"
L["Show Percentage"] = true
L["Show remaining rested XP."] = true
L["Show Rested XP"] = true
--[[Translation missing --]]
L["Show the total number of modules on the datatext."] = "Show the total number of modules on the datatext."
L["Show toon names instead of real names"] = true
L["Show Total XP"] = true
L["Show total XP needed to level."] = true
L["Show welcome message when logging in."] = true
--[[Translation missing --]]
L["Showing Configuration Options"] = "Showing Configuration Options"
--[[Translation missing --]]
L["Shows messages in a popup frame."] = "Shows messages in a popup frame."
--[[Translation missing --]]
L["Signs point to yes."] = "Signs point to yes."
--[[Translation missing --]]
L["Silence in M+"] = "Silence in M+"
--[[Translation missing --]]
L["Silence Learned/Unlearned system messages."] = "Silence Learned/Unlearned system messages."
L["silver"] = true
L["Similar to the |cffffffIn Command|r module, except it will repeat the command X times."] = true
L["Size of the coin icons.  Generally you want to use your font size or smaller."] = true
--[[Translation missing --]]
L["Skipping. Message already advertised by %s"] = "Skipping. Message already advertised by %s"
--[[Translation missing --]]
L["Skipping. Trade: %d LFG: %d"] = "Skipping. Trade: %d LFG: %d"
L["Smart Group Channel"] = true
--[[Translation missing --]]
L["Sound"] = "Sound"
L[ [=[Sound to play when a message in %s is received.

|cff00ff00To disable set to "None"|r.]=] ] = [=[\231\149\182 %s \230\148\182\229\136\176\232\168\138\230\129\175\230\153\130\230\146\165\230\148\190\233\159\179\230\149\136

|cff00ff00\232\166\129\229\129\156\231\148\168\232\171\139\232\168\173\230\136\144 "\231\132\161"|r.]=]
--[[Translation missing --]]
L["Spam CoolDown"] = "Spam CoolDown"
L["Spam Delay"] = true
--[[Translation missing --]]
L["SPAM protection, lines"] = "SPAM protection, lines"
L["Spam Throttle"] = "\231\129\140\230\176\180\233\150\147\233\154\148"
--[[Translation missing --]]
L["Squelch"] = "Squelch"
--[[Translation missing --]]
L["sretteL esreveR"] = "sretteL esreveR"
L["Standard Emote: |cffffff00%s|r"] = true
L["Standard Emotes"] = true
L["Standing Color"] = "\233\154\142\230\174\181\233\161\143\232\137\178"
--[[Translation missing --]]
L["Stopped tracking %s."] = "Stopped tracking %s."
L["Strip RealID brackets"] = true
--[[Translation missing --]]
L["Substitutions"] = "Substitutions"
L["Suppress"] = true
L["Suppress Recount/Skada/TinyDPS output into a clickable link, or filter it entirely."] = true
L["Symbol: |cffffff00%s|r"] = true
--[[Translation missing --]]
L["SYNC_KEY_HELP"] = "SYNC_KEY_HELP"
--[[Translation missing --]]
L["Synchronization key"] = "Synchronization key"
L["Tailoring"] = "\232\163\129\231\184\171"
--[[Translation missing --]]
L["Talent Squelch"] = "Talent Squelch"
L["Talk to your group based on party/raid status."] = true
L["Target/Mouseover"] = "\231\155\174\230\168\153/\230\187\145\233\188\160\230\140\135\229\144\145"
L["Target: |cffffff00%s|r"] = true
--[[Translation missing --]]
L["Target's Class"] = "Target's Class"
--[[Translation missing --]]
L["Target's Gender"] = "Target's Gender"
--[[Translation missing --]]
L["Target's Health"] = "Target's Health"
--[[Translation missing --]]
L["Target's Health Deficit"] = "Target's Health Deficit"
--[[Translation missing --]]
L["Target's Health Percent"] = "Target's Health Percent"
--[[Translation missing --]]
L["Target's Level"] = "Target's Level"
--[[Translation missing --]]
L["Target's Mana"] = "Target's Mana"
--[[Translation missing --]]
L["Target's Mana Deficit"] = "Target's Mana Deficit"
--[[Translation missing --]]
L["Target's Mana Percent"] = "Target's Mana Percent"
--[[Translation missing --]]
L["Target's Max Health"] = "Target's Max Health"
--[[Translation missing --]]
L["Target's Max Mana"] = "Target's Max Mana"
--[[Translation missing --]]
L["Target's Name"] = "Target's Name"
--[[Translation missing --]]
L["taunt"] = "taunt"
--[[Translation missing --]]
L["taunted"] = "taunted"
L["Tell Target"] = "\229\145\138\232\168\180\231\155\174\230\168\153"
--[[Translation missing --]]
L["Test mode"] = "Test mode"
L["Text Justification"] = "\230\150\135\229\173\151\229\176\141\233\189\138"
L["Text justification for ChatFrame %d."] = "\232\129\138\229\164\169\232\166\150\231\170\151 %d \231\154\132\230\150\135\229\173\151\229\176\141\233\189\138\230\150\185\229\188\143."
--[[Translation missing --]]
L["Text to trigger the addon to answer a question."] = "Text to trigger the addon to answer a question."
--[[Translation missing --]]
L[ [=[Thanks for using and supporting my work!  -- |cff0070deCrackpotx|r

|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge.]=] ] = [=[Thanks for using and supporting my work!  -- |cff0070deCrackpotx|r

|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge.]=]
L["The amount of each material you'd like to farm.  If you want an unlimited amount simply put a 0.  You must add a quantity for every entry, and it must correspond to the same line in the other box."] = true
--[[Translation missing --]]
L["The character in front of abbreviations to be recognised as such."] = "The character in front of abbreviations to be recognised as such."
--[[Translation missing --]]
L["The chat window taunts will be announced in when the output is set to"] = "The chat window taunts will be announced in when the output is set to"
--[[Translation missing --]]
L["The classic Magic 8-Ball brought to World of Warcraft!"] = "The classic Magic 8-Ball brought to World of Warcraft!"
--[[Translation missing --]]
L["The color to highlight the search term."] = "The color to highlight the search term."
--[[Translation missing --]]
L["The color to use when highlighting a substitution."] = "The color to use when highlighting a substitution."
L["The default color to use to color names."] = true
--[[Translation missing --]]
L[ [=[The name or ID of the material you'd like to track.

|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r]=] ] = [=[The name or ID of the material you'd like to track.

|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r]=]
--[[Translation missing --]]
L["The name that should be displayed in your chat messages."] = "The name that should be displayed in your chat messages."
L["The percent chance the module has to bid someone farewell.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["The percent chance the module has to congratulate someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["The percent chance the module has to welcome someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["The size of the icon in the chat frame."] = true
L["The time, in seconds, it takes for the same person to trigger the addon again."] = true
L["The time, in seconds, it takes for the same person to trigger the addon by saying ding."] = true
L["These are the keywords that the addon will look for first, when it finds a match then it will look for the actual profession being requested."] = true
--[[Translation missing --]]
L["These channels apply to the General tab only."] = "These channels apply to the General tab only."
L["Thick Outline"] = "\229\142\154\230\143\143\233\130\138"
L[ [=[This addon is designed to add a lot of the functionality of full fledged chat addons like Prat or Chatter, but without a lot of the unneeded bloat.  I wrote it to be as lightweight as possible, while still powerful enough to accomplish it's intended function.
]=] ] = true
--[[Translation missing --]]
L["This add-on will try to prevent spamming to idle channels. If there is no activity in a channel, then it waits a little longer. Specify how many lines should pass before add-on is allowed to announce message."] = "This add-on will try to prevent spamming to idle channels. If there is no activity in a channel, then it waits a little longer. Specify how many lines should pass before add-on is allowed to announce message."
--[[Translation missing --]]
L[ [=[This module adds a command to check your progress on the Keystone Conqueror and Master achievements.

|cff00ff00/ksc|r - Keystone Conqueror Progress
|cff00ff00/ksm|r - Keystone Master Progress
Use |cff00ff00track|r to toggle achievement tracking for each achievement.]=] ] = [=[This module adds a command to check your progress on the Keystone Conqueror and Master achievements.

|cff00ff00/ksc|r - Keystone Conqueror Progress
|cff00ff00/ksm|r - Keystone Master Progress
Use |cff00ff00track|r to toggle achievement tracking for each achievement.]=]
--[[Translation missing --]]
L[ [=[This module is for named channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.

For more information see this addon's Curse page.]=] ] = [=[This module is for named channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.

For more information see this addon's Curse page.]=]
--[[Translation missing --]]
L[ [=[This module is for numbered channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.

For more information see this addon's Curse page.]=] ] = [=[This module is for numbered channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.

For more information see this addon's Curse page.]=]
--[[Translation missing --]]
L[ [=[This module keeps watch on your chat for certain commands and responds accordingly.
Type |cff00ff96!ctk|r or |cff00ff96!keys|r to pull keystone information.]=] ] = [=[This module keeps watch on your chat for certain commands and responds accordingly.
Type |cff00ff96!ctk|r or |cff00ff96!keys|r to pull keystone information.]=]
L["This module will send a chat message every time you loot an item on your list with how many you have, and if applicable it will tell you how many more you need based on your set quantity.  This is useful if you need X amount of Y to be able to cook Z."] = true
--[[Translation missing --]]
L["This will synchronize message and settings between guild members. Latter version of a message will be used by all guild members with synchronization enabled."] = "This will synchronize message and settings between guild members. Latter version of a message will be used by all guild members with synchronization enabled."
--[[Translation missing --]]
L["Throttle"] = "Throttle"
L["Throttle Interval"] = true
L["Throttle Messages"] = true
L["Throttle output messages to prevent spam."] = true
--[[Translation missing --]]
L["Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable."] = "Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable."
--[[Translation missing --]]
L["Throttle Time"] = "Throttle Time"
--[[Translation missing --]]
L["Throttle time prevented %s update."] = "Throttle time prevented %s update."
--[[Translation missing --]]
L[ [=[Throttle to only answer a question every X seconds, to prevent spam.

|cffff0000Not recommended to disable this.|r]=] ] = [=[Throttle to only answer a question every X seconds, to prevent spam.

|cffff0000Not recommended to disable this.|r]=]
--[[Translation missing --]]
L["Time"] = "Time"
L["Time, in seconds, in between running the command."] = true
L[ [=[Time, in seconds, the module will wait after the first line is found to assume it is complete.

|cffffff00One (1) second seems to work.|r]=] ] = true
L["Time, in seconds, to throttle output messages to prevent spam."] = true
--[[Translation missing --]]
L["Time, in seconds, to throttle the zone list to prevent any spam."] = "Time, in seconds, to throttle the zone list to prevent any spam."
--[[Translation missing --]]
L["Time, in seconds, you want the search to continue before it ends."] = "Time, in seconds, you want the search to continue before it ends."
L["Timestamp color"] = "\230\153\130\233\150\147\230\136\179\232\168\152\233\161\143\232\137\178"
L["Timestamp format"] = "\230\153\130\233\150\147\230\136\179\232\168\152\230\160\188\229\188\143"
L["Timestamps"] = "\230\153\130\233\150\147\230\136\179\232\168\152"
--[[Translation missing --]]
L["To (|HBNplayer.-|h):"] = "To (|HBNplayer.-|h):"
--[[Translation missing --]]
L["To (|Hplayer.-|h):"] = "To (|Hplayer.-|h):"
--[[Translation missing --]]
L["To <Away>(|HBNplayer.-|h):"] = "To <Away>(|HBNplayer.-|h):"
--[[Translation missing --]]
L["To <Busy>(|HBNplayer.-|h):"] = "To <Busy>(|HBNplayer.-|h):"
L["TOC Version: |cff1784d1%s|r"] = "TOC \231\137\136\230\156\172: |cff1784d1%s|r"
--[[Translation missing --]]
L["Toggle Actionbar Keybinds"] = "Toggle Actionbar Keybinds"
--[[Translation missing --]]
L["Toggle Anchors"] = "Toggle Anchors"
L["Toggle coloring and change of the chat frame for pet combat log messages."] = "\233\150\139\229\149\159\228\184\138\232\137\178\228\184\166\228\184\148\229\136\135\230\143\155\229\176\141\232\169\177\232\166\150\231\170\151\232\135\179\229\175\181\231\137\169\230\136\176\233\172\165\231\180\128\233\140\132."
L["Toggle coloring and changing of the chat frame for pet battle info messages."] = "\233\150\139\229\149\159\228\184\138\232\137\178\228\184\166\228\184\148\229\136\135\230\143\155\229\176\141\232\169\177\232\166\150\231\170\151\232\135\179\229\175\181\231\137\169\229\176\141\230\136\176\232\168\138\230\129\175."
--[[Translation missing --]]
L["Toggle the monitoring of chat events."] = "Toggle the monitoring of chat events."
--[[Translation missing --]]
L["Toggle the pet list message when you enter a different zone."] = "Toggle the pet list message when you enter a different zone."
L["Toggle the pet quality notifications when you join a wild pet battle."] = "\231\149\182\228\189\160\233\128\178\232\161\140\233\135\142\229\164\150\229\175\181\231\137\169\229\176\141\230\136\176\230\153\130\230\143\144\231\164\186\229\176\141\233\157\162\229\175\181\231\137\169\229\147\129\232\179\170."
--[[Translation missing --]]
L["Toggle the requirement of the Alt key to be pressed to use arrow keys to navigate an editbox."] = "Toggle the requirement of the Alt key to be pressed to use arrow keys to navigate an editbox."
--[[Translation missing --]]
L["Token Price"] = "Token Price"
--[[Translation missing --]]
L["Tooltip"] = "Tooltip"
--[[Translation missing --]]
L["Total Cost: $%d"] = "Total Cost: $%d"
--[[Translation missing --]]
L["Total Modules"] = "Total Modules"
L["Track Pets"] = "\232\191\189\232\185\164\229\175\181\231\137\169"
L["Track Stable Masters"] = "\232\191\189\232\185\164\230\136\176\229\175\181\229\164\167\229\184\171"
--[[Translation missing --]]
L["Tracking %s."] = "Tracking %s."
--[[Translation missing --]]
L["Trigger"] = "Trigger"
--[[Translation missing --]]
L["Trigger Chat"] = "Trigger Chat"
--[[Translation missing --]]
L["Trigger Loots"] = "Trigger Loots"
L["Triggers"] = "\232\167\184\231\153\188\229\153\168"
--[[Translation missing --]]
L[ [=[Turns the timestamps into a link.

Click the link to copy the chat line.
Shift+Click the link to send the line to the last chat you used.]=] ] = [=[Turns the timestamps into a link.

Click the link to copy the chat line.
Shift+Click the link to send the line to the last chat you used.]=]
--[[Translation missing --]]
L["Type DND message there."] = "Type DND message there."
--[[Translation missing --]]
L["Type the message to announce, every line will be announced. Message should not be longer than 2 lines."] = "Type the message to announce, every line will be announced. Message should not be longer than 2 lines."
--[[Translation missing --]]
L["Unable to load the Alt Name module, please try again."] = "Unable to load the Alt Name module, please try again."
L["Unbalanced parameter count. Trailing Symbol: |cffffff00%s|r"] = true
--[[Translation missing --]]
L["Unowned Only"] = "Unowned Only"
L["Unrecognized Symbol: |cffffff00%s|r"] = "\231\132\161\230\179\149\232\190\168\232\170\141\231\154\132\231\172\166\232\153\159: |cffffff00%s|r"
L["Unset variable |cffffff00%s|r."] = "\230\156\170\232\168\173\229\174\154\229\190\151\232\174\138\230\149\184 |cffffff00%s|r."
--[[Translation missing --]]
L["Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement."] = "Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement."
--[[Translation missing --]]
L["Uppercase"] = "Uppercase"
--[[Translation missing --]]
L["Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."] = "Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."
--[[Translation missing --]]
L["Use Alt Key"] = "Use Alt Key"
L["Use channel color"] = "\228\189\191\231\148\168\233\160\187\233\129\147\233\161\143\232\137\178"
L["Use Channel Color"] = "\228\189\191\231\148\168\233\160\187\233\129\147\233\161\143\232\137\178"
L["Use Coins"] = "\228\189\191\231\148\168\231\161\172\229\185\163\229\156\150\231\164\186"
L["Use coins in the answers instead of abbreviations."] = "\231\173\148\230\161\136\228\189\191\231\148\168\231\161\172\229\185\163\229\156\150\231\164\186\230\155\191\228\187\163\231\184\174\229\175\171."
L["Use Custom Color"] = "\228\189\191\231\148\168\232\135\170\232\168\130\233\161\143\232\137\178"
L["Use guildnotes"] = "\228\189\191\231\148\168\229\133\172\230\156\131\232\168\187\232\168\152"
L["Use Level Threshold"] = "\228\189\191\231\148\168\231\173\137\231\180\154\233\150\128\230\170\187"
--[[Translation missing --]]
L["Use Master Channel"] = "Use Master Channel"
L["Use PlayerNames Coloring"] = "\228\189\191\231\148\168\232\167\146\232\137\178\229\144\141\231\168\177\228\184\138\232\137\178"
--[[Translation missing --]]
L["Use Short Name"] = "Use Short Name"
L["Use Tab Complete"] = "\228\189\191\231\148\168\232\135\170\229\139\149\229\174\140\230\136\144"
L["Use tab key to automatically complete character names."] = "\228\189\191\231\148\168 tab \230\140\137\233\136\149\232\135\170\229\139\149\229\174\140\230\136\144\232\167\146\232\137\178\229\167\147\229\144\141."
--[[Translation missing --]]
L["Use the master channel when playing the sound."] = "Use the master channel when playing the sound."
--[[Translation missing --]]
L["Use this key to separate sync settings for different groups of peoples. Leave empty for default."] = "Use this key to separate sync settings for different groups of peoples. Leave empty for default."
--[[Translation missing --]]
L["using"] = "using"
L["Valid Events"] = "\230\156\137\230\149\136\228\186\139\228\187\182"
L["valor"] = true
--[[Translation missing --]]
L["Valor Points"] = "Valor Points"
--[[Translation missing --]]
L["Variable |cffffff00%s|r is set to |cff00ff00%s|r."] = "Variable |cffffff00%s|r is set to |cff00ff00%s|r."
--[[Translation missing --]]
L["Variable |cffffff00%s|r set to |cff00ff00%s|r."] = "Variable |cffffff00%s|r set to |cff00ff00%s|r."
--[[Translation missing --]]
L["Various Developer Tools"] = "Various Developer Tools"
--[[Translation missing --]]
L["Version"] = "Version"
--[[Translation missing --]]
L["Version %s%s|r is loaded. Type %s/ct|r if you need help."] = "Version %s%s|r is loaded. Type %s/ct|r if you need help."
L["Version: |cff1784d1%s|r"] = "\231\137\136\230\156\172: |cff1784d1%s|r"
--[[Translation missing --]]
L["Very doubtful."] = "Very doubtful."
L["vp"] = true
L["vpcap"] = true
L["Warlock"] = "\232\161\147\229\163\171"
--[[Translation missing --]]
L["WARLOCK"] = "WARLOCK"
--[[Translation missing --]]
L["WARRIOR"] = "WARRIOR"
L["Warrior"] = "\230\136\176\229\163\171"
L["Welcome Message"] = true
L["Welcome Messages"] = "\230\173\161\232\191\142\232\168\138\230\129\175"
L["What to do with Recount/Skada/TinyDPS reports in this channel."] = "\229\166\130\228\189\149\229\176\135Recount/Skada/TinyDPS\230\136\176\233\172\165\232\168\138\230\129\175\232\178\188\232\135\179\230\173\164\233\160\187\233\129\147"
--[[Translation missing --]]
L["What to show on the datatext."] = "What to show on the datatext."
--[[Translation missing --]]
L["When an ElvUI keyword is found it will show the message in a popup frame."] = "When an ElvUI keyword is found it will show the message in a popup frame."
L["When setting a variable the variable name must be the first parameter."] = "\232\168\173\229\174\154\229\143\131\230\149\184\230\153\130\229\143\131\230\149\184\229\144\141\229\191\133\233\160\136\231\130\186\231\172\172\228\184\128\229\128\139\232\174\138\230\149\184."
--[[Translation missing --]]
L["When Talented Changes Talents"] = "When Talented Changes Talents"
--[[Translation missing --]]
L["Where AOE Taunts will be announced."] = "Where AOE Taunts will be announced."
--[[Translation missing --]]
L["Where taunts will be announced."] = "Where taunts will be announced."
--[[Translation missing --]]
L["Where the taunt fails will be announced."] = "Where the taunt fails will be announced."
L["Whisper"] = "\229\175\134\232\170\158"
--[[Translation missing --]]
L["Whisper Answer"] = "Whisper Answer"
L["Whisper Messages"] = "\229\175\134\232\170\158\232\168\138\230\129\175"
L["Whisper Options"] = "\229\175\134\232\170\158\233\129\184\233\160\133"
--[[Translation missing --]]
L["Whisper the response to the person.  Otherwise it will be answered in the same channel the request was sent."] = "Whisper the response to the person.  Otherwise it will be answered in the same channel the request was sent."
L["Whispers"] = "\229\175\134\232\170\158\232\128\133"
--[[Translation missing --]]
L["Who"] = "Who"
--[[Translation missing --]]
L["Who is %s's main?"] = "Who is %s's main?"
--[[Translation missing --]]
L["Who Taunted"] = "Who Taunted"
--[[Translation missing --]]
L["Who to Congratulate?"] = "Who to Congratulate?"
--[[Translation missing --]]
L["Who Whispered Me"] = "Who Whispered Me"
L["Who: |cffffff00%s|r, Roll: |cffffff00%s|r, Min: |cffffff00%s|r, Max: |cffffff00%s|r"] = "\232\170\176: |cffffff00%s|r, \233\170\176\229\135\186: |cffffff00%s|r, \230\156\128\229\176\143: |cffffff00%s|r, \230\156\128\229\164\167: |cffffff00%s|r"
--[[Translation missing --]]
L["Will automatically set your role based on your spec, when appropriate."] = "Will automatically set your role based on your spec, when appropriate."
L["Will save all data for large /who queries"] = true
L["Win Color"] = "\229\139\157\229\136\169\233\161\143\232\137\178"
--[[Translation missing --]]
L["Without a doubt."] = "Without a doubt."
L["XP Left To Level"] = "\229\137\169\233\164\152\231\182\147\233\169\151\229\128\188"
--[[Translation missing --]]
L["Year"] = "Year"
L["Yell"] = "\229\164\167\229\150\138"
L["Yell Chat"] = true
--[[Translation missing --]]
L["Yes"] = "Yes"
--[[Translation missing --]]
L["Yes, definitely."] = "Yes, definitely."
--[[Translation missing --]]
L["You are missing %s%d|r pets."] = "You are missing %s%d|r pets."
L["You are running version |cff1784d1%s|r."] = "\228\189\160\230\173\163\229\156\168\228\189\191\231\148\168\231\137\136\230\156\172 |cff1784d1%s|r."
--[[Translation missing --]]
L["You asked: %s"] = "You asked: %s"
L["You can only send a request once every %d seconds.  You last sent a request at %s."] = "\228\189\160\230\175\143 %d \231\167\146\230\137\141\232\131\189\233\128\129\229\135\186\228\184\128\229\128\139\232\168\138\230\129\175. \228\189\160\230\156\128\229\190\140\228\184\128\230\172\161\233\128\129\229\135\186\232\168\138\230\129\175\230\152\175\229\156\168 %s."
--[[Translation missing --]]
L["You can use $gname tag in text. This will be replaced by your guild name."] = "You can use $gname tag in text. This will be replaced by your guild name."
--[[Translation missing --]]
L["You have %s%d (%d unique, %d duplicates)|r pets."] = "You have %s%d (%d unique, %d duplicates)|r pets."
--[[Translation missing --]]
L["You have %s%d|r duplicate pets."] = "You have %s%d|r duplicate pets."
--[[Translation missing --]]
L["You have %s%d|r mounts."] = "You have %s%d|r mounts."
--[[Translation missing --]]
L["You have %s%d|r unique pets."] = "You have %s%d|r unique pets."
L["You have |cff%s%d|r of %s, you need |cff%s%d|r more. |cff%s(%d/%d)|r"] = "\228\189\160\230\156\137 |cff%s%d|r \229\128\139 %s, \228\189\160\233\130\132\233\156\128\232\166\129 |cff%s%d|r \229\128\139. |cff%s(%d/%d)|r"
L["You have |cff%s%d|r of %s."] = "\228\189\160\230\156\137 |cff%s%d|r \229\128\139 %s."
--[[Translation missing --]]
L["You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it."] = "You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it."
--[[Translation missing --]]
L["You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it."] = "You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it."
--[[Translation missing --]]
L["You have already completed %s."] = "You have already completed %s."
L["You have met your quota of %s%s. |cff%s(%d/%d)|r"] = "%s%s\228\189\160\229\183\178\231\182\147\233\129\148\229\136\176\228\189\160\230\131\179\232\166\129\231\154\132\230\149\184\233\135\143. |cff%s(%d/%d)|r"
--[[Translation missing --]]
L["You may rely on it."] = "You may rely on it."
L["You must provide a calculation or set a variable."] = "\228\189\160\229\191\133\233\160\136\232\188\184\229\133\165\228\184\128\229\128\139\231\174\151\229\188\143\230\136\150\232\128\133\228\184\128\231\181\132\232\174\138\230\149\184."
L["You need %s%s%s%sto hit level %d."] = "\228\189\160\233\156\128\232\166\129 %s%s%s%s\228\190\134\230\147\138\228\184\173\231\173\137\231\180\154 %d."
--[[Translation missing --]]
L["You Need To Move"] = "You Need To Move"
L["Your Color"] = "\228\189\160\231\154\132\233\161\143\232\137\178"
L["Your version of %s is out of date.  Latest version is |cff1784d1%d|r."] = "\228\189\160\228\189\191\231\148\168\231\154\132\231\137\136\230\156\172 %s \229\183\178\231\182\147\233\129\142\230\156\159.  \230\156\128\230\150\176\231\137\136\230\156\172\230\152\175 |cff1784d1%d|r."
L["Your Version: |cffffff00%d|r, Latest Version: |cffffff00%d|r"] = "\228\189\160\231\154\132\231\137\136\230\156\172: |cffffff00%d|r, \230\156\128\230\150\176\231\137\136\230\156\172: |cffffff00%d|r"
--[[Translation missing --]]
L["Yours"] = "Yours"
--[[Translation missing --]]
L["Zone List"] = "Zone List"

