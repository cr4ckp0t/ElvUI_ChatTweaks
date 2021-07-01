-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Crackpot (US, Thrall)
-------------------------------------------------------------------------------
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI_ChatTweaks", "deDE", false)
if not L then return end

L["   |cff00ff00%s|r - %s"] = true
L["   |cff00ff00%s|r or |cff00ff00%s|r - %s"] = "   |cff00ff00%s|r oder |cff00ff00%s|r - %s"
L["   |cff00ff00/ct %s|r - %s"] = true
--[[Translation missing --]]
L["   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s"] = "   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s"
L[ [=[  Achievement Points
]=] ] = [=[  Erfolgspunkte
]=]
L[ [=[  Conquest Points
]=] ] = [=[  Eroberungspunkte
]=]
L[ [=[  Honor Points
]=] ] = [=[  Ehrenpunkte
]=]
L[ [=[  Justice Points
]=] ] = [=[  Gerechtigkeitspunkte
]=]
L[ [=[  Valor Points
]=] ] = [=[  Tapferkeitspunkte
]=]
--[[Translation missing --]]
L[" %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"] = " %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"
--[[Translation missing --]]
L[" |cFFff5a00(Upgrade)|r"] = " |cFFff5a00(Upgrade)|r"
L[" |cffffff00%d|r Total Modules (|cff00ff00%d|r Enabled, |cffff0000%d|r Disabled)"] = " |cffffff00%d|r Anzahl der Module (|cff00ff00%d|rAktiviert, |cffff0000%d|r Deaktiviert)"
--[[Translation missing --]]
L[" isn't a number."] = " isn't a number."
--[[Translation missing --]]
L[" isn't a recognized variable or number."] = " isn't a recognized variable or number."
--[[Translation missing --]]
L[ [=[

|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.]=] ] = [=[

|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.]=]
L[ [=[

|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.

Addon Usage: |cff00ff00%s|r]=] ] = [=[|cffff0000NOTE:|r  Wenn dieses Addon anf\195\164ngt eine erhebliche Menge an Speicher zu verbrauchen, einfach die Namensdaten zur\195\188cksetzen und es wird auf ein normales Niveau zur\195\188ckkehren.

Addon Verbrauch: |cff00ff00%s|r]=]
--[[Translation missing --]]
L["$EMPTY$"] = "$EMPTY$"
--[[Translation missing --]]
L["% Owned"] = "% Owned"
--[[Translation missing --]]
L["% Unowned"] = "% Unowned"
--[[Translation missing --]]
L[ [=[%s  Conquest Cap
]=] ] = [=[%s  Conquest Cap
]=]
--[[Translation missing --]]
L[ [=[%s  Justice Cap
]=] ] = [=[%s  Justice Cap
]=]
--[[Translation missing --]]
L[ [=[%s  Valor Cap
]=] ] = [=[%s  Valor Cap
]=]
--[[Translation missing --]]
L["%s or %s"] = "%s or %s"
--[[Translation missing --]]
L["%s reputation left until %s with %s."] = "%s reputation left until %s with %s."
--[[Translation missing --]]
L["%s reputation needed until %s with %s."] = "%s reputation needed until %s with %s."
--[[Translation missing --]]
L[ [=[%s, %s, %s  Player's Money
]=] ] = [=[%s, %s, %s  Player's Money
]=]
--[[Translation missing --]]
L[ [=[%s, %s, %s  Player's Stats
]=] ] = [=[%s, %s, %s  Player's Stats
]=]
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
--[[Translation missing --]]
L[", removing from list"] = ", removing from list"
L["/tt"] = true
--[[Translation missing --]]
L["|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"] = "|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"
--[[Translation missing --]]
L["|cff00ff00%d|r Custom %s Being Used"] = "|cff00ff00%d|r Custom %s Being Used"
--[[Translation missing --]]
L["|cff00ff00%s|r"] = "|cff00ff00%s|r"
--[[Translation missing --]]
L["|cff00ff00%s|r %s"] = "|cff00ff00%s|r %s"
L["|cff00ff00%s|r or |cff00ff00%s|r %s"] = "|cff00ff00%s|r oder |cff00ff00%s|r %s"
--[[Translation missing --]]
L["|cff00ff00%s|r or |cff00ff00%s|r or |cff00ff00%s|r"] = "|cff00ff00%s|r or |cff00ff00%s|r or |cff00ff00%s|r"
L["|cff00ff00Enabled|r"] = "|cff00ff00Aktiviert|r"
--[[Translation missing --]]
L["|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r"] = "|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r"
--[[Translation missing --]]
L["|cFF5cb4f8Pet Battle - Tale of the Tape|r"] = "|cFF5cb4f8Pet Battle - Tale of the Tape|r"
--[[Translation missing --]]
L["|cffc7c7cfs|r"] = "|cffc7c7cfs|r"
--[[Translation missing --]]
L["|cFFccff00Not Owned|r"] = "|cFFccff00Not Owned|r"
--[[Translation missing --]]
L["|cffeda55fc|r"] = "|cffeda55fc|r"
L["|cffff0000Disabled|r"] = "|cffff0000Deaktiviert|r"
L["|cffff0000Item|r |cffffffff\"%s\"|r |cffff0000does not exist.|r"] = "|cffff0000Item|r |cffffffff\"%s\"|r |cffff0000existiert nicht.|r"
L["|cffff0000No modules found.|r"] = "|cffff0000Es wurden keine Module gefunden.|r"
--[[Translation missing --]]
L["|cffff0000The Chat Frame you chose to output reputation changes,|r |cffffffff%s|r|cffff0000, does not exist."] = "|cffff0000The Chat Frame you chose to output reputation changes,|r |cffffffff%s|r|cffff0000, does not exist."
--[[Translation missing --]]
L["|cffff9000Not in Pet Journal|r"] = "|cffff9000Not in Pet Journal|r"
--[[Translation missing --]]
L["|cffff9000Pet Journal:|r %s"] = "|cffff9000Pet Journal:|r %s"
--[[Translation missing --]]
L["|cffffc080Alts:|r %s"] = "|cffffc080Alts:|r %s"
--[[Translation missing --]]
L["|cffffd700g|r"] = "|cffffd700g|r"
L["|cffffff00Character already in a guild."] = "|cffffff00Der Charakter befindet sich bereits in einer Gilde."
L["|cffffff00Character already in your guild."] = "|cffffff00Der Charakter befindet sich bereits in deiner Gilde."
--[[Translation missing --]]
L["|cffffff00This abbreviation is unknown."] = "|cffffff00This abbreviation is unknown."
L["|cffffff00Unable to execute secure command.|r |cffffffff%s|r"] = "|cffffff00Kann sicheren Befehl nicht ausf\195\188hren.|r |cffffffff%s|r"
--[[Translation missing --]]
L["|cffffff00Usage: /ccolor <class>|r"] = "|cffffff00Usage: /ccolor <class>|r"
--[[Translation missing --]]
L["|cffffff00Usage: /fake <id or link> <date in MM/DD/YY format>|r"] = "|cffffff00Usage: /fake <id or link> <date in MM/DD/YY format>|r"
L["|cffffff00Usage: /ginvite <name>|r"] = "|cffffff00Verwendung: /ginvite <name>|r"
L["|cffffff00Usage: /gkick <name>|r"] = true
--[[Translation missing --]]
L["|cffffff00Usage: /hextorgb <hex code>|r"] = "|cffffff00Usage: /hextorgb <hex code>|r"
L["|cffffff00Usage: /in <delay> <command>|r"] = "|cffffff00Verwendung: /in <Verz\195\182gerung> <Befehl>|r"
--[[Translation missing --]]
L["|cffffff00Usage: /rgbtohex <red> <green> <blue>|r"] = "|cffffff00Usage: /rgbtohex <red> <green> <blue>|r"
L["|cffffff00Usage: /rpt <times> <command>|r"] = "|cffffff00Verwendung: /rpt <Zeit> <Befehl>|r"
--[[Translation missing --]]
L["|cffffffffYou have %s.|r"] = "|cffffffffYou have %s.|r"
--[[Translation missing --]]
L["<ElvUI_CTC>"] = "<ElvUI_CTC>"
--[[Translation missing --]]
L["<no location>"] = "<no location>"
--[[Translation missing --]]
L["<notarget>"] = "<notarget>"
--[[Translation missing --]]
L[ [=[A simple calculator used to perform basic operations on gold values.  Providing no parameters will show you how much gold you have.

You can include your current gold amount by using the |cff00ff00mymoney|r keyword.  For example |cff00ff00mymoney * 2|r.

|cffff0000Money amounts can only be added or subtracted, multiplication or division can only be performed with money and a number.  For example:  4g * 4 is okay, where 4g * 4g is invalid.]=] ] = [=[A simple calculator used to perform basic operations on gold values.  Providing no parameters will show you how much gold you have.

You can include your current gold amount by using the |cff00ff00mymoney|r keyword.  For example |cff00ff00mymoney * 2|r.

|cffff0000Money amounts can only be added or subtracted, multiplication or division can only be performed with money and a number.  For example:  4g * 4 is okay, where 4g * 4g is invalid.]=]
--[[Translation missing --]]
L[ [=[A simple command-line calculator.  Certain keywords, listed below, can be used and their in game value will be substituted.  You can also assign variables which are saved for later use.

|cffffff00Keywords:|r
]=] ] = [=[A simple command-line calculator.  Certain keywords, listed below, can be used and their in game value will be substituted.  You can also assign variables which are saved for later use.

|cffffff00Keywords:|r
]=]
--[[Translation missing --]]
L["A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears."] = "A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears."
--[[Translation missing --]]
L["A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r."] = "A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r."
--[[Translation missing --]]
L["A Test of Valor"] = "A Test of Valor"
--[[Translation missing --]]
L["Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN."] = "Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN."
L["Abbreviations"] = "Abk\195\188rzungen"
L["achieve"] = "erreichen"
L["Achievement Filter"] = "Erfolgsfilter"
--[[Translation missing --]]
L["Achievement for %s%s|r: %s"] = "Achievement for %s%s|r: %s"
L["Achievement Messages"] = "Erfolgs Nachrichten"
--[[Translation missing --]]
L["Activate in 5-man instances."] = "Activate in 5-man instances."
--[[Translation missing --]]
L["Activate in guild."] = "Activate in guild."
--[[Translation missing --]]
L["Active in your selected community"] = "Active in your selected community"
L["Active Modules"] = "Aktive Module"
L["Add |cff00ff00/emotes|r Command"] = "F\195\188gt einen |cff00ff00/emotes|r Befehl hinzu."
L["Add an |cff00ff00/emotes|r command to see what custom emotes you currently have running."] = "F\195\188ge einen |cff00ff00/emotes|r Befehl hinzu um zu sehen, welche Emotes Du derzeit benutzt."
L[ [=[Add custom emotes.  Please remember that your character's name will always be the first word.

|cff00ff00%t|r is your current target.]=] ] = [=[F\195\188gt Benutzer-Emotes hinzu. Bitte dran denken, dass der Charaktername immer das erste Wort ist.

|cff00ff00%t|r ist dein aktuelles Ziel.]=]
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
L["Add Group Trigger"] = "Gruppen Ausl\195\182ser hinzuf\195\188gen"
L["Add Guild Trigger"] = "Gilden Ausl\195\182ser hinzuf\195\188gen"
--[[Translation missing --]]
L["Add item icons to loot received messages."] = "Add item icons to loot received messages."
--[[Translation missing --]]
L["Add Percentage"] = "Add Percentage"
--[[Translation missing --]]
L["Add space after channels"] = "Add space after channels"
L["Add surrounding brackets to own charname in messages."] = "Den eigenen Charakternamen in Nachrichten in Klammern setzen."
--[[Translation missing --]]
L["Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it."] = "Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it."
--[[Translation missing --]]
L["Add the player's alts to the tooltip."] = "Add the player's alts to the tooltip."
--[[Translation missing --]]
L["Add the player's main to the tooltip."] = "Add the player's main to the tooltip."
--[[Translation missing --]]
L["Add word to your group invite trigger list"] = "Add word to your group invite trigger list"
--[[Translation missing --]]
L["Add word to your guild invite trigger list."] = "Add word to your guild invite trigger list."
--[[Translation missing --]]
L["Addon enabled, but no message or channels selected."] = "Addon enabled, but no message or channels selected."
L["Addon Messages"] = "Addon Nachrichten"
L["Addon Version Sent, Version: |cffffff00%s|r"] = "Addon Version wurde gesendet, die Version lautet: |cffffff00%s|r"
--[[Translation missing --]]
L["Adds a |cff00ff00/fake|r command for generating fake achievements."] = "Adds a |cff00ff00/fake|r command for generating fake achievements."
--[[Translation missing --]]
L[ [=[Adds a gamemenu button.

|cffffff00To disable the button, simply disable this module.

Please do a full reload after disable or enable.|r]=] ] = [=[Adds a gamemenu button.

|cffffff00To disable the button, simply disable this module.

Please do a full reload after disable or enable.|r]=]
L[ [=[Adds a minimap button.

|cffffff00To disable the button, simply disable this module.|r]=] ] = "F\195\188gt Minimap-Button hinzu."
L["Adds a timestamp to each line of text."] = "F\195\188gt einen Zeitstempel zu jeder Textzeile hinzu."
--[[Translation missing --]]
L["Adds an ElvUI datatext for this addon."] = "Adds an ElvUI datatext for this addon."
--[[Translation missing --]]
L["Adds chat commands |cff1784d1/chatframes|r and |cff1784d1/cf|r to help you identify the chat frames and their numbers."] = "Adds chat commands |cff1784d1/chatframes|r and |cff1784d1/cf|r to help you identify the chat frames and their numbers."
L[ [=[Adds chat commands to clear the chat windows.

]=] ] = "F\195\188gt Chat-Kommandos zum Leeren der Chatfenster hinzu."
--[[Translation missing --]]
L[ [=[Adds chat commands to show the current server token price in the chat windows.

]=] ] = [=[Adds chat commands to show the current server token price in the chat windows.

]=]
--[[Translation missing --]]
L[ [=[Adds item links to Auction House messages.  Enabling this module will automatically disable the Auction Message Filter module.

|cffff0000If you do not have the item in your bags at the time of the system message firing then this will not be able to get the item link.  This is a limitation of the|r |cffffff00GetItemInfo()|r |cffff0000API function.  If this occurs, then the module will simple pass through the default message.|r]=] ] = [=[Adds item links to Auction House messages.  Enabling this module will automatically disable the Auction Message Filter module.

|cffff0000If you do not have the item in your bags at the time of the system message firing then this will not be able to get the item link.  This is a limitation of the|r |cffffff00GetItemInfo()|r |cffff0000API function.  If this occurs, then the module will simple pass through the default message.|r]=]
--[[Translation missing --]]
L["Adds itemlevel to linked items in chat messages."] = "Adds itemlevel to linked items in chat messages."
L["Adds tell target slash command, |cff00ff00/tt|r."] = "F\195\188gt einen \"Das Ziel anfl\195\188stern\"-Befehl |cff00ff00/tt|r hinzu."
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
L["AFK"] = true
L["AFK Messages"] = "AFK Nachrichten"
L["AFK/DND Filter"] = true
L["After"] = "Danach"
--[[Translation missing --]]
L["against"] = "against"
L["Alchemy"] = "Alchemie"
L["All"] = "Alle"
L["All Modules"] = "Alle Module"
--[[Translation missing --]]
L["AllCommunity"] = "AllCommunity"
--[[Translation missing --]]
L["Allow guild synchronization"] = "Allow guild synchronization"
L["Allow someone to request a link of all your professions."] = "Erlaubt anderen, dir eine Anfrage f\195\188r die Verlinkung von all deinen Berufen zu schicken."
L[ [=[Allows you to change the default font settings for the chat frames.

|cffff0000Using another addon to do this will break this functionality.|r]=] ] = [=[Erlaubt eine \195\132nderung des vorgegebenen Zeichensatzes f\195\188r Chatfenster.

|cffff0000Die Nutzung eines anderen AddOns mit selbem Effekt, wird zu einem Fehler f\195\188hren.|r]=]
--[[Translation missing --]]
L["Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command."] = "Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command."
--[[Translation missing --]]
L[ [=[Allows you to color the pet battle info messages, and determine which chat frame to send them to.

I am aware that some of the features of this module don't really pertain to the chat, but I couldn't really justify an entirely new addon.  So I just snuck them into here.]=] ] = [=[Allows you to color the pet battle info messages, and determine which chat frame to send them to.

I am aware that some of the features of this module don't really pertain to the chat, but I couldn't really justify an entirely new addon.  So I just snuck them into here.]=]
L["Allows you to reroute auction house messages to a different chat frame."] = "Erlaubt es dir, Auktionshaus-Nachrichten in ein anderes Chatfenster umzuleiten."
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
L["Alt Names"] = "Twink Namen"
--[[Translation missing --]]
L["Alt note fallback"] = "Alt note fallback"
L["alt2"] = true
L["alt3"] = true
L["Alt-click name to invite"] = "Alt-Klick auf den Namen zum Einladen"
L["Alternate command to kick someone from guild."] = "Alternatives Kommando um jemanden aus der Gilde zu entfernen."
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
L["ap"] = "AP"
L["Are you sure you want to delete all your saved class/level data?"] = "Bist du sicher, dass du alle gespeicherten Klassen-/Stufendaten l\195\182schen m\195\182chtest?"
L["Are you sure you want to disable all of the modules?"] = "Bist Du sicher, dass Du alle Module deaktivieren m\195\182chtest?"
L["Are you sure you want to enable all of the modules?"] = "Bist Du sicher, dass Du alle Module aktivieren m\195\182chtest?"
L["Are you sure you want to reset the chat fonts to defaults?"] = "Bist du sicher, dass du die Chat-Schriftart zur\195\188ck auf den Standard setzen m\195\182chtest?"
L["As I see it, yes."] = "So wie ich es sehe, ja."
L["Ask again later."] = "Sp\195\164ter nochmal fragen."
--[[Translation missing --]]
L["Auction Created"] = "Auction Created"
L["Auction Expired"] = "Auktion abgelaufen"
L["Auction Message Filtering"] = "Auktionsnachrichten filtern"
L["Auction Message Types"] = "Auktionsnachrichten-Typen"
L["Auction Outbid"] = "Auktion \195\156berboten"
L["Auction Removed"] = "Auktion Entfernt"
L["Auction Sold"] = "Auktion Verkauft"
L["Auction Won"] = "Auktion gewonnen"
L["Auto Congratulate"] = "Auto Gratulieren"
L["Auto Ding"] = "Auto \"ding\""
L["Auto Farewell"] = "Automatischer Abschied"
L["Auto Profession Link"] = "Automatisch Berufe verlinken"
--[[Translation missing --]]
L["Auto Set Role"] = "Auto Set Role"
L["Auto Welcome"] = "Auto Willkommen"
L["Automatic Chat Logging"] = "automatische Chat-Aufzeichnung"
L["Automatically bid someone farewell when they leave your guild."] = "Automatisch allen, die die Gilde verlassen, alles Gute w\195\188nschen."
L["Automatically congratulate someone when they, or others, complete an achievement."] = "Automatisch gratulieren, wenn jemand einen Erfolg abschlie\195\159t."
L["Automatically congratulates someone when they say \"ding\" in chat."] = "Automatisch gratulieren, wenn jemand \"ding\" im Chat schreibt."
--[[Translation missing --]]
L["Automatically enable tracking of pets for battles."] = "Automatically enable tracking of pets for battles."
--[[Translation missing --]]
L["Automatically enable tracking of Stable Masters to help you revive and/or heal your pets."] = "Automatically enable tracking of Stable Masters to help you revive and/or heal your pets."
L["Automatically enables chat logging."] = "Aktiviert die automatische Chataufzeichnung."
L["Automatically link someone the profession they requested via various keywords."] = "Automatisch jemanden den Beruf verlinken, welcher \195\188ber verschiedene Schl\195\188sselw\195\182rter angfragt worden ist."
L["Automatically Remove Item When Finished"] = "Item automatisch nach der Beendigung l\195\182schen"
L["Automatically welcomes someone to your guild."] = "Neue Gildenmitglieder automatisch willkommen hei\195\159en."
L["Available Chat Command Arguments"] = "Verf\195\188gbare Chat-Kommando Argumente"
--[[Translation missing --]]
L["Available communities"] = "Available communities"
L["Available parameters are |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."] = "Verf\195\188gbare Parameter sind |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."
--[[Translation missing --]]
L["Battle.Net Convo"] = "Battle.Net Convo"
L["Battle.Net Options"] = "Battle.Net Einstellungen"
--[[Translation missing --]]
L["Battle.Net Whisper"] = "Battle.Net Whisper"
L["Before"] = "Davor"
--[[Translation missing --]]
L["Below are the keywords that the module will look for to substitute with the values described below."] = "Below are the keywords that the module will look for to substitute with the values described below."
--[[Translation missing --]]
L["BeTTeR ALTeRNaTiNG CaPS"] = "BeTTeR ALTeRNaTiNG CaPS"
L["Better not tell you now."] = "Besser dir jetzt nicht mittteilen."
L["Bid Accepted"] = "Gebot akzeptiert"
L["Blacksmithing"] = "Juwelenschleifen"
--[[Translation missing --]]
L["Bloodlust Announce"] = "Bloodlust Announce"
--[[Translation missing --]]
L["Bloodlust Announce is disabled, locate it under |cfff960d9KlixUI|r settings instead."] = "Bloodlust Announce is disabled, locate it under |cfff960d9KlixUI|r settings instead."
L["Build Date: |cff1784d1%s|r"] = "Build Datum: |cff1784d1%s|r"
L["Build: |cff1784d1%s|r"] = true
L["Busy"] = "Besch\195\164ftigt"
L["Calculator"] = "Taschenrechner"
L["Cannot predict now."] = "Kann ich nicht voraussagen."
L["Can't set value '%s', doesn't look like a number."] = "Kann den Wert '%s' nicht setzen, da es nicht nach einer Zahl aussieht."
--[[Translation missing --]]
L["Capitalize Words"] = "Capitalize Words"
--[[Translation missing --]]
L["Capture Delay"] = "Capture Delay"
L["Center"] = "Mitte"
--[[Translation missing --]]
L["Changed Channel"] = "Changed Channel"
L["Channel"] = true
L["Channel %d"] = true
L["Channel Colors"] = "Kanal Farben"
--[[Translation missing --]]
L["Channel Names"] = "Channel Names"
--[[Translation missing --]]
L["Channel Notice Filter"] = "Channel Notice Filter"
L["Channel Sounds"] = "Kanal-Sounds"
L["Channel to send the reminder to."] = "Channel in welchem Erinnerung geschickt werden soll."
L["Channels"] = true
--[[Translation missing --]]
L["Channels to Filter"] = "Channels to Filter"
L["Channels to look for questions."] = "Kan\195\164le in welchen nach Anfragen geschaut werden soll."
L["Channels to Monitor"] = "Zu beobachtende Kan\195\164le"
--[[Translation missing --]]
L["Channels to Watch"] = "Channels to Watch"
L["Character to use between the name and level"] = "Zeichen, welches zwischen Name und Stufe genutzt werden soll"
L["Character to use for the left bracket"] = "Zeichen, welches als linke Klammer genutzt werden soll"
L["Character to use for the right bracket"] = "Zeichen, welches als rechte Klammer genutzt werden soll"
L["Chat Events"] = "Chat Ereignisse"
L["Chat Fonts"] = "Chat-Schriftarten"
L["Chat Frame "] = "Chat-Fenster"
L["Chat Frame"] = "Chat Fenster"
L["Chat Frame %d"] = true
L["Chat Frame Settings"] = "Chatfenster Einstellungen"
--[[Translation missing --]]
L["Chat frame to output the message to.  Default is |cffffff00ChatFrame3|r, which is the default frame for ElvUI XP messages."] = "Chat frame to output the message to.  Default is |cffffff00ChatFrame3|r, which is the default frame for ElvUI XP messages."
--[[Translation missing --]]
L["Chat frame to output the messages.  Default is ChatFrame3, which is the default output frame for reputation messages in ElvUI."] = "Chat frame to output the messages.  Default is ChatFrame3, which is the default output frame for reputation messages in ElvUI."
--[[Translation missing --]]
L["Chat frame to route the auction house messages to."] = "Chat frame to route the auction house messages to."
--[[Translation missing --]]
L["Chat frame to route the messages to."] = "Chat frame to route the messages to."
--[[Translation missing --]]
L["Chat frame to send the list to."] = "Chat frame to send the list to."
L["Chat frame to send the messages to."] = "Chatfenster an welches Nachrichten gesendet werden sollen."
--[[Translation missing --]]
L["Chat Frames To Watch"] = "Chat Frames To Watch"
--[[Translation missing --]]
L["Chat Tabs"] = "Chat Tabs"
--[[Translation missing --]]
L["Chat Tweaks"] = "Chat Tweaks"
--[[Translation missing --]]
L["Chat Window"] = "Chat Window"
L["ChatFrame %d"] = "Chatfenster %d"
L["Chats To Monitor"] = "Zu beobachtende Chats"
--[[Translation missing --]]
L["Cheats Color"] = "Cheats Color"
--[[Translation missing --]]
L["Choose the filter to use."] = "Choose the filter to use."
L["Choose which chat frames display timestamps"] = "W\195\164hle, in welchem Chatfenster ein Zeitstempel angezeigt werden soll."
L["Class"] = "Klasse"
L["Clear all chat windows."] = "Leere alle Chatfenster"
L["Clear Chat Commands"] = "Kommandos um Chat zu leeren"
L["Clear current chat."] = "Leere aktuellen Chat."
--[[Translation missing --]]
L["Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."] = "Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."
--[[Translation missing --]]
L["Click to reset the materials you're tracking."] = "Click to reset the materials you're tracking."
--[[Translation missing --]]
L["Click to send the reminder to the select channel that the Magic 8-Ball is listening."] = "Click to send the reminder to the select channel that the Magic 8-Ball is listening."
--[[Translation missing --]]
L["Click to toggle ElvUI's config window.  This will also close this window."] = "Click to toggle ElvUI's config window.  This will also close this window."
--[[Translation missing --]]
L["Client Locale: |cff1784d1%s|r"] = "Client Locale: |cff1784d1%s|r"
--[[Translation missing --]]
L["Coin Size"] = "Coin Size"
L["Color"] = "Farbe"
--[[Translation missing --]]
L["Color a roll game loss, aka when you roll a one (1)."] = "Color a roll game loss, aka when you roll a one (1)."
--[[Translation missing --]]
L["Color a roll game win, aka when someone else rolls a one (1)."] = "Color a roll game win, aka when someone else rolls a one (1)."
--[[Translation missing --]]
L["Color by Channel"] = "Color by Channel"
--[[Translation missing --]]
L["Color Cheats"] = "Color Cheats"
--[[Translation missing --]]
L["Color Level"] = "Color Level"
L["Color Loss"] = "Farbe Verloren"
L["Color Name"] = "Name der Farbe"
--[[Translation missing --]]
L["Color of other's rolls."] = "Color of other's rolls."
--[[Translation missing --]]
L["Color of the base reputation messages."] = "Color of the base reputation messages."
L["Color of the faction."] = "Farbe der Fraktion."
--[[Translation missing --]]
L["Color of the output message."] = "Color of the output message."
L["Color of the reputation needed/left."] = "Farbe des noch zu ben\195\182tigten Rufs."
--[[Translation missing --]]
L["Color of the standing (honored, revered, etc.)."] = "Color of the standing (honored, revered, etc.)."
L["Color own charname in messages."] = "F\195\164rbe eigenen Charakternamen in Nachrichten."
L["Color Player Names By..."] = "F\195\164rbe Spielernamen nach..."
--[[Translation missing --]]
L["Color regular rolls by others."] = "Color regular rolls by others."
L["Color Rolls"] = "W\195\188rfel Farbe"
--[[Translation missing --]]
L["Color rolls differently to make tracking the roll game easier on the eyes."] = "Color rolls differently to make tracking the roll game easier on the eyes."
--[[Translation missing --]]
L["Color rolls that do not start at 1."] = "Color rolls that do not start at 1."
L["Color self in messages"] = "F\195\164rbe selbst in Nachrichten"
--[[Translation missing --]]
L["Color the messages by the channel the message came from."] = "Color the messages by the channel the message came from."
--[[Translation missing --]]
L["Color the name of the pets during a pet battle relative to their rarity.  If you have the pet you're currently battling it will also add the quality of the pet you have in your journal."] = "Color the name of the pets during a pet battle relative to their rarity.  If you have the pet you're currently battling it will also add the quality of the pet you have in your journal."
L["Color timestamps the same as the channel they appear in."] = "F\195\164rbe Zeitstempel in den gleichen Farben, wie auch den Kanal, in dem sie erscheinen."
--[[Translation missing --]]
L[ [=[Color to change the filtered message to.

|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r.]=] ] = [=[Color to change the filtered message to.

|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r.]=]
--[[Translation missing --]]
L["Color to designate a cheating roll."] = "Color to designate a cheating roll."
--[[Translation missing --]]
L["Color to designate a roll game loss."] = "Color to designate a roll game loss."
--[[Translation missing --]]
L["Color to designate a roll game win."] = "Color to designate a roll game win."
L["Color to use for your rolls."] = "Farbe zur Verwendung f\195\188r deine W\195\188rfe."
L["Color Win"] = "Farbe Gewonnen"
L["Color Your Rolls"] = "F\195\164rbe deine W\195\188rfe"
--[[Translation missing --]]
L["Color your rolls to set them apart."] = "Color your rolls to set them apart."
L["Colorize"] = "F\195\164rben"
--[[Translation missing --]]
L["Combat Log Remover"] = "Combat Log Remover"
--[[Translation missing --]]
L["Command Help"] = "Command Help"
--[[Translation missing --]]
L["Companions"] = "Companions"
--[[Translation missing --]]
L["Complete"] = "Complete"
L["Compress"] = "Komprimieren"
L["Concentrate and ask again."] = "Konzentrieren und nochmal fragen."
L["Congratulate achievements earned by guildmates."] = "Automatisch Gildenmitgliedern gratulieren, wenn sie einen Erfolg abschlie\195\159en."
L["Congratulate achievements earned by people in your party."] = "Automatisch gratulieren, wenn jemand in deiner Gruppe einen Erfolg abschlie\195\159t."
L["Congratulate achievements earned by people in your raid."] = "Automatisch gratulieren, wenn jemand in deinem Raid einen Erfolg abschlie\195\159t."
L["Congratulate achievements earned by people near you."] = "Automatisch gratulieren, wenn jemand in deiner N\195\164he einen Erfolg abschlie\195\159t."
L["Congratulations Messages"] = "Gratulationsnachrichten"
--[[Translation missing --]]
L["conquest"] = "conquest"
--[[Translation missing --]]
L["Control + Left Click"] = "Control + Left Click"
--[[Translation missing --]]
L["Control + Right Click"] = "Control + Right Click"
--[[Translation missing --]]
L["Control when Talented should silence Learned/Unlearned system messages"] = "Control when Talented should silence Learned/Unlearned system messages"
L["Cooking"] = "Kochen"
L["copper"] = "Kupfer"
L["Copy Links"] = "Links kopieren"
--[[Translation missing --]]
L["cp"] = "cp"
--[[Translation missing --]]
L["cpcap"] = "cpcap"
L["Creates a button to click that will return you to the bottom of the chat frame."] = "Erzeugt eine klickbare Schaltfl\195\164che, die f\195\188r dich an das Ende des Chatfensters scrollt."
L["Custom Chat Filters"] = "Benutzerdefinierte Chatfilter"
L["Custom chat filters."] = "Benutzerdefinierte Chatfilter."
L["Custom color"] = "Benutzerdefinierte Farbe"
L["Custom Emote: |cffffff00%s|r"] = "Benutzer Emote: |cffffff00%s|r"
L["Custom Emotes"] = "Eigene Emotes"
L["Custom format (advanced)"] = "Eigenes Format (fortgeschritten)"
L["Custom Named Chat Filters"] = "Benutzerdefiniert benannte Chatfilter"
--[[Translation missing --]]
L["Custom Names"] = "Custom Names"
L["Damage Meters"] = true
--[[Translation missing --]]
L["Datatext"] = "Datatext"
--[[Translation missing --]]
L["Datatext Display"] = "Datatext Display"
L["Date"] = "Datum"
L["Day"] = "Tag"
L["Death Knight"] = "Todesritter"
L["DEATHKNIGHT"] = "TODESRITTER"
L["Default font face for the chat frames."] = "Standard Schriftart in Chatfenstern"
L["Default font outline for the chat frames."] = "Standard Schriftkontur in Chatfenstern"
L["Default font size for the chat frames."] = "Standard Schriftgr\195\182\195\159e in Chatfenstern"
L["Default Name Color"] = "Standard Namensfarbe"
L["Destroys all your saved class/level data"] = "L\195\182scht alle gespeicherten Klassen-/Stufendaten"
L["Developer Tools"] = "Entwicklertools"
L["Ding Messages"] = "\"Ding\" Nachrichten"
L["Disable All Modules"] = "Alle Module deaktivieren"
--[[Translation missing --]]
L["Disable if you completed the achievement."] = "Disable if you completed the achievement."
--[[Translation missing --]]
L["Disable if you say ding."] = "Disable if you say ding."
L["Disable if..."] = "Deaktivieren, wenn"
--[[Translation missing --]]
L["Disable in Battlegrounds"] = "Disable in Battlegrounds"
--[[Translation missing --]]
L["Disable in PvP Zones"] = "Disable in PvP Zones"
L["Disable while you're AFK flagged."] = "Deaktivieren, wenn AFK"
L["Disable while you're DND flagged."] = "Deaktivieren, wenn DND "
L["Disabled"] = "Deaktiviert"
--[[Translation missing --]]
L["Disabled %s%s|r module."] = "Disabled %s%s|r module."
L["Disabled Modules"] = "Deaktivierte Module"
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
L["Displays reputation numbers and progress in the chat frame."] = "Zeigt Rufpunkte und Fortschritt im Chatfenster an"
L["DND Messages"] = "DND Nachrichten"
--[[Translation missing --]]
L["Do not reply while in M+ dungeons."] = "Do not reply while in M+ dungeons."
L["Do not use alphanumerical characters."] = "Keine Alphanumerischen Zeichen verwenden."
L["Do Nothing"] = "Nichts machen"
--[[Translation missing --]]
L["Do you want to automatically remove an item when you meet your quota?"] = "Do you want to automatically remove an item when you meet your quota?"
--[[Translation missing --]]
L["Doesn't allow multiple announces from your guild members at the same time."] = "Doesn't allow multiple announces from your guild members at the same time."
--[[Translation missing --]]
L["Doesn't send anything to channels, simulating only."] = "Doesn't send anything to channels, simulating only."
L["Dont Always Run"] = "Nicht Immer Rennen"
L["Don't count on it."] = "Rechne nicht damit."
--[[Translation missing --]]
L["Don't show your own failed taunts."] = "Don't show your own failed taunts."
--[[Translation missing --]]
L["Don't show your own taunts."] = "Don't show your own taunts."
L["DRUID"] = "DRUIDE"
L["Druid"] = "Druide"
--[[Translation missing --]]
L["Dungeon Guide"] = "Dungeon Guide"
--[[Translation missing --]]
L["Easy Channel"] = "Easy Channel"
--[[Translation missing --]]
L["EditBox Alt Key Arrows"] = "EditBox Alt Key Arrows"
L["ElvUI ChatTweaks"] = true
--[[Translation missing --]]
L["ElvUI_ChatTweaks"] = "ElvUI_ChatTweaks"
--[[Translation missing --]]
L["ElvUI_CT"] = "ElvUI_CT"
L["Emote"] = true
L["Emote Filter"] = "Emote-Filter"
L["Emphasize Self"] = "Eigenes hervorheben"
L["Enable "] = "Aktivieren"
L["Enable"] = "Aktivieren"
L["Enable All Modules"] = "Aktiviere Alle Module"
L["Enable Debugging"] = "Debugging aktivieren"
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always congratulate."] = "Aktiviere dies, um die Funktion lediglich mit einer prozentualen Chance auszuf\195\188hren, um Spam/Bel\195\164stigungen zu unterbinden. Wenn du die Funktion deaktivierst, wird immer gratuliert."
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always run."] = "Aktiviere dies, um das Modul lediglich mit einer prozentualen Chance auszuf\195\188hren, um Spam/Bel\195\164stigungen zu unterbinden. Wenn du die Funktion deaktivierst, wird das Modul immer laufen."
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always welcome."] = "Aktiviere dies, um die Funktion lediglich mit einer prozentualen Chance auszuf\195\188hren, um Spam/Bel\195\164stigungen zu unterbinden. Wenn du die Funktion deaktivierst, werden Neulinge immer willkommen gehei\195\159en."
--[[Translation missing --]]
L["Enable to filter custom emotes made using |cff00ff00/emote|r or |cff00ff00/e|r."] = "Enable to filter custom emotes made using |cff00ff00/emote|r or |cff00ff00/e|r."
--[[Translation missing --]]
L["Enable to filter standard emotes such as |cff00ff00/dance|r or |cff00ff00/flirt|r."] = "Enable to filter standard emotes such as |cff00ff00/dance|r or |cff00ff00/flirt|r."
L["Enable various debugging messages to help with errors or undesired functioning."] = "Aktiviere verschiedene Debug-Nachrichten zur Suche von Fehlern oder unerw\195\188nschten Funktionen."
L["Enabled"] = "Aktiviert"
--[[Translation missing --]]
L["Enabled %s%s|r module."] = "Enabled %s%s|r module."
L["Enabled Modules"] = "Aktivierte Module"
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
L["Enchanting"] = "Verzauberkunst"
L["Engineering"] = "Ingenieurskunst"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "Eigenes Zeitformat eingeben. Siehe http://www.lua.org/pil/22.1.html f\195\188r eine \195\156bersicht nutzbarer Symbole."
--[[Translation missing --]]
L["Enter a value in seconds."] = "Enter a value in seconds."
--[[Translation missing --]]
L["Equip Location"] = "Equip Location"
--[[Translation missing --]]
L["etc"] = "etc"
L["Exclude level display for max level characters"] = "Deaktiviere die Stufenanzeige f\195\188r Charaktere auf h\195\182chster Stufe."
L["Exclude max levels"] = "Charaktere auf h\195\182chster Stufe ausschliessen."
L["Execution Interval"] = "Ausf\195\188hrungsintervall"
L["Faction Color"] = "Fraktionsfarbe"
--[[Translation missing --]]
L["Failed:"] = "Failed:"
--[[Translation missing --]]
L["Fake Achievement"] = "Fake Achievement"
L["Female"] = "weiblich"
L["Filter achievement message spam!"] = "Filtere Erfolgsmitteilungs-Spam!"
L["Filter achievements earned by guildmates."] = "Filtere Erfolge die Gildenmitglieder errungen haben."
L["Filter achievements earned by nearby people."] = "Filtere Erfolge die nahe Spieler errungen haben."
L["Filter AFK messages."] = "Filtere AFK-Nachrichten."
L["Filter AFK/DND auto responses.  This module is compatible with WIM."] = "Filtere AFK/DND autoantworten. Dieses Modul ist mit WIM kompatibel."
L["Filter by Player Level"] = "Filtere nach Spieler-Level"
--[[Translation missing --]]
L["Filter changed channel message."] = "Filter changed channel message."
L["Filter Color"] = "Filterfarbe"
L["Filter DND messages."] = "Filtere DND-Nachrichten."
L["Filter Guild Achievements"] = "Filtere Gildenerfolge"
L["Filter joined channel message."] = "Filtere Channel beigetreten Nachricht."
L["Filter left channel message."] = "Filtere Channel verlassen Nachricht."
--[[Translation missing --]]
L["Filter Line"] = "Filter Line"
--[[Translation missing --]]
L["Filter Mode"] = "Filter Mode"
L["Filter Nearby Achievements"] = "Filtere nahe Erfolge"
--[[Translation missing --]]
L["Filter Pets"] = "Filter Pets"
--[[Translation missing --]]
L["Filter spam throttle notices."] = "Filter spam throttle notices."
L["Filter standard and/or custom emotes."] = "Filtere Standard- und/oder benutzerdefinierte Emotes."
--[[Translation missing --]]
L[ [=[Filter the Auction Created message.

|cffffff00%s|r]=] ] = [=[Filter the Auction Created message.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Expired message.

|cffffff00%s|r]=] ] = [=[Nachrichten f\195\188r Abgelaufene Auktionen filtern.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Outbid message.

|cffffff00%s|r]=] ] = [=[Nachrichten f\195\188r \195\156berbotene Auktionen filtern.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Removed message.

|cffffff00%s|r]=] ] = [=[Nachrichten f\195\188r Entfernte Auktionen filtern.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Sold message.

|cffffff00%s|r]=] ] = [=[Nachrichten f\195\188r Verkaufte Auktionen filtern.

|cffffff00%s|r]=]
L[ [=[Filter the Auction Won message.

|cffffff00%s|r]=] ] = [=[Nachrichten f\195\188r Gewonnene Auktionen filtern.

|cffffff00%s|r]=]
L[ [=[Filter the Bid Accepted message.

|cffffff00%s|r]=] ] = [=[Filtert die Gebot akzeptiert Nachricht.

|cffffff00%s|r]=]
L["Filter the line containing the question."] = "Filtere die Zeile welche die Anfragen beinhaltet."
--[[Translation missing --]]
L[ [=[Filter what item quality should be displayed in chat.
|cfff960d9Quality steps: 0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary & 6 = Artifact|r]=] ] = [=[Filter what item quality should be displayed in chat.
|cfff960d9Quality steps: 0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary & 6 = Artifact|r]=]
L["Filtering Mode"] = "Filter-Modus"
L["Filters"] = "Filter"
L["Filters out Auction House system messages."] = "Auktionshaus-Systemnachrichten filtern."
L["Filters the channel notices."] = "Filtere die Channel Ank\195\188ndigungen"
L["Font Color"] = "Schriftfarbe"
L["Font Face"] = "Schriftschnitt"
L["Font Size"] = "Schriftgr\195\182\195\159e"
--[[Translation missing --]]
L["Frame scraping timeout exceeded, results will be incomplete."] = "Frame scraping timeout exceeded, results will be incomplete."
--[[Translation missing --]]
L["Frame to output the messages to."] = "Frame to output the messages to."
--[[Translation missing --]]
L["Frame to send the addon messages to."] = "Frame to send the addon messages to."
L["Friends"] = "Freunde"
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
L["ginv"] = true
L["ginvite"] = true
L["GInvite Alternate Command"] = "alternativer /guildinvite Befehl"
--[[Translation missing --]]
L["Gives the ability to add custom names to the chat messages for better recognition."] = "Gives the ability to add custom names to the chat messages for better recognition."
--[[Translation missing --]]
L["Gives you more flexibility in how you invite people to your group and guild."] = "Gives you more flexibility in how you invite people to your group and guild."
L["GKick Command"] = "GKick Kommando"
L["GKick Target: |cffffff00%s|r"] = "GKick aktuelles Ziel: |cffffff00%s|r"
L["gold"] = "Gold"
L["Gold Calculator"] = "Gold Rechner"
L["Group"] = "Gruppe"
L["Group Invite Links"] = "Gruppeneinladungslinks"
L["Group Say Command"] = "Gruppenchannel Kommando"
L["Guild"] = "Gilde"
L["Guild Channel"] = "Gilden-Kanal"
L["Guild Chat"] = "Gildenchat"
--[[Translation missing --]]
L["Guild cooperation mode"] = "Guild cooperation mode"
L["Guild Invite Links"] = "Gildeneinladungslinks"
L["Guild Messages"] = "Gildenmitteilungen"
L["Guild Options"] = "Gildenoptionen"
--[[Translation missing --]]
L["Guild Recruitment"] = "Guild Recruitment"
--[[Translation missing --]]
L["Guild Whispers"] = "Guild Whispers"
L["Guildmates"] = "Gildenmitglieder"
--[[Translation missing --]]
L["GuildSync: Accepted configuration update from %s"] = "GuildSync: Accepted configuration update from %s"
--[[Translation missing --]]
L["GuildSync: Error. Bad configuration received from %s"] = "GuildSync: Error. Bad configuration received from %s"
--[[Translation missing --]]
L["Handles chat tab flashing."] = "Handles chat tab flashing."
L["health"] = "Gesundheit"
--[[Translation missing --]]
L["Here you can select which channels this module will scan for the keygroupWords to trigger the invite."] = "Here you can select which channels this module will scan for the keygroupWords to trigger the invite."
L["HH:MM (12-hour)"] = "HH:MM (12 Stunden)"
L["HH:MM (24-hour)"] = "HH:MM (24 Stunden)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24 Stunden)"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12 Stunden)"
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
L["Highlight Color"] = "Hervorheben Farbe"
--[[Translation missing --]]
L["Highlight Substitutions"] = "Highlight Substitutions"
--[[Translation missing --]]
L["Highlight Term"] = "Highlight Term"
--[[Translation missing --]]
L["Highlight the search term in the results."] = "Highlight the search term in the results."
--[[Translation missing --]]
L["Highlight the substitutions that are made by changing their color."] = "Highlight the substitutions that are made by changing their color."
L["honor"] = "Ehre"
L["honour"] = "Ehre"
--[[Translation missing --]]
L["Hook the GameTooltip to add information to pet tooltips."] = "Hook the GameTooltip to add information to pet tooltips."
--[[Translation missing --]]
L["Hook the tooltip to show the toon's main or alts."] = "Hook the tooltip to show the toon's main or alts."
--[[Translation missing --]]
L["Hook Tooltip"] = "Hook Tooltip"
L["Hour (12hr)"] = "Stunde (12Std.)"
L["Hour (24hr)"] = "Stunde (24Std.)"
--[[Translation missing --]]
L["Hover Links"] = "Hover Links"
--[[Translation missing --]]
L["How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command."] = "How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command."
--[[Translation missing --]]
L["How often announce your message to channel."] = "How often announce your message to channel."
L["How to filter any matches."] = "Auf welche Weise die Suchergebnisse filtern."
L["Hunter"] = "J\195\164ger"
L["HUNTER"] = "J\195\132GER"
L["I am |cff1784d1%s|r"] = "Ich bin |cff1784d1%s|r"
L["Icon Orientation"] = "Symbol Ausrichtung"
L["Icon Size"] = "Symbol Gr\195\182\195\159e"
L["Icon to the left or right of the item link."] = "Symbol auf der linken oder rechten Seite vom Item-Link."
L["Identify Chat Frames"] = "Identifiziere Chat Fenster"
--[[Translation missing --]]
L["If a keyword is found should the module filter the line?"] = "If a keyword is found should the module filter the line?"
--[[Translation missing --]]
L["If no name can be found for an 'alt' rank character, use entire note"] = "If no name can be found for an 'alt' rank character, use entire note"
--[[Translation missing --]]
L["If the name specified above matches your current character's name, this module will not add it again if this option is checked."] = "If the name specified above matches your current character's name, this module will not add it again if this option is checked."
L["Ignore any messages you send containing keywords."] = "Ignoriere alle von dir gesendeten Nachrichten welche Schl\195\188sselw\195\182rter enthalten."
L["Ignore Your Messages"] = "Ignoriere Deine Nachrichten"
--[[Translation missing --]]
L[ [=[Improve the Auction Expired message.

|cffffff00%s|r]=] ] = [=[Improve the Auction Expired message.

|cffffff00%s|r]=]
--[[Translation missing --]]
L[ [=[Improve the Auction Outbid message.

|cffffff00%s|r]=] ] = [=[Improve the Auction Outbid message.

|cffffff00%s|r]=]
--[[Translation missing --]]
L[ [=[Improve the Auction Removed message.

|cffffff00%s|r]=] ] = [=[Improve the Auction Removed message.

|cffffff00%s|r]=]
--[[Translation missing --]]
L[ [=[Improve the Auction Sold message.

|cffffff00%s|r]=] ] = [=[Improve the Auction Sold message.

|cffffff00%s|r]=]
--[[Translation missing --]]
L[ [=[Improve the Auction Won message.

|cffffff00%s|r]=] ] = [=[Improve the Auction Won message.

|cffffff00%s|r]=]
--[[Translation missing --]]
L["Improved Auction Messages"] = "Improved Auction Messages"
--[[Translation missing --]]
L["In Command"] = "In Command"
L["Inactive Modules"] = "Inaktive Module"
L["Include level"] = "Level einbeziehen"
--[[Translation missing --]]
L["Include Prefix"] = "Include Prefix"
--[[Translation missing --]]
L["Include the"] = "Include the"
L["Include the player's level"] = "Einschalten des Spieler Levels"
--[[Translation missing --]]
L["Incomplete"] = "Incomplete"
L["Inscription"] = "Inschriftenkunde"
L["Instance"] = "Instanz"
--[[Translation missing --]]
L["Instance Channel"] = "Instance Channel"
L["Instance Leader"] = "Instanzleiter"
--[[Translation missing --]]
L[ [=[Instantly send the information of whom whispered you.

]=] ] = [=[Instantly send the information of whom whispered you.

]=]
L["inv"] = "einladen"
--[[Translation missing --]]
L["Invalid achievement ID for %s%d|r."] = "Invalid achievement ID for %s%d|r."
--[[Translation missing --]]
L["Invalid achievement link provided."] = "Invalid achievement link provided."
--[[Translation missing --]]
L["Invalid format found on entry \"%s\"."] = "Invalid format found on entry \"%s\"."
L["invite"] = "Einladen"
L["Invite Links"] = "Einladungs Links"
L["It is certain."] = "Es ist sicher."
L["It is decidedly so."] = "Es ist zweifellos so."
--[[Translation missing --]]
L["Item Level"] = "Item Level"
--[[Translation missing --]]
L["Item Level Link"] = "Item Level Link"
L["Jewelcrafting"] = "Juwelenschleifen"
--[[Translation missing --]]
L["Joined Channel"] = "Joined Channel"
--[[Translation missing --]]
L["jp"] = "jp"
--[[Translation missing --]]
L["jpcap"] = "jpcap"
--[[Translation missing --]]
L["Just one character."] = "Just one character."
--[[Translation missing --]]
L["justice"] = "justice"
L["Keeps your channel colors by name rather than by number."] = "H\195\164lt deine Kanal-Farben nach Namen statt nach Anzahl."
--[[Translation missing --]]
L["Keybinds"] = "Keybinds"
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
L["Leatherworking"] = "Lederverarbeitung"
L["Left"] = "Links"
L["Left Bracket"] = "Linke Klammer"
L["Left Channel"] = "Linker Kanal"
L["Left Click"] = "Links Klick"
L["Lets you alt-click player names to invite them to your party."] = "L\195\164sst dich per ALT-Klick auf die Spielernamen diese in deine Gruppe einladen."
L["Lets you set the justification of text in your chat frames."] = "L\195\164sst dich die Ausrichtung des Textes in deinen Chat-Frames setzen."
--[[Translation missing --]]
L["Level Difference"] = "Level Difference"
L["Level Location"] = "Levelgebiet"
L["Level: |cffffff00%s|r, Message: |cffffff00%s|r"] = "Level: |cffffff00%s|r, Nachricht: |cffffff00%s|r"
L["Link All Professions"] = "alle Berufe verlinken"
--[[Translation missing --]]
L["Login"] = "Login"
L["Look in guildnotes for character names, unless a note is set manually"] = "\195\156berpr\195\188ft die Gildennotiz nach Charakternamen, solange manuell keiner gesetzt wurde."
--[[Translation missing --]]
L["Loot Icons"] = "Loot Icons"
L["Loss Color"] = "Verlust Farbe"
--[[Translation missing --]]
L["lowercase"] = "lowercase"
L["MAGE"] = "MAGIER"
L["Mage"] = "Magier"
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
L["Male"] = "m\195\164nnlich"
L["mana"] = "Mana"
L["Material Quantities"] = "Material Mengen"
--[[Translation missing --]]
L["Materials Farming"] = "Materials Farming"
L["Materials to Track"] = "Zu verfolgende Materialien"
L["Maximum Delay"] = "Maximale Verz\195\182gerung"
L["Maximum time, in seconds, to wait before bidding someone farewell."] = "Maximale Wartezeit in Sekunden vor dem Verabschieden."
L["Maximum time, in seconds, to wait before congratulating someone."] = "Maximale Wartezeit (in Sekunden), bevor jemandem gratuliert wird."
L["Maximum time, in seconds, to wait before welcoming someone."] = "Maximale Wartezeit (in Sekunden), bevor jemandem willkommen gehei\195\159en wird."
L["Maximum time, in seconds, to wait before whispering someone the link."] = "Maximale Wartezeit (in Sekunden), bevor der Link gefl\195\188stert wird."
L["Message Color"] = "Nachrichtenfarbe"
L["Message color."] = "Nachrichten-Farbe"
L["Message highlight color."] = "Nachricht hervorheben Farbe."
L["Message Settings"] = "Nachrichten Einstellungen"
--[[Translation missing --]]
L["Message Throttle"] = "Message Throttle"
--[[Translation missing --]]
L["Message to announce, 2 lines max"] = "Message to announce, 2 lines max"
L[ [=[Messages for when multiple people complete achievements.  A random one will always be selected.

|cffff0000Wildcards do not apply for multiple achievements.|r]=] ] = [=[Nachricht, wenn mehrere Spieler einen Erfolg abschlie\195\159en. Es wird immer ein zuf\195\164lliger Spieler ausgew\195\164hlt.

|cffff0000Wildcards funktionieren nicht bei mehreren Erfolgen.|r]=]
L[ [=[Messages for when someone completes an achievement.  A random one will always be selected.

|cffFA6400Wildcards|r
|cff00ff00#name#|r  - Name of the person.
|cff00ff00#achieve#|r - Achievement they completed.]=] ] = [=[Nachrichten f\195\188r den, der einen Erfolg abschlie\195\159t. Eine zuf\195\164llige wird immer gew\195\164hlt

|cffFA6400Wildcards|r
|cff00ff00#name#|r  - Name der Person.
|cff00ff00#achieve#|r - Der Erfolg, welcher abgeschlossen wurde.]=]
L[ [=[Messages to use in guild chat when someone leaves your guild.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Person who left.
|cff00ff00#guild#|r - Name of your guild.]=] ] = [=[Nachrichten zur Verwendung im Gildenchat, wenn jemand deine Gilde verl\195\164sst.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Person, welche die Gilde verlassen hat.
|cff00ff00#guild#|r - Name deiner Gilde.]=]
L[ [=[Messages to use in the whisper when someone leaves your guild.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Person who left.
|cff00ff00#guild#|r - Name of your guild.]=] ] = [=[Nachrichten zum Fl\195\188stern, wenn jemand deine Gilde verl\195\164sst.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Person, welche die Gilde verlassen hat.
|cff00ff00#guild#|r - Name deiner Gilde.]=]
L[ [=[Messages to use when someone joins your guild.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Person who joined.
|cff00ff00#guild#|r - Name of your guild.]=] ] = [=[Nachrichten, welche benutzt werden, wenn jemand der Gilde beitritt.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Name des beigetretenen.
|cff00ff00#guild#|r - Name deiner Gilde.]=]
L[ [=[Messages to use when someone says "ding".

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Who said ding.
|cff00ff00#guild#|r - Their current level.]=] ] = [=[Nachrichten, wenn jemand "ding" schreibt.

|cffFA6400Wildcards|r
|cff00ff00#name#|r - Name des jenigen, der "ding" geschrieben hat.
|cff00ff00#guild#|r - Sein aktueller Level.]=]
L["Minimap Button"] = "Minimap-Button"
L["Minimum Delay"] = "Minimale Verz\195\182gerung"
L["Minimum Level"] = "Mindest Level"
L["Minimum level required for an achievement to not be filtered."] = "Minimales ben\195\182tigtes Level damit Erfolgsnachricht nicht gefiltert wird."
L["Minimum time, in seconds, to wait before bidding someone farewell."] = "Minimale Wartezeit in Sekunden vor Verabschiedung."
L["Minimum time, in seconds, to wait before congratulating someone."] = "Minimale Wartezeit (in Sekunden), bevor jemandem gratuliert wird."
L["Minimum time, in seconds, to wait before welcoming someone."] = "Minimale Wartezeit (in Sekunden), bevor ein Neuling willkommen gehei\195\159en wird."
L["Minimum time, in seconds, to wait before whispering someone the link."] = "Minimale Wartezeit (in Sekunden), bevor der Link gefl\195\188stert wird."
L["Minute"] = true
L["MM:SS"] = true
L["Monitor Chat Events"] = "Beobachte Chat-Ereignisse"
L["Monitor guild chat."] = "Beobachte Gildenchat"
L["Monitor party chat."] = "Beobachte Gruppenchat"
L["Monitor raid chat."] = "Beobachte Schlachtzugsnachrichten"
L["Monitor say chat."] = "Beobachte \"Sagen\"-Nachrichten"
--[[Translation missing --]]
L["Monitor text in this channel for link triggers."] = "Monitor text in this channel for link triggers."
L["Monitor whispers."] = "Beobachte Fl\195\188sternachrichten"
L["Monitor yell chat."] = "Beobachte \"Schreien\"-Nachrichten"
L["Monk"] = "M\195\182nch"
L["MONK"] = "M\195\150NCH"
L["Monster Emote"] = true
L["Monster Say"] = "Monster sagen"
L["Month"] = "Monat"
L["Most likely."] = "H\195\182chstwahrscheinlich."
L["Multiple Achievement Messages"] = "Mehrfache Erfolgsnachrichten."
--[[Translation missing --]]
L["Multiple Invite Command"] = "Multiple Invite Command"
L["My reply is no."] = "Meine Antwort ist Nein."
L["My sources say no."] = "Meine Quellen sagen Nein."
L["Name"] = true
L["Name color"] = "Farbe Name"
L["Nearby People"] = "Leute in der N\195\164he."
--[[Translation missing --]]
L["Never"] = "Never"
L["New Version Notify"] = "Benachrichtigung \195\188ber neue Version."
L["No"] = "Nein"
L["No custom emotes are currently being used."] = "Zur Zeit sind keine Benutzer-Emotes in Benutzung."
--[[Translation missing --]]
L["No Filter"] = "No Filter"
L["No RealNames"] = "Keine Echt-Namen"
L["None"] = "Keiner"
--[[Translation missing --]]
L["Not Capturable"] = "Not Capturable"
L["Not Found"] = "Nicht gefunden"
--[[Translation missing --]]
L["Not Owned"] = "Not Owned"
--[[Translation missing --]]
L["Not tracking %s."] = "Not tracking %s."
L["NoTarget"] = "KeinZiel"
--[[Translation missing --]]
L["Notifies your party or raid if people are taking a lot of avoidable damage from ground auras."] = "Notifies your party or raid if people are taking a lot of avoidable damage from ground auras."
L["Notify on new release?"] = "\195\156ber neue Version benachrichtigen?"
--[[Translation missing --]]
L["Notify on Role Set"] = "Notify on Role Set"
--[[Translation missing --]]
L["Num Channels"] = "Num Channels"
L["Numbered Channels"] = "Nummerierte Kan\195\164le"
--[[Translation missing --]]
L["Off"] = "Off"
L["Officer"] = "Offizier"
L["Officer Channel"] = "Offiziers-Kanal"
L["Officer Chat"] = "Offizierschat"
--[[Translation missing --]]
L["On"] = "On"
--[[Translation missing --]]
L["On (%d min)"] = "On (%d min)"
--[[Translation missing --]]
L["On (%d sec)"] = "On (%d sec)"
L["One or more of the changes you have made require you to reload your UI."] = "Eine oder mehrere gemachte \195\132nderung(en) erfordern das reloaden des UI."
L["Only filter achievements earned by players below a certain level."] = "Nur Erfolge herausfiltern, die von Spielern unter einem bestimmten Level erreicht werden."
L["Open Config"] = "\195\150ffne Konfiguration"
--[[Translation missing --]]
L["Open ElvUI Config"] = "Open ElvUI Config"
--[[Translation missing --]]
L["Open ElvUI's Config"] = "Open ElvUI's Config"
L["Opens configuration window."] = "Konfigurationsfenster \195\182ffnen"
L["Other Channels"] = "Andere Kan\195\164le"
L["Ouput Frame"] = "Ausgabe-Fenster"
L["Outline"] = "Kontur"
L["Outlook good."] = "Aussicht gut."
L["Outlook not so good."] = "Aussicht nicht so gut."
L["Output Channel"] = "Ausgabe-Kanal"
L["Output Color"] = "Ausgabe-Farbe"
L["Output color of the rerouted messages."] = "Ausgabefarbe von umgeleiteten Nachrichten."
L["Output Frame"] = "Ausgabe-Fenster"
--[[Translation missing --]]
L["Output Message Every..."] = "Output Message Every..."
--[[Translation missing --]]
L["Output the message every X times you gain XP."] = "Output the message every X times you gain XP."
L["Output To..."] = "Ausgabe nach..."
--[[Translation missing --]]
L["Owned Only"] = "Owned Only"
L["PALADIN"] = true
L["Paladin"] = true
--[[Translation missing --]]
L["Parameter: |cffffff00%s|r"] = "Parameter: |cffffff00%s|r"
L["Party"] = "Gruppe"
L["Party Channel"] = "Gruppen-Kanal"
L["Party Leader"] = "Gruppenleiter"
L["Party Members"] = "Gruppenmitglieder"
L["Percent Chance"] = "Prozentuale Chance"
--[[Translation missing --]]
L["Perhaps you meant '*' (multiplication)?"] = "Perhaps you meant '*' (multiplication)?"
--[[Translation missing --]]
L["Pet Battle Info"] = "Pet Battle Info"
L["Pet Battles"] = "Haustierk\195\164mpfe"
L["Pet Combat Log"] = "Haustierkampf Protokoll"
--[[Translation missing --]]
L["Pets Per Line"] = "Pets Per Line"
L["Place the level before or after the player's name."] = "Platziere das Level vor oder nach den Spielernamen"
--[[Translation missing --]]
L["Play a sound when it pops up."] = "Play a sound when it pops up."
L["Play Sound"] = "Spiele Sound"
--[[Translation missing --]]
L["Player Class"] = "Player Class"
L["Player Level"] = "Spieler Level"
L["Player level display options."] = "Spieler-Level Anzeigeoptionen."
L["Player Names"] = "Spieler Namen"
L["Player's Average iLvl"] = "Spieler durchschnittliches iLvl"
L["Player's Class"] = "Spieler Klasse"
L["Player's Gender"] = "Spieler Geschlecht"
L["Player's Health"] = "Spieler Gesundheit"
L["Player's Health Deficit"] = "Spieler Gesundheit Defizit"
L["Player's Health Percent"] = "Spieler Gesundheit Prozent"
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
L["Player's Name"] = "Spielername"
--[[Translation missing --]]
L["Player's X-Coordinate"] = "Player's X-Coordinate"
--[[Translation missing --]]
L["Player's Y-Coordinate"] = "Player's Y-Coordinate"
--[[Translation missing --]]
L["Player's Zone"] = "Player's Zone"
--[[Translation missing --]]
L["Plays a sound when one of your ElvUI keywords is found."] = "Plays a sound when one of your ElvUI keywords is found."
L["Plays a sound, of your choosing (via LibSharedMedia-3.0), whenever a message is received in a given channel."] = "Spielt einen Sound, von deiner Auswahl (via LibSharedMedia-3.0), wann immer du eine Nachricht ein einem gegebenen Kanal erh\195\164lst."
--[[Translation missing --]]
L["Plugins by |cff0070deCrackpotx|r"] = "Plugins by |cff0070deCrackpotx|r"
--[[Translation missing --]]
L["Popup"] = "Popup"
--[[Translation missing --]]
L["Popup Messages"] = "Popup Messages"
--[[Translation missing --]]
L["PopupMessage"] = "PopupMessage"
--[[Translation missing --]]
L["power"] = "power"
--[[Translation missing --]]
L["Prefix Character"] = "Prefix Character"
--[[Translation missing --]]
L["prefix when a message's output is"] = "prefix when a message's output is"
L["PRIEST"] = "PRIESTER"
L["Priest"] = "Priester"
--[[Translation missing --]]
L["Print Addon Version"] = "Print Addon Version"
--[[Translation missing --]]
L["Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues."] = "Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues."
L["Print this again."] = "Zeige das nochmal an."
--[[Translation missing --]]
L["Prints a link you can click to congratulate when someone obtains an achievement."] = "Prints a link you can click to congratulate when someone obtains an achievement."
--[[Translation missing --]]
L["Prints a message in the chat with your remain XP needed to level up."] = "Prints a message in the chat with your remain XP needed to level up."
L["Prints module status."] = "Zeige Modul-Status an."
--[[Translation missing --]]
L["Progress Updates"] = "Progress Updates"
L["Provides |cff00ff00/ginv|r, an alternative to |cff00ff00/ginvite|r command, for us lazy folks."] = "Stellt |cff00ff00/ginv|r bereit, einem alternativen |cff00ff00/ginvite|r Befehl, f\195\188r uns faule Leute."
--[[Translation missing --]]
L[ [=[Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.

Module Written by Björn Benjamin Hiller <bjoern.hiller@gmail.com>]=] ] = [=[Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.

Module Written by Bj\195\182rn Benjamin Hiller <bjoern.hiller@gmail.com>]=]
--[[Translation missing --]]
L["Provides a /in command to delay the execution of code in macros and other settings."] = "Provides a /in command to delay the execution of code in macros and other settings."
L["Provides a |cff00ff00/gkick|r command, as it should be."] = "Integriert ein |cff00ff00/gkick|r Befehl, wie es sein sollte."
--[[Translation missing --]]
L["Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically."] = "Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically."
--[[Translation missing --]]
L[ [=[Provides a few tools to help me (Crackpotx), develop this addon as well as diagnose and fix any errors that are reported.

|cff00ff00You can leave this addon disabled unless I (Crackpotx) ask you to enable it for some debugging.|r]=] ] = [=[Provides a few tools to help me (Crackpotx), develop this addon as well as diagnose and fix any errors that are reported.

|cff00ff00You can leave this addon disabled unless I (Crackpotx) ask you to enable it for some debugging.|r]=]
L["Provides basic chat subtitutions."] = "Bietet Basis Chat Ersetzungen."
--[[Translation missing --]]
L["Provides keybinds to make talking in a specific chat easier."] = "Provides keybinds to make talking in a specific chat easier."
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "Bietet Optionen zum f\195\164rben von Spielernamen, f\195\188gt Spielerlevel  hinzu und Tabulator Vervollst\195\164ndigung von Spielernamen."
L[ [=[Put each emote on a separate line.
Separate the command from the text with a colon (":").]=] ] = [=[Setze jedes Emote in eine seperate Zeile.
Trenne den Befehl vom Text mit einem Doppelpunkt (":").]=]
--[[Translation missing --]]
L["Quality"] = "Quality"
--[[Translation missing --]]
L["Quality Notification"] = "Quality Notification"
L["Raid"] = "Schlachtzug"
L["Raid Boss Emote"] = "Schlachtzugsboss-Emote"
L["Raid Channel"] = "Schlachtzug-Kanal"
L["Raid Leader"] = "Schlachtzugsleiter"
L["Raid Members"] = "Schlachtzugsmitglieder"
L["Raid Warning"] = "Schlachtzugwarnung"
L["Raid Warning Channel"] = "Schlachtzugwarnung-Kanal"
L["Random Number"] = "Zufallszahl"
--[[Translation missing --]]
L["Ready Check Command"] = "Ready Check Command"
L["RealID Brackets"] = "RealID Klammern"
L["Really remove this word from your trigger list?"] = "Dieses Wort wirklich von der Trigger Liste nehmen?"
--[[Translation missing --]]
L["Release Command"] = "Release Command"
--[[Translation missing --]]
L["ReloadUI"] = "ReloadUI"
--[[Translation missing --]]
L["Remaining: %s, Cost: $%d"] = "Remaining: %s, Cost: $%d"
L["Reminder"] = "Erinnerung"
L["Remove"] = "Entfernen"
L["Remove a word from your group invite trigger list"] = "Entfernt ein Wort aus deiner Gruppeneinladung Ausl\195\182ser-Liste"
L["Remove a word from your guild invite trigget list."] = "Entfernt ein Wort aus deiner Gildeneinladung Ausl\195\182ser-Liste"
L["Remove Group Trigger"] = "Entfernt Gruppen Ausl\195\182ser"
L["Remove Guild Trigger"] = "Entfernt Gilden Ausl\195\182ser"
--[[Translation missing --]]
L["Removes the combat log chattab from the chat window."] = "Removes the combat log chattab from the chat window."
L["Repeat Command"] = "Befehl wiederholen"
L["Repeat Question"] = "Wiederhole Frage"
L["Repeat the question when giving a response."] = "Wiederhole die Frage, wenn Antwort geegeben wird."
--[[Translation missing --]]
L["Replace this channel name with..."] = "Replace this channel name with..."
L["Reply hazy, try again."] = "Antwort schwammig, versuchs nochmal."
L["Reported by %s"] = "Gemeldet durch %s"
L["Reputation"] = "Ruf"
--[[Translation missing --]]
L["Reputation Color"] = "Reputation Color"
--[[Translation missing --]]
L["Require the alt key to be pressed to use the arrow keys on editboxes."] = "Require the alt key to be pressed to use the arrow keys on editboxes."
L["Reroute Auction Messages"] = "Leite Auktionsnachichten um"
--[[Translation missing --]]
L["Reset alt names and their mains."] = "Reset alt names and their mains."
L["Reset ChatFrame text justifications to defaults (left)."] = "Die Textausrichtung des Chatframe auf Standart zur\195\188ckstellen (linksb\195\188ndig)."
L["Reset Data"] = "Daten zur\195\188cksetzen"
L["Reset Font Data"] = "Schriftartdaten zur\195\188cksetzen"
L["Reset Materials"] = "Materialien zur\195\188cksetzen."
--[[Translation missing --]]
L["Reset Names"] = "Reset Names"
--[[Translation missing --]]
L[ [=[Reset saved mains/alts.

|cffff0000This CANNOT be undone.|r]=] ] = [=[Reset saved mains/alts.

|cffff0000This CANNOT be undone.|r]=]
L["Reset Text Justitification"] = "Textausrichtung zur\195\188cksetzen"
L["Resets all chat frames to their original font settings."] = "Alle Chats auf den Originalschriftart zur\195\188cksetzen."
L["Right"] = "Rechts"
L["Right Bracket"] = "Rechte Klammer"
L["Right Click"] = "Rechts Klick"
L["Rogue"] = "Schurke"
L["ROGUE"] = "SCHURKE"
--[[Translation missing --]]
L["Role Poll Command"] = "Role Poll Command"
--[[Translation missing --]]
L["Role Set: %s%s|r"] = "Role Set: %s%s|r"
--[[Translation missing --]]
L["Role will not be set while in combat."] = "Role will not be set while in combat."
--[[Translation missing --]]
L["Roll Color"] = "Roll Color"
--[[Translation missing --]]
L["Roll Pattern: |cffffff00%s|r"] = "Roll Pattern: |cffffff00%s|r"
--[[Translation missing --]]
L["'s"] = "'s"
L["Save all /who data"] = "Speichere alle /wer Daten"
L["Save class data from /who queries between sessions."] = "Speichere Klassendaten von /wer Abfragen zwischen den Sitzungen."
L["Save class data from friends between sessions."] = "Speichere Freundesdaten zwischen den Sitzungen."
L["Save class data from groups between sessions."] = "Speichere Klassendaten zwischen den Sitzungen."
L["Save class data from guild between sessions."] = "Speichere Klassendaten aus der Gilde zwischen den Sitzungen."
L["Save class data from target/mouseover between sessions."] = "Speichere Klassendaten von Ziel/Maus\195\188ber zwischen den Sitzungen."
L["Save Data"] = "Speichere Daten"
L["Save data between sessions. Will increase memory usage"] = "Speichere Daten zwischen den Sitzungen. Wird den Speicherverbrauch erh\195\182hen"
L["Say"] = "Sagen"
L["Say Chat"] = "Sagen Chat"
--[[Translation missing --]]
L["Scrape Time"] = "Scrape Time"
--[[Translation missing --]]
L["Scroll Reminder"] = "Scroll Reminder"
--[[Translation missing --]]
L["Search"] = "Search"
--[[Translation missing --]]
L["Search Results |cff9382c9(%d Found)|r:"] = "Search Results |cff9382c9(%d Found)|r:"
--[[Translation missing --]]
L["Search Results:"] = "Search Results:"
--[[Translation missing --]]
L["Search term is too short."] = "Search term is too short."
L["Second"] = "Zweite"
L["Select a color for this channel."] = "Eine Farbe f\195\188r diesen Kanal ausw\195\164hlen."
L["Select a method for coloring player names"] = "W\195\164hle ein Methode zum Einf\195\164rben der Spielernamen."
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
L["Select the channels you want to monitor."] = "W\195\164hle die Kan\195\164le, welche beobachtet werden sollen."
--[[Translation missing --]]
L["Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number."] = "Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number."
--[[Translation missing --]]
L["Select the custom color to use for alt names"] = "Select the custom color to use for alt names"
--[[Translation missing --]]
L["Select which channels to flash when a message is received."] = "Select which channels to flash when a message is received."
L["Select which factions you would like to receive notifications for."] = "W\195\164hle die Fraktionen aus, von denen du Benachrichtigungen erhalten m\195\182chtest."
--[[Translation missing --]]
L["Self"] = "Self"
--[[Translation missing --]]
L["Semi-Auto Congratulate"] = "Semi-Auto Congratulate"
--[[Translation missing --]]
L["Send a chat message when a role is set/changed."] = "Send a chat message when a role is set/changed."
--[[Translation missing --]]
L["Send a tell to your target."] = "Send a tell to your target."
L["Send a whisper to the person who left."] = "Sende der Person eine Nachricht, die verlassen hat."
L["Send Guild Messages"] = "Gildennachrichten versenden"
--[[Translation missing --]]
L["Send guild recruitment messages to various chat channels."] = "Send guild recruitment messages to various chat channels."
L["Send messages to guild chat when someone leaves."] = "Sende Nachrichten zum Gildenchat wenn jemand austritt."
L["Send Reminder"] = "Sende Erinnerung"
L["Send Whisper"] = "Fl\195\188sternachricht versenden"
L["Separator"] = "Trennzeichen"
--[[Translation missing --]]
L["Set DND"] = "Set DND"
--[[Translation missing --]]
L["Set DND message"] = "Set DND message"
L["Set Main"] = "Hauptcharakter einstellen"
--[[Translation missing --]]
L["Set the coloring mode for alt names"] = "Set the coloring mode for alt names"
--[[Translation missing --]]
L["Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel."] = "Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel."
--[[Translation missing --]]
L["Set the sound to play."] = "Set the sound to play."
L["Settings"] = "Einstellungen"
L["Shaman"] = "Schamane"
L["SHAMAN"] = "SCHAMANE"
L["Shift + Left Click"] = "Shift + Links Klick"
L["Shift + Right Click"] = "Shift + Rechts Klick"
--[[Translation missing --]]
L["Short Format"] = "Short Format"
--[[Translation missing --]]
L["Short format (P for plate, L for leather, ...)"] = "Short format (P for plate, L for leather, ...)"
--[[Translation missing --]]
L["Show Alts"] = "Show Alts"
--[[Translation missing --]]
L["Show Armor Type"] = "Show Armor Type"
--[[Translation missing --]]
L["Show current to total XP percentage."] = "Show current to total XP percentage."
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
--[[Translation missing --]]
L["Show Percentage"] = "Show Percentage"
--[[Translation missing --]]
L["Show remaining rested XP."] = "Show remaining rested XP."
--[[Translation missing --]]
L["Show Rested XP"] = "Show Rested XP"
--[[Translation missing --]]
L["Show the total number of modules on the datatext."] = "Show the total number of modules on the datatext."
--[[Translation missing --]]
L["Show toon names instead of real names"] = "Show toon names instead of real names"
--[[Translation missing --]]
L["Show Total XP"] = "Show Total XP"
--[[Translation missing --]]
L["Show total XP needed to level."] = "Show total XP needed to level."
--[[Translation missing --]]
L["Show welcome message when logging in."] = "Show welcome message when logging in."
--[[Translation missing --]]
L["Showing Configuration Options"] = "Showing Configuration Options"
--[[Translation missing --]]
L["Shows messages in a popup frame."] = "Shows messages in a popup frame."
L["Signs point to yes."] = "Anzeichen deuten auf Ja."
--[[Translation missing --]]
L["Silence in M+"] = "Silence in M+"
--[[Translation missing --]]
L["Silence Learned/Unlearned system messages."] = "Silence Learned/Unlearned system messages."
--[[Translation missing --]]
L["silver"] = "silver"
--[[Translation missing --]]
L["Similar to the |cffffffIn Command|r module, except it will repeat the command X times."] = "Similar to the |cffffffIn Command|r module, except it will repeat the command X times."
--[[Translation missing --]]
L["Size of the coin icons.  Generally you want to use your font size or smaller."] = "Size of the coin icons.  Generally you want to use your font size or smaller."
--[[Translation missing --]]
L["Skipping. Message already advertised by %s"] = "Skipping. Message already advertised by %s"
--[[Translation missing --]]
L["Skipping. Trade: %d LFG: %d"] = "Skipping. Trade: %d LFG: %d"
--[[Translation missing --]]
L["Smart Group Channel"] = "Smart Group Channel"
L["Sound"] = true
L[ [=[Sound to play when a message in %s is received.

|cff00ff00To disable set to "None"|r.]=] ] = [=[Abzuspielender Sound, wenn eine Nachricht in %s empfangen wurde.

|cff00ff00Zum Deaktivieren w\195\164hle "None"|r.]=]
--[[Translation missing --]]
L["Spam CoolDown"] = "Spam CoolDown"
L["Spam Delay"] = "Spamverz\195\182gerung"
--[[Translation missing --]]
L["SPAM protection, lines"] = "SPAM protection, lines"
L["Spam Throttle"] = "Spam Verz\195\182gerung"
--[[Translation missing --]]
L["Squelch"] = "Squelch"
--[[Translation missing --]]
L["sretteL esreveR"] = "sretteL esreveR"
--[[Translation missing --]]
L["Standard Emote: |cffffff00%s|r"] = "Standard Emote: |cffffff00%s|r"
--[[Translation missing --]]
L["Standard Emotes"] = "Standard Emotes"
--[[Translation missing --]]
L["Standing Color"] = "Standing Color"
--[[Translation missing --]]
L["Stopped tracking %s."] = "Stopped tracking %s."
L["Strip RealID brackets"] = "RealID Klammern ausschneiden."
L["Substitutions"] = "Ersetzungen"
L["Suppress"] = "Unterdr\195\188cken"
L["Suppress Recount/Skada/TinyDPS output into a clickable link, or filter it entirely."] = "Fasse Recount/Skada/TinyDPS Ausgaben zu einem klickbaren Link zusammen oder filtere diese komplett."
L["Symbol: |cffffff00%s|r"] = true
--[[Translation missing --]]
L["SYNC_KEY_HELP"] = "SYNC_KEY_HELP"
--[[Translation missing --]]
L["Synchronization key"] = "Synchronization key"
L["Tailoring"] = "Schneiderei"
--[[Translation missing --]]
L["Talent Squelch"] = "Talent Squelch"
L["Talk to your group based on party/raid status."] = "Sprich zu deiner Gruppe abh\195\164ngig vom Gruppen/Raid-Status."
L["Target/Mouseover"] = "Ziel/Mouseover"
L["Target: |cffffff00%s|r"] = "Ziel: |cffffff00%s|r"
L["Target's Class"] = "Klasse des Ziels"
L["Target's Gender"] = "Geschlecht des Ziels"
L["Target's Health"] = "Ziel Gesundheit"
L["Target's Health Deficit"] = "Ziel Gesundheit Defizit"
L["Target's Health Percent"] = "Ziel Gesundheit Prozent"
L["Target's Level"] = "Ziel Level"
L["Target's Mana"] = "Ziel Mana"
L["Target's Mana Deficit"] = "Ziel Mana Defizit"
L["Target's Mana Percent"] = "Ziel Mana Prozent"
L["Target's Max Health"] = "Ziel Max Gesundheit"
L["Target's Max Mana"] = "Ziel Max Mana"
L["Target's Name"] = "Ziel Name"
--[[Translation missing --]]
L["taunt"] = "taunt"
--[[Translation missing --]]
L["taunted"] = "taunted"
L["Tell Target"] = "Ziel fl\195\188stern"
--[[Translation missing --]]
L["Test mode"] = "Test mode"
L["Text Justification"] = "Textausrichtung"
L["Text justification for ChatFrame %d."] = "Text Ausrichtung f\195\188r Chat Fenster %d."
L["Text to trigger the addon to answer a question."] = "Text welcher das Addon zum Frage beantworten ausl\195\182st."
--[[Translation missing --]]
L[ [=[Thanks for using and supporting my work!  -- |cff0070deCrackpotx|r

|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge.]=] ] = [=[Thanks for using and supporting my work!  -- |cff0070deCrackpotx|r

|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge.]=]
L["The amount of each material you'd like to farm.  If you want an unlimited amount simply put a 0.  You must add a quantity for every entry, and it must correspond to the same line in the other box."] = "Die Menge von jedem Material, welches Du farmen m\195\182chstest. F\195\188r unbegrenzte Menge einfach eine Null einf\195\188gen. Du musst f\195\188r jeden Eintrag eine Menge hinzuf\195\188gen und es muss sich in der gleichen Zeile, wie die dazugeh\195\182rige Box, befinden."
L["The character in front of abbreviations to be recognised as such."] = "Der Anfangsbuchstabe von Abk\195\188rzungen zur Erkennung von Abk\195\188rzungen."
--[[Translation missing --]]
L["The chat window taunts will be announced in when the output is set to"] = "The chat window taunts will be announced in when the output is set to"
--[[Translation missing --]]
L["The classic Magic 8-Ball brought to World of Warcraft!"] = "The classic Magic 8-Ball brought to World of Warcraft!"
L["The color to highlight the search term."] = "Farbe zur Hervorhebung von Suchbegriffen"
L["The color to use when highlighting a substitution."] = "Farbe zur Hervorhebung von Ersetzungen."
L["The default color to use to color names."] = "Standardfarbe, welche zum Einf\195\164rben von Namen verwendet werden soll."
--[[Translation missing --]]
L[ [=[The name or ID of the material you'd like to track.

|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r]=] ] = [=[The name or ID of the material you'd like to track.

|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r]=]
--[[Translation missing --]]
L["The name that should be displayed in your chat messages."] = "The name that should be displayed in your chat messages."
L["The percent chance the module has to bid someone farewell.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = "Prozentuale Chance, mit der das Modul jemanden verabschieden soll. Erh\195\182he die Chance je mehr es verabschieden soll. Das ist ein Mittel um Spam/\195\132rger zu vermeiden."
L["The percent chance the module has to congratulate someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = "Prozentuale Chance mit der das Modul jemanden gratulieren soll. Erh\195\182he die Chance je mehr es begr\195\188\195\159en soll. Das ist ein Mittel um Spam/\195\132rger zu vermeiden."
L["The percent chance the module has to welcome someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = "Prozentuale Chance mit der das Modul jemanden willkommen hei\195\159en soll. Erh\195\182he die Chance je mehr es begr\195\188\195\159en soll. Das ist ein Mittel um Spam/\195\132rger zu vermeiden."
L["The size of the icon in the chat frame."] = "Symbolgr\195\182\195\159e im Chatfenster"
--[[Translation missing --]]
L["The time, in seconds, it takes for the same person to trigger the addon again."] = "The time, in seconds, it takes for the same person to trigger the addon again."
--[[Translation missing --]]
L["The time, in seconds, it takes for the same person to trigger the addon by saying ding."] = "The time, in seconds, it takes for the same person to trigger the addon by saying ding."
--[[Translation missing --]]
L["These are the keywords that the addon will look for first, when it finds a match then it will look for the actual profession being requested."] = "These are the keywords that the addon will look for first, when it finds a match then it will look for the actual profession being requested."
--[[Translation missing --]]
L["These channels apply to the General tab only."] = "These channels apply to the General tab only."
L["Thick Outline"] = "Dicke Kontur"
L[ [=[This addon is designed to add a lot of the functionality of full fledged chat addons like Prat or Chatter, but without a lot of the unneeded bloat.  I wrote it to be as lightweight as possible, while still powerful enough to accomplish it's intended function.
]=] ] = [=[Dieses Addon wurde entwickelt, um einen Gro\195\159teil der Funktionen des vollwertigen Chat Addons wie Prat oder Chatter zu integrieren, jedoch es unn\195\182tig aufzublasen. Ich schrieb, dass es so schlank wie m\195\182glich, dennoch stark genug, um die beabsichtigte Funktion erf\195\188llen.
]=]
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
L[ [=[This module is for numbered channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.

For more information see this addon's Curse page.]=] ] = [=[Dieses Modul ist nur f\195\188r nummerierte Kan\195\164le. Es erlaubt die Filterung von bestimmten W\195\182rtern und S\195\164tzen unter Verwendung von LUA-Vorlagen. F\195\188r ein Item, Erfolg, Zauber, etc. einfach den Namen des Items/Erfolgs/Zaubers benutzen. Nicht versuchen es zu verlinken.

F\195\188r weitere Informationen siehe die Addon-Seite auf Curse.com.]=]
--[[Translation missing --]]
L[ [=[This module keeps watch on your chat for certain commands and responds accordingly.
Type |cff00ff96!ctk|r or |cff00ff96!keys|r to pull keystone information.]=] ] = [=[This module keeps watch on your chat for certain commands and responds accordingly.
Type |cff00ff96!ctk|r or |cff00ff96!keys|r to pull keystone information.]=]
L["This module will send a chat message every time you loot an item on your list with how many you have, and if applicable it will tell you how many more you need based on your set quantity.  This is useful if you need X amount of Y to be able to cook Z."] = "Dieses Modul wird jedes Mal eine Chat-Nachricht senden, wenn ein Item aus der Liste gepl\195\188ndert wird. Es wird sagen wie viele Du hast und gegebenenfalls wird es sagen wie vile zur eingestellten Menge fehlen. Dies ist n\195\188tzlich, wenn z.B. die Menge X von Y ben\195\182tigt wird wird um Z kochen zu k\195\182nnen."
--[[Translation missing --]]
L["This will synchronize message and settings between guild members. Latter version of a message will be used by all guild members with synchronization enabled."] = "This will synchronize message and settings between guild members. Latter version of a message will be used by all guild members with synchronization enabled."
L["Throttle"] = "Drosselung"
L["Throttle Interval"] = "Verz\195\182gerung Intervall"
L["Throttle Messages"] = "Nachrichten Verz\195\182gerung"
L["Throttle output messages to prevent spam."] = "Ausgehende Nachrichten verz\195\182gern um Spam zu vermeiden."
--[[Translation missing --]]
L["Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable."] = "Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable."
L["Throttle Time"] = "Verz\195\182gerungszeit"
--[[Translation missing --]]
L["Throttle time prevented %s update."] = "Throttle time prevented %s update."
L[ [=[Throttle to only answer a question every X seconds, to prevent spam.

|cffff0000Not recommended to disable this.|r]=] ] = "Drosselung auf nur eine Nachricht alle X Sekunden m Spam zu vermeiden."
L["Time"] = "Zeit"
--[[Translation missing --]]
L["Time, in seconds, in between running the command."] = "Time, in seconds, in between running the command."
--[[Translation missing --]]
L[ [=[Time, in seconds, the module will wait after the first line is found to assume it is complete.

|cffffff00One (1) second seems to work.|r]=] ] = [=[Time, in seconds, the module will wait after the first line is found to assume it is complete.

|cffffff00One (1) second seems to work.|r]=]
L["Time, in seconds, to throttle output messages to prevent spam."] = "Zeit in Sekunden zur Verz\195\182gerung der ausgehenden Nachrichten um Spam zu vermeiden."
L["Time, in seconds, to throttle the zone list to prevent any spam."] = "Zeit in Sekunden zum Verz\195\182gern der Zonenliste um Spam zu vermeiden."
L["Time, in seconds, you want the search to continue before it ends."] = "Zeit in Sekunden"
L["Timestamp color"] = "Zeitstempelfarbe"
L["Timestamp format"] = "Zeitstempelformat"
L["Timestamps"] = "Zeitstempel"
--[[Translation missing --]]
L["To (|HBNplayer.-|h):"] = "To (|HBNplayer.-|h):"
--[[Translation missing --]]
L["To (|Hplayer.-|h):"] = "To (|Hplayer.-|h):"
--[[Translation missing --]]
L["To <Away>(|HBNplayer.-|h):"] = "To <Away>(|HBNplayer.-|h):"
--[[Translation missing --]]
L["To <Busy>(|HBNplayer.-|h):"] = "To <Busy>(|HBNplayer.-|h):"
L["TOC Version: |cff1784d1%s|r"] = true
--[[Translation missing --]]
L["Toggle Actionbar Keybinds"] = "Toggle Actionbar Keybinds"
--[[Translation missing --]]
L["Toggle Anchors"] = "Toggle Anchors"
L["Toggle coloring and change of the chat frame for pet combat log messages."] = "Umschalten der Einf\195\164rbung und \195\132nderung des Chatfensters f\195\188r Haustierkampf-Log-Nachrichten."
L["Toggle coloring and changing of the chat frame for pet battle info messages."] = "Umschalten der Einf\195\164rbung und \195\132nderung des Chatfensters f\195\188r Haustierkampf-Nachrichten."
L["Toggle the monitoring of chat events."] = "Schaltet die \195\156berwachung von Chat-Ereignissen um."
L["Toggle the pet list message when you enter a different zone."] = "Haustierliste umschalten, wenn eine andere Zone betreten wird."
--[[Translation missing --]]
L["Toggle the pet quality notifications when you join a wild pet battle."] = "Toggle the pet quality notifications when you join a wild pet battle."
--[[Translation missing --]]
L["Toggle the requirement of the Alt key to be pressed to use arrow keys to navigate an editbox."] = "Toggle the requirement of the Alt key to be pressed to use arrow keys to navigate an editbox."
--[[Translation missing --]]
L["Token Price"] = "Token Price"
--[[Translation missing --]]
L["Tooltip"] = "Tooltip"
--[[Translation missing --]]
L["Total Cost: $%d"] = "Total Cost: $%d"
L["Total Modules"] = "Anzahl aller Module"
L["Track Pets"] = "Verfolge Haustiere"
--[[Translation missing --]]
L["Track Stable Masters"] = "Track Stable Masters"
--[[Translation missing --]]
L["Tracking %s."] = "Tracking %s."
L["Trigger"] = "Ausl\195\182ser"
--[[Translation missing --]]
L["Trigger Chat"] = "Trigger Chat"
--[[Translation missing --]]
L["Trigger Loots"] = "Trigger Loots"
L["Triggers"] = "Ausl\195\182ser"
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
--[[Translation missing --]]
L["Unbalanced parameter count. Trailing Symbol: |cffffff00%s|r"] = "Unbalanced parameter count. Trailing Symbol: |cffffff00%s|r"
--[[Translation missing --]]
L["Unowned Only"] = "Unowned Only"
L["Unrecognized Symbol: |cffffff00%s|r"] = "Unerkannte Symbole: |cffffff00%s|r"
--[[Translation missing --]]
L["Unset variable |cffffff00%s|r."] = "Unset variable |cffffff00%s|r."
--[[Translation missing --]]
L["Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement."] = "Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement."
--[[Translation missing --]]
L["Uppercase"] = "Uppercase"
--[[Translation missing --]]
L["Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."] = "Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."
--[[Translation missing --]]
L["Use Alt Key"] = "Use Alt Key"
L["Use channel color"] = "Benutze Kanalfarbe"
L["Use Channel Color"] = "Benutze Channel-Farben"
--[[Translation missing --]]
L["Use Coins"] = "Use Coins"
--[[Translation missing --]]
L["Use coins in the answers instead of abbreviations."] = "Use coins in the answers instead of abbreviations."
L["Use Custom Color"] = "Verwende Benutzerdefinierte Farbe"
L["Use guildnotes"] = "Benutze Gilden Notizen"
--[[Translation missing --]]
L["Use Level Threshold"] = "Use Level Threshold"
--[[Translation missing --]]
L["Use Master Channel"] = "Use Master Channel"
L["Use PlayerNames Coloring"] = "Verwende Einf\195\164rben von SpielerNamen"
--[[Translation missing --]]
L["Use Short Name"] = "Use Short Name"
L["Use Tab Complete"] = "Benutze Tabulator Vervollst\195\164ndigung"
L["Use tab key to automatically complete character names."] = "Mit der Tabulator-Taste automatisch die Charakternamen vervollst\195\164ndigen"
--[[Translation missing --]]
L["Use the master channel when playing the sound."] = "Use the master channel when playing the sound."
--[[Translation missing --]]
L["Use this key to separate sync settings for different groups of peoples. Leave empty for default."] = "Use this key to separate sync settings for different groups of peoples. Leave empty for default."
--[[Translation missing --]]
L["using"] = "using"
L["Valid Events"] = "G\195\188ltige Ereignisse"
L["valor"] = "Tapferkeit"
--[[Translation missing --]]
L["Valor Points"] = "Valor Points"
--[[Translation missing --]]
L["Variable |cffffff00%s|r is set to |cff00ff00%s|r."] = "Variable |cffffff00%s|r is set to |cff00ff00%s|r."
--[[Translation missing --]]
L["Variable |cffffff00%s|r set to |cff00ff00%s|r."] = "Variable |cffffff00%s|r set to |cff00ff00%s|r."
L["Various Developer Tools"] = "Verschiedene Entwickler-Tools"
L["Version"] = true
--[[Translation missing --]]
L["Version %s%s|r is loaded. Type %s/ct|r if you need help."] = "Version %s%s|r is loaded. Type %s/ct|r if you need help."
L["Version: |cff1784d1%s|r"] = true
L["Very doubtful."] = "Sehr Zweifelhaft."
--[[Translation missing --]]
L["vp"] = "vp"
--[[Translation missing --]]
L["vpcap"] = "vpcap"
L["Warlock"] = "Hexenmeister"
L["WARLOCK"] = "HEXENMEISTER"
L["WARRIOR"] = "KRIEGER"
L["Warrior"] = "Krieger"
L["Welcome Message"] = "Willkommens Nachricht"
L["Welcome Messages"] = "Willkommensnachrict"
L["What to do with Recount/Skada/TinyDPS reports in this channel."] = "Was tun, wenn Recount/Skada/TinyDPS-Daten in dem Kanal gepostet werden."
--[[Translation missing --]]
L["What to show on the datatext."] = "What to show on the datatext."
--[[Translation missing --]]
L["When an ElvUI keyword is found it will show the message in a popup frame."] = "When an ElvUI keyword is found it will show the message in a popup frame."
--[[Translation missing --]]
L["When setting a variable the variable name must be the first parameter."] = "When setting a variable the variable name must be the first parameter."
--[[Translation missing --]]
L["When Talented Changes Talents"] = "When Talented Changes Talents"
--[[Translation missing --]]
L["Where AOE Taunts will be announced."] = "Where AOE Taunts will be announced."
--[[Translation missing --]]
L["Where taunts will be announced."] = "Where taunts will be announced."
--[[Translation missing --]]
L["Where the taunt fails will be announced."] = "Where the taunt fails will be announced."
L["Whisper"] = "Fl\195\188stern"
L["Whisper Answer"] = "Fl\195\188ster Antwort"
L["Whisper Messages"] = "Fl\195\188ster-Nachrichten"
L["Whisper Options"] = "Fl\195\188ster-Optionen"
L["Whisper the response to the person.  Otherwise it will be answered in the same channel the request was sent."] = "Fl\195\188ster die Antwort an die Person. Sonst wird es im selben Kanal geantwortet in dem die Anfrage gesendet wurde."
L["Whispers"] = "Fl\195\188stern"
L["Who"] = "Wer"
L["Who is %s's main?"] = "Wie hei\195\159t %s's Hauptcharakter?"
--[[Translation missing --]]
L["Who Taunted"] = "Who Taunted"
L["Who to Congratulate?"] = "Wem Gratulieren?"
--[[Translation missing --]]
L["Who Whispered Me"] = "Who Whispered Me"
--[[Translation missing --]]
L["Who: |cffffff00%s|r, Roll: |cffffff00%s|r, Min: |cffffff00%s|r, Max: |cffffff00%s|r"] = "Who: |cffffff00%s|r, Roll: |cffffff00%s|r, Min: |cffffff00%s|r, Max: |cffffff00%s|r"
--[[Translation missing --]]
L["Will automatically set your role based on your spec, when appropriate."] = "Will automatically set your role based on your spec, when appropriate."
L["Will save all data for large /who queries"] = "Speichert bei gro\195\159en /wer Anfragen alle Daten"
--[[Translation missing --]]
L["Win Color"] = "Win Color"
L["Without a doubt."] = "Ohne Zweifel."
L["XP Left To Level"] = "EPs ben\195\182tigt zum Aufstieg"
L["Year"] = "Jahr"
L["Yell"] = "Schreien"
L["Yell Chat"] = "Schreien-Chat"
L["Yes"] = "Ja"
L["Yes, definitely."] = "Ja, eindeutig."
--[[Translation missing --]]
L["You are missing %s%d|r pets."] = "You are missing %s%d|r pets."
L["You are running version |cff1784d1%s|r."] = "Du verwendest Version |cff1784d1%s|r."
L["You asked: %s"] = "Du fragtest: %t"
L["You can only send a request once every %d seconds.  You last sent a request at %s."] = "Du kannst nur alle %d Sekunden eine Anfrage schicken. Deine letzte Anfrage war um %s."
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
L["You have |cff%s%d|r of %s, you need |cff%s%d|r more. |cff%s(%d/%d)|r"] = "Du hast |cff%s%d|r %s, du ben\195\182tigst |cff%s%d|r mehr. |cff%s(%d/%d)|r"
L["You have |cff%s%d|r of %s."] = "Du hast |cff%s%d|r %s."
L["You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it."] = "Du verwendest das Addon |cff9382c9Chatter|r, welches nicht kompatibel ist, bitte deaktiviere es."
L["You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it."] = "Du verwendest das Addon |cff9382c9Prat-3.0|r, welches nicht kompatibel ist, bitte deaktiviere es."
--[[Translation missing --]]
L["You have already completed %s."] = "You have already completed %s."
--[[Translation missing --]]
L["You have met your quota of %s%s. |cff%s(%d/%d)|r"] = "You have met your quota of %s%s. |cff%s(%d/%d)|r"
L["You may rely on it."] = "Du kann dich drauf verlassen."
--[[Translation missing --]]
L["You must provide a calculation or set a variable."] = "You must provide a calculation or set a variable."
--[[Translation missing --]]
L["You need %s%s%s%sto hit level %d."] = "You need %s%s%s%sto hit level %d."
--[[Translation missing --]]
L["You Need To Move"] = "You Need To Move"
L["Your Color"] = "Deine Farbe"
L["Your version of %s is out of date.  Latest version is |cff1784d1%d|r."] = "Deine Version von %s ist veraltet, neuste Version ist |cff1784d1%d|r."
L["Your Version: |cffffff00%d|r, Latest Version: |cffffff00%d|r"] = "Deine Version: |cffffff00%d|r, Neuste Version: |cffffff00%d|r"
--[[Translation missing --]]
L["Yours"] = "Yours"
--[[Translation missing --]]
L["Zone List"] = "Zone List"

