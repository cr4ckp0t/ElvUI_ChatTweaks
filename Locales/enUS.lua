-------------------------------------------------------------------------------
-- ElvUI ChatTweaks By Crackpot (US, Thrall)
-------------------------------------------------------------------------------
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI_ChatTweaks", "enUS", true, true)
if not L then return end

L["   |cff00ff00%s|r - %s"] = true
L["   |cff00ff00%s|r or |cff00ff00%s|r - %s"] = true
L["   |cff00ff00/ct %s|r - %s"] = true
L["   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s"] = true
L[ [=[  Achievement Points
]=] ] = true
L[ [=[  Conquest Points
]=] ] = true
L[ [=[  Honor Points
]=] ] = true
L[ [=[  Justice Points
]=] ] = true
L[ [=[  Valor Points
]=] ] = true
L[" %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"] = true
L[" |cFFff5a00(Upgrade)|r"] = true
L[" |cffffff00%d|r Total Modules (|cff00ff00%d|r Enabled, |cffff0000%d|r Disabled)"] = true
L[" isn't a number."] = true
L[" isn't a recognized variable or number."] = true
L[ [=[

|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.]=] ] = true
L[ [=[

|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.

Addon Usage: |cff00ff00%s|r]=] ] = true
L["$EMPTY$"] = true
L["% Owned"] = true
L["% Unowned"] = true
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
L["%sChat Tweaks|r"] = true
L["%sElvUI Chat Tweaks|r by |cff0070deCrackpotx|r"] = true
L["(|HBNplayer.-|h): whispers:"] = true
L["(|Hplayer.-|h) says:"] = true
L["(|Hplayer.-|h) whispers:"] = true
L[", removing from list"] = true
L["/tt"] = true
L["|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"] = true
L["|cff00ff00%d|r Custom %s Being Used"] = true
L["|cff00ff00%s|r"] = true
L["|cff00ff00%s|r %s"] = true
L["|cff00ff00%s|r or |cff00ff00%s|r %s"] = true
L["|cff00ff00%s|r or |cff00ff00%s|r or |cff00ff00%s|r"] = true
L["|cff00ff00Enabled|r"] = true
L["|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r"] = true
L["|cFF5cb4f8Pet Battle - Tale of the Tape|r"] = true
L["|cffc7c7cfs|r"] = true
L["|cFFccff00Not Owned|r"] = true
L["|cffeda55fc|r"] = true
L["|cffff0000Disabled|r"] = true
L["|cffff0000Item|r |cffffffff\"%s\"|r |cffff0000does not exist.|r"] = true
L["|cffff0000No modules found.|r"] = true
L["|cffff0000The Chat Frame you chose to output reputation changes,|r |cffffffff%s|r|cffff0000, does not exist."] = true
L["|cffff9000Not in Pet Journal|r"] = true
L["|cffff9000Pet Journal:|r %s"] = true
L["|cffffc080Alts:|r %s"] = true
L["|cffffd700g|r"] = true
L["|cffffff00Character already in a guild."] = true
L["|cffffff00Character already in your guild."] = true
L["|cffffff00This abbreviation is unknown."] = true
L["|cffffff00Unable to execute secure command.|r |cffffffff%s|r"] = true
L["|cffffff00Usage: /ccolor <class>|r"] = true
L["|cffffff00Usage: /fake <id or link> <date in MM/DD/YY format>|r"] = true
L["|cffffff00Usage: /ginvite <name>|r"] = true
L["|cffffff00Usage: /gkick <name>|r"] = true
L["|cffffff00Usage: /hextorgb <hex code>|r"] = true
L["|cffffff00Usage: /in <delay> <command>|r"] = true
L["|cffffff00Usage: /rgbtohex <red> <green> <blue>|r"] = true
L["|cffffff00Usage: /rpt <times> <command>|r"] = true
L["|cffffffffYou have %s.|r"] = true
L["<ElvUI_CTC>"] = true
L["<no location>"] = true
L["<notarget>"] = true
L[ [=[A simple calculator used to perform basic operations on gold values.  Providing no parameters will show you how much gold you have.

You can include your current gold amount by using the |cff00ff00mymoney|r keyword.  For example |cff00ff00mymoney * 2|r.

|cffff0000Money amounts can only be added or subtracted, multiplication or division can only be performed with money and a number.  For example:  4g * 4 is okay, where 4g * 4g is invalid.]=] ] = true
L[ [=[A simple command-line calculator.  Certain keywords, listed below, can be used and their in game value will be substituted.  You can also assign variables which are saved for later use.

|cffffff00Keywords:|r
]=] ] = true
L["A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears."] = true
L["A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r."] = true
L["A Test of Valor"] = true
L["Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN."] = true
L["Abbreviations"] = true
L["achieve"] = true
L["Achievement Filter"] = true
L["Achievement for %s%s|r: %s"] = true
L["Achievement Messages"] = true
L["Activate in 5-man instances."] = true
L["Activate in guild."] = true
L["Active in your selected community"] = true
L["Active Modules"] = true
L["Add |cff00ff00/emotes|r Command"] = true
L["Add an |cff00ff00/emotes|r command to see what custom emotes you currently have running."] = true
L[ [=[Add custom emotes.  Please remember that your character's name will always be the first word.

|cff00ff00%t|r is your current target.]=] ] = true
L["Add custom names to the chat messages in this custom channel."] = true
L["Add custom names to the guild chat messages. (also include officer chat)."] = true
L["Add custom names to the instance chat messages, e.g., LFR and battlegrounds."] = true
L["Add custom names to the party chat messages."] = true
L["Add custom names to the raid chat messages."] = true
L["Add Group Trigger"] = true
L["Add Guild Trigger"] = true
L["Add item icons to loot received messages."] = true
L["Add Percentage"] = true
L["Add space after channels"] = true
L["Add surrounding brackets to own charname in messages."] = true
L["Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it."] = true
L["Add the player's alts to the tooltip."] = true
L["Add the player's main to the tooltip."] = true
L["Add word to your group invite trigger list"] = true
L["Add word to your guild invite trigger list."] = true
L["Addon enabled, but no message or channels selected."] = true
L["Addon Messages"] = true
L["Addon Version Sent, Version: |cffffff00%s|r"] = true
L["Adds a |cff00ff00/fake|r command for generating fake achievements."] = true
L[ [=[Adds a gamemenu button.

|cffffff00To disable the button, simply disable this module.

Please do a full reload after disable or enable.|r]=] ] = true
L[ [=[Adds a minimap button.

|cffffff00To disable the button, simply disable this module.|r]=] ] = true
L["Adds a timestamp to each line of text."] = true
L["Adds an ElvUI datatext for this addon."] = true
L["Adds chat commands |cff1784d1/chatframes|r and |cff1784d1/cf|r to help you identify the chat frames and their numbers."] = true
L[ [=[Adds chat commands to clear the chat windows.

]=] ] = true
L[ [=[Adds chat commands to show the current server token price in the chat windows.

]=] ] = true
L[ [=[Adds item links to Auction House messages.  Enabling this module will automatically disable the Auction Message Filter module.

|cffff0000If you do not have the item in your bags at the time of the system message firing then this will not be able to get the item link.  This is a limitation of the|r |cffffff00GetItemInfo()|r |cffff0000API function.  If this occurs, then the module will simple pass through the default message.|r]=] ] = true
L["Adds itemlevel to linked items in chat messages."] = true
L["Adds tell target slash command, |cff00ff00/tt|r."] = true
L[ [=[Adds the |cff00ff96/find|r and |cff00ff96/findall|r commands to search the chat history.

Usage:
    |cff00ff96/find <text>|r
    |cff00ff96/findall <text>|r]=] ] = true
L["Adds the |cff00ff96/role|r command for initiating a role poll in raids."] = true
L["Adds the chat commands |cff00ff96/zonelist|r, |cff00ff96/pets|r and |cff00ff96/mounts|r to provide information about your mounts and pets."] = true
L["AFK"] = true
L["AFK Messages"] = true
L["AFK/DND Filter"] = true
L["After"] = true
L["against"] = true
L["Alchemy"] = true
L["All"] = true
L["All Modules"] = true
L["AllCommunity"] = true
L["Allow guild synchronization"] = true
L["Allow someone to request a link of all your professions."] = true
L[ [=[Allows you to change the default font settings for the chat frames.

|cffff0000Using another addon to do this will break this functionality.|r]=] ] = true
L["Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command."] = true
L[ [=[Allows you to color the pet battle info messages, and determine which chat frame to send them to.

I am aware that some of the features of this module don't really pertain to the chat, but I couldn't really justify an entirely new addon.  So I just snuck them into here.]=] ] = true
L["Allows you to reroute auction house messages to a different chat frame."] = true
L[ [=[Allows you to use some fun filters on various chat channels.

|cffff0000This will break any links in the chat message.|r

|cffffff00Filters:|r
13375p34|<, ALL UPPERCASE, all lowercase, Capitalize Words, AlTeRnAtInG CaPs, BeTTeR ALTeRNaTiNG CaPS, sretteL esreveR, Gràvè Lèttèrs, Ácúté Léttérs, Ðïärësïs Lëttërs, Cîrcûmflêx Lêttêrs]=] ] = true
L["Alt + Left Click"] = true
L["Alt + Right Click"] = true
L["Alt Names"] = true
L["Alt note fallback"] = true
L["alt2"] = true
L["alt3"] = true
L["Alt-click name to invite"] = true
L["Alternate command to kick someone from guild."] = true
L["AlTeRnAtInG CaPs"] = true
L["Always"] = true
L["Always set your DND status while announcing to channels"] = true
L["and"] = true
L["Announce in chat who taunted."] = true
L["Announce interval, minutes"] = true
L["Announce settings"] = true
L["Announce to General"] = true
L["Announce to LFG"] = true
L["Announce to Trade"] = true
L["Announce your message to city trade channel."] = true
L["Announce your message to General channel when out of a city."] = true
L["Announce your message to LFG channel."] = true
L["Announcements"] = true
L["Announcing to General channel. Trade: %d LFG: %d"] = true
L["Announcing to LFG channel. Trade: %d LFG: %d"] = true
L["Announcing to Trade channel. Trade: %d LFG: %d"] = true
L["Anounce AOE Taunts"] = true
L["Anounce AOE Taunts Output:"] = true
L["Anounce AOE Taunts."] = true
L["Anounce Fails"] = true
L["Anounce Fails Output:"] = true
L["Anounce Taunts"] = true
L["Anounce Taunts Output:"] = true
L["Anounce taunts that fail."] = true
L["Anounce taunts."] = true
L["AOE"] = true
L["ap"] = true
L["Are you sure you want to delete all your saved class/level data?"] = true
L["Are you sure you want to disable all of the modules?"] = true
L["Are you sure you want to enable all of the modules?"] = true
L["Are you sure you want to reset the chat fonts to defaults?"] = true
L["As I see it, yes."] = true
L["Ask again later."] = true
L["Auction Created"] = true
L["Auction Expired"] = true
L["Auction Message Filtering"] = true
L["Auction Message Types"] = true
L["Auction Outbid"] = true
L["Auction Removed"] = true
L["Auction Sold"] = true
L["Auction Won"] = true
L["Auto Congratulate"] = true
L["Auto Ding"] = true
L["Auto Farewell"] = true
L["Auto Profession Link"] = true
L["Auto Set Role"] = true
L["Auto Welcome"] = true
L["Automatic Chat Logging"] = true
L["Automatically bid someone farewell when they leave your guild."] = true
L["Automatically congratulate someone when they, or others, complete an achievement."] = true
L["Automatically congratulates someone when they say \"ding\" in chat."] = true
L["Automatically enable tracking of pets for battles."] = true
L["Automatically enable tracking of Stable Masters to help you revive and/or heal your pets."] = true
L["Automatically enables chat logging."] = true
L["Automatically link someone the profession they requested via various keywords."] = true
L["Automatically Remove Item When Finished"] = true
L["Automatically welcomes someone to your guild."] = true
L["Available Chat Command Arguments"] = true
L["Available communities"] = true
L["Available parameters are |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."] = true
L["Battle.Net Convo"] = true
L["Battle.Net Options"] = true
L["Battle.Net Whisper"] = true
L["Before"] = true
L["Below are the keywords that the module will look for to substitute with the values described below."] = true
L["BeTTeR ALTeRNaTiNG CaPS"] = true
L["Better not tell you now."] = true
L["Bid Accepted"] = true
L["Blacksmithing"] = true
L["Bloodlust Announce"] = true
L["Bloodlust Announce is disabled, locate it under |cfff960d9KlixUI|r settings instead."] = true
L["Build Date: |cff1784d1%s|r"] = true
L["Build: |cff1784d1%s|r"] = true
L["Busy"] = true
L["Calculator"] = true
L["Cannot predict now."] = true
L["Can't set value '%s', doesn't look like a number."] = true
L["Capitalize Words"] = true
L["Capture Delay"] = true
L["Center"] = true
L["Changed Channel"] = true
L["Channel"] = true
L["Channel %d"] = true
L["Channel Colors"] = true
L["Channel Names"] = true
L["Channel Notice Filter"] = true
L["Channel Sounds"] = true
L["Channel to send the reminder to."] = true
L["Channels"] = true
L["Channels to Filter"] = true
L["Channels to look for questions."] = true
L["Channels to Monitor"] = true
L["Channels to Watch"] = true
L["Character to use between the name and level"] = true
L["Character to use for the left bracket"] = true
L["Character to use for the right bracket"] = true
L["Chat Events"] = true
L["Chat Fonts"] = true
L["Chat Frame "] = true
L["Chat Frame"] = true
L["Chat Frame %d"] = true
L["Chat Frame Settings"] = true
L["Chat frame to output the message to.  Default is |cffffff00ChatFrame3|r, which is the default frame for ElvUI XP messages."] = true
L["Chat frame to output the messages.  Default is ChatFrame3, which is the default output frame for reputation messages in ElvUI."] = true
L["Chat frame to route the auction house messages to."] = true
L["Chat frame to route the messages to."] = true
L["Chat frame to send the list to."] = true
L["Chat frame to send the messages to."] = true
L["Chat Frames To Watch"] = true
L["Chat Tabs"] = true
L["Chat Tweaks"] = true
L["Chat Window"] = true
L["ChatFrame %d"] = true
L["Chats To Monitor"] = true
L["Cheats Color"] = true
L["Choose the filter to use."] = true
L["Choose which chat frames display timestamps"] = true
L["Class"] = true
L["Clear all chat windows."] = true
L["Clear Chat Commands"] = true
L["Clear current chat."] = true
L["Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."] = true
L["Click to reset the materials you're tracking."] = true
L["Click to send the reminder to the select channel that the Magic 8-Ball is listening."] = true
L["Click to toggle ElvUI's config window.  This will also close this window."] = true
L["Client Locale: |cff1784d1%s|r"] = true
L["Coin Size"] = true
L["Color"] = true
L["Color a roll game loss, aka when you roll a one (1)."] = true
L["Color a roll game win, aka when someone else rolls a one (1)."] = true
L["Color by Channel"] = true
L["Color Cheats"] = true
L["Color Level"] = true
L["Color Loss"] = true
L["Color Name"] = true
L["Color of other's rolls."] = true
L["Color of the base reputation messages."] = true
L["Color of the faction."] = true
L["Color of the output message."] = true
L["Color of the reputation needed/left."] = true
L["Color of the standing (honored, revered, etc.)."] = true
L["Color own charname in messages."] = true
L["Color Player Names By..."] = true
L["Color regular rolls by others."] = true
L["Color Rolls"] = true
L["Color rolls differently to make tracking the roll game easier on the eyes."] = true
L["Color rolls that do not start at 1."] = true
L["Color self in messages"] = true
L["Color the messages by the channel the message came from."] = true
L["Color the name of the pets during a pet battle relative to their rarity.  If you have the pet you're currently battling it will also add the quality of the pet you have in your journal."] = true
L["Color timestamps the same as the channel they appear in."] = true
L[ [=[Color to change the filtered message to.

|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r.]=] ] = true
L["Color to designate a cheating roll."] = true
L["Color to designate a roll game loss."] = true
L["Color to designate a roll game win."] = true
L["Color to use for your rolls."] = true
L["Color Win"] = true
L["Color Your Rolls"] = true
L["Color your rolls to set them apart."] = true
L["Colorize"] = true
L["Combat Log Remover"] = true
L["Command Help"] = true
L["Companions"] = true
L["Complete"] = true
L["Compress"] = true
L["Concentrate and ask again."] = true
L["Congratulate achievements earned by guildmates."] = true
L["Congratulate achievements earned by people in your party."] = true
L["Congratulate achievements earned by people in your raid."] = true
L["Congratulate achievements earned by people near you."] = true
L["Congratulations Messages"] = true
L["conquest"] = true
L["Control + Left Click"] = true
L["Control + Right Click"] = true
L["Control when Talented should silence Learned/Unlearned system messages"] = true
L["Cooking"] = true
L["copper"] = true
L["Copy Links"] = true
L["cp"] = true
L["cpcap"] = true
L["Creates a button to click that will return you to the bottom of the chat frame."] = true
L["Custom Chat Filters"] = true
L["Custom chat filters."] = true
L["Custom color"] = true
L["Custom Emote: |cffffff00%s|r"] = true
L["Custom Emotes"] = true
L["Custom format (advanced)"] = true
L["Custom Named Chat Filters"] = true
L["Custom Names"] = true
L["Damage Meters"] = true
L["Datatext"] = true
L["Datatext Display"] = true
L["Date"] = true
L["Day"] = true
L["Death Knight"] = true
L["DEATHKNIGHT"] = true
L["Default font face for the chat frames."] = true
L["Default font outline for the chat frames."] = true
L["Default font size for the chat frames."] = true
L["Default Name Color"] = true
L["Destroys all your saved class/level data"] = true
L["Developer Tools"] = true
L["Ding Messages"] = true
L["Disable All Modules"] = true
L["Disable if you completed the achievement."] = true
L["Disable if you say ding."] = true
L["Disable if..."] = true
L["Disable in Battlegrounds"] = true
L["Disable in PvP Zones"] = true
L["Disable while you're AFK flagged."] = true
L["Disable while you're DND flagged."] = true
L["Disabled"] = true
L["Disabled %s%s|r module."] = true
L["Disabled Modules"] = true
L["Disables while you are in a battleground."] = true
L["Disables while you are in PvP Zones such as Ashran."] = true
L["Display a tooltip by hovering over a link in chat."] = true
L["Display Ability"] = true
L["Display armor/weapon type (Plate, Leather, ...)"] = true
L["Display equip location (Head, Trinket, ...)"] = true
L["Display item level"] = true
L["Display itemlevellinks when someone links an item in chat."] = true
L["Display itemlevellinks when someone loots an item."] = true
L["Display Keystone Conqueror achievement progress."] = true
L["Display Keystone Master achievement progress."] = true
L["Display the ability that was used to taunt."] = true
L["Displays reputation numbers and progress in the chat frame."] = true
L["DND Messages"] = true
L["Do not reply while in M+ dungeons."] = true
L["Do not use alphanumerical characters."] = true
L["Do Nothing"] = true
L["Do you want to automatically remove an item when you meet your quota?"] = true
L["Doesn't allow multiple announces from your guild members at the same time."] = true
L["Doesn't send anything to channels, simulating only."] = true
L["Dont Always Run"] = true
L["Don't count on it."] = true
L["Don't show your own failed taunts."] = true
L["Don't show your own taunts."] = true
L["DRUID"] = true
L["Druid"] = true
L["Dungeon Guide"] = true
L["Easy Channel"] = true
L["EditBox Alt Key Arrows"] = true
L["ElvUI ChatTweaks"] = true
L["ElvUI_ChatTweaks"] = true
L["ElvUI_CT"] = true
L["Emote"] = true
L["Emote Filter"] = true
L["Emphasize Self"] = true
L["Enable "] = true
L["Enable"] = true
L["Enable All Modules"] = true
L["Enable Debugging"] = true
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always congratulate."] = true
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always run."] = true
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always welcome."] = true
L["Enable to filter custom emotes made using |cff00ff00/emote|r or |cff00ff00/e|r."] = true
L["Enable to filter standard emotes such as |cff00ff00/dance|r or |cff00ff00/flirt|r."] = true
L["Enable various debugging messages to help with errors or undesired functioning."] = true
L["Enabled"] = true
L["Enabled %s%s|r module."] = true
L["Enabled Modules"] = true
L["Enables the whoing of friends."] = true
L["Enables the whoing of Guildmates."] = true
L[ [=[Enables you to replace channel names with your own names. You can use '%s' to force an empty string.

|cffffff00Please disable ElvUI Short Channel option for this to work, you'll find the option under /ec - Chat - General - Short Channels.]=] ] = true
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name.  Can also scan guild notes for character names to display, if no note has been manually set."] = true
L["Enabling this will send a message to your chat whenever you change a zone with a list of the Battle Pets that are obtainable in the zone.  You have the option to filter them based on whether or not you own them.  This will also add the chat command |cff00ff96/zonelist|r to send the list whenever.  Even if you disable this the chat commands will still work."] = true
L["Enchanting"] = true
L["Engineering"] = true
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = true
L["Enter a value in seconds."] = true
L["Equip Location"] = true
L["etc"] = true
L["Exclude level display for max level characters"] = true
L["Exclude max levels"] = true
L["Execution Interval"] = true
L["Faction Color"] = true
L["Failed:"] = true
L["Fake Achievement"] = true
L["Female"] = true
L["Filter achievement message spam!"] = true
L["Filter achievements earned by guildmates."] = true
L["Filter achievements earned by nearby people."] = true
L["Filter AFK messages."] = true
L["Filter AFK/DND auto responses.  This module is compatible with WIM."] = true
L["Filter by Player Level"] = true
L["Filter changed channel message."] = true
L["Filter Color"] = true
L["Filter DND messages."] = true
L["Filter Guild Achievements"] = true
L["Filter joined channel message."] = true
L["Filter left channel message."] = true
L["Filter Line"] = true
L["Filter Mode"] = true
L["Filter Nearby Achievements"] = true
L["Filter Pets"] = true
L["Filter spam throttle notices."] = true
L["Filter standard and/or custom emotes."] = true
L[ [=[Filter the Auction Created message.

|cffffff00%s|r]=] ] = true
L[ [=[Filter the Auction Expired message.

|cffffff00%s|r]=] ] = true
L[ [=[Filter the Auction Outbid message.

|cffffff00%s|r]=] ] = true
L[ [=[Filter the Auction Removed message.

|cffffff00%s|r]=] ] = true
L[ [=[Filter the Auction Sold message.

|cffffff00%s|r]=] ] = true
L[ [=[Filter the Auction Won message.

|cffffff00%s|r]=] ] = true
L[ [=[Filter the Bid Accepted message.

|cffffff00%s|r]=] ] = true
L["Filter the line containing the question."] = true
L[ [=[Filter what item quality should be displayed in chat.
|cfff960d9Quality steps: 0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary & 6 = Artifact|r]=] ] = true
L["Filtering Mode"] = true
L["Filters"] = true
L["Filters out Auction House system messages."] = true
L["Filters the channel notices."] = true
L["Font Color"] = true
L["Font Face"] = true
L["Font Size"] = true
L["Frame scraping timeout exceeded, results will be incomplete."] = true
L["Frame to output the messages to."] = true
L["Frame to send the addon messages to."] = true
L["Friends"] = true
L["Friends Whispers"] = true
L["Fun Filters"] = true
L["Gamemenu Button"] = true
L["General"] = true
L["General Tab Channels"] = true
L["Generate fake achievement links."] = true
L["ginv"] = true
L["ginvite"] = true
L["GInvite Alternate Command"] = true
L["Gives the ability to add custom names to the chat messages for better recognition."] = true
L["Gives you more flexibility in how you invite people to your group and guild."] = true
L["GKick Command"] = true
L["GKick Target: |cffffff00%s|r"] = true
L["gold"] = true
L["Gold Calculator"] = true
L["Group"] = true
L["Group Invite Links"] = true
L["Group Say Command"] = true
L["Guild"] = true
L["Guild Channel"] = true
L["Guild Chat"] = true
L["Guild cooperation mode"] = true
L["Guild Invite Links"] = true
L["Guild Messages"] = true
L["Guild Options"] = true
L["Guild Recruitment"] = true
L["Guild Whispers"] = true
L["Guildmates"] = true
L["GuildSync: Accepted configuration update from %s"] = true
L["GuildSync: Error. Bad configuration received from %s"] = true
L["Handles chat tab flashing."] = true
L["health"] = true
L["Here you can select which channels this module will scan for the keygroupWords to trigger the invite."] = true
L["HH:MM (12-hour)"] = true
L["HH:MM (24-hour)"] = true
L["HH:MM:SS (24-hour)"] = true
L["HH:MM:SS AM (12-hour)"] = true
L["Hide Compatibility Message"] = true
L["Hide name if it matches your character's name"] = true
L["Hide Own Failed Taunts"] = true
L["Hide Own Taunts"] = true
L["Hide the compatibility message in chat when KlixUI is installed."] = true
L["Hiding Configuration Options"] = true
L["Highlight Color"] = true
L["Highlight Substitutions"] = true
L["Highlight Term"] = true
L["Highlight the search term in the results."] = true
L["Highlight the substitutions that are made by changing their color."] = true
L["honor"] = true
L["honour"] = true
L["Hook the GameTooltip to add information to pet tooltips."] = true
L["Hook the tooltip to show the toon's main or alts."] = true
L["Hook Tooltip"] = true
L["Hour (12hr)"] = true
L["Hour (24hr)"] = true
L["Hover Links"] = true
L["How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command."] = true
L["How often announce your message to channel."] = true
L["How to filter any matches."] = true
L["Hunter"] = true
L["HUNTER"] = true
L["I am |cff1784d1%s|r"] = true
L["Icon Orientation"] = true
L["Icon Size"] = true
L["Icon to the left or right of the item link."] = true
L["Identify Chat Frames"] = true
L["If a keyword is found should the module filter the line?"] = true
L["If no name can be found for an 'alt' rank character, use entire note"] = true
L["If the name specified above matches your current character's name, this module will not add it again if this option is checked."] = true
L["Ignore any messages you send containing keywords."] = true
L["Ignore Your Messages"] = true
L[ [=[Improve the Auction Expired message.

|cffffff00%s|r]=] ] = true
L[ [=[Improve the Auction Outbid message.

|cffffff00%s|r]=] ] = true
L[ [=[Improve the Auction Removed message.

|cffffff00%s|r]=] ] = true
L[ [=[Improve the Auction Sold message.

|cffffff00%s|r]=] ] = true
L[ [=[Improve the Auction Won message.

|cffffff00%s|r]=] ] = true
L["Improved Auction Messages"] = true
L["In Command"] = true
L["Inactive Modules"] = true
L["Include level"] = true
L["Include Prefix"] = true
L["Include the"] = true
L["Include the player's level"] = true
L["Incomplete"] = true
L["Inscription"] = true
L["Instance"] = true
L["Instance Channel"] = true
L["Instance Leader"] = true
L[ [=[Instantly send the information of whom whispered you.

]=] ] = true
L["inv"] = true
L["Invalid achievement ID for %s%d|r."] = true
L["Invalid achievement link provided."] = true
L["Invalid format found on entry \"%s\"."] = true
L["invite"] = true
L["Invite Links"] = true
L["It is certain."] = true
L["It is decidedly so."] = true
L["Item Level"] = true
L["Item Level Link"] = true
L["Jewelcrafting"] = true
L["Joined Channel"] = true
L["jp"] = true
L["jpcap"] = true
L["Just one character."] = true
L["justice"] = true
L["Keeps your channel colors by name rather than by number."] = true
L["Keybinds"] = true
L["Keystone Announce"] = true
L["Keystone Conqueror Completion Status"] = true
L["Keystone Master Completion Status"] = true
L["Keystone Progress"] = true
L["Keyword Sounds"] = true
L["Keywords"] = true
L["Leatherworking"] = true
L["Left"] = true
L["Left Bracket"] = true
L["Left Channel"] = true
L["Left Click"] = true
L["Lets you alt-click player names to invite them to your party."] = true
L["Lets you set the justification of text in your chat frames."] = true
L["Level Difference"] = true
L["Level Location"] = true
L["Level: |cffffff00%s|r, Message: |cffffff00%s|r"] = true
L["Link All Professions"] = true
L["Login"] = true
L["Look in guildnotes for character names, unless a note is set manually"] = true
L["Loot Icons"] = true
L["Loss Color"] = true
L["lowercase"] = true
L["MAGE"] = true
L["Mage"] = true
L["Magic 8-Ball"] = true
L["Magic 8-Ball says: %s"] = true
L["Magic 8-Ball Says: I am ready to answer your questions!  Do \"%s <question>\" to ask me a question."] = true
L["Main: "] = true
L["Makes it easy to identify which person popped bloodlust/heroism."] = true
L["Makes it easy to navigate through the different channels by pressing the 'TAB' Key."] = true
L["Male"] = true
L["mana"] = true
L["Material Quantities"] = true
L["Materials Farming"] = true
L["Materials to Track"] = true
L["Maximum Delay"] = true
L["Maximum time, in seconds, to wait before bidding someone farewell."] = true
L["Maximum time, in seconds, to wait before congratulating someone."] = true
L["Maximum time, in seconds, to wait before welcoming someone."] = true
L["Maximum time, in seconds, to wait before whispering someone the link."] = true
L["Message Color"] = true
L["Message color."] = true
L["Message highlight color."] = true
L["Message Settings"] = true
L["Message Throttle"] = true
L["Message to announce, 2 lines max"] = true
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
L["Minimap Button"] = true
L["Minimum Delay"] = true
L["Minimum Level"] = true
L["Minimum level required for an achievement to not be filtered."] = true
L["Minimum time, in seconds, to wait before bidding someone farewell."] = true
L["Minimum time, in seconds, to wait before congratulating someone."] = true
L["Minimum time, in seconds, to wait before welcoming someone."] = true
L["Minimum time, in seconds, to wait before whispering someone the link."] = true
L["Minute"] = true
L["MM:SS"] = true
L["Monitor Chat Events"] = true
L["Monitor guild chat."] = true
L["Monitor party chat."] = true
L["Monitor raid chat."] = true
L["Monitor say chat."] = true
L["Monitor text in this channel for link triggers."] = true
L["Monitor whispers."] = true
L["Monitor yell chat."] = true
L["Monk"] = true
L["MONK"] = true
L["Monster Emote"] = true
L["Monster Say"] = true
L["Month"] = true
L["Most likely."] = true
L["Multiple Achievement Messages"] = true
L["Multiple Invite Command"] = true
L["My reply is no."] = true
L["My sources say no."] = true
L["Name"] = true
L["Name color"] = true
L["Nearby People"] = true
L["Never"] = true
L["New Version Notify"] = true
L["No"] = true
L["No custom emotes are currently being used."] = true
L["No Filter"] = true
L["No RealNames"] = true
L["None"] = true
L["Not Capturable"] = true
L["Not Found"] = true
L["Not Owned"] = true
L["Not tracking %s."] = true
L["NoTarget"] = true
L["Notifies your party or raid if people are taking a lot of avoidable damage from ground auras."] = true
L["Notify on new release?"] = true
L["Notify on Role Set"] = true
L["Num Channels"] = true
L["Numbered Channels"] = true
L["Off"] = true
L["Officer"] = true
L["Officer Channel"] = true
L["Officer Chat"] = true
L["On"] = true
L["On (%d min)"] = true
L["On (%d sec)"] = true
L["One or more of the changes you have made require you to reload your UI."] = true
L["Only filter achievements earned by players below a certain level."] = true
L["Open Config"] = true
L["Open ElvUI Config"] = true
L["Open ElvUI's Config"] = true
L["Opens configuration window."] = true
L["Other Channels"] = true
L["Ouput Frame"] = true
L["Outline"] = true
L["Outlook good."] = true
L["Outlook not so good."] = true
L["Output Channel"] = true
L["Output Color"] = true
L["Output color of the rerouted messages."] = true
L["Output Frame"] = true
L["Output Message Every..."] = true
L["Output the message every X times you gain XP."] = true
L["Output To..."] = true
L["Owned Only"] = true
L["PALADIN"] = true
L["Paladin"] = true
L["Parameter: |cffffff00%s|r"] = true
L["Party"] = true
L["Party Channel"] = true
L["Party Leader"] = true
L["Party Members"] = true
L["Percent Chance"] = true
L["Perhaps you meant '*' (multiplication)?"] = true
L["Pet Battle Info"] = true
L["Pet Battles"] = true
L["Pet Combat Log"] = true
L["Pets Per Line"] = true
L["Place the level before or after the player's name."] = true
L["Play a sound when it pops up."] = true
L["Play Sound"] = true
L["Player Class"] = true
L["Player Level"] = true
L["Player level display options."] = true
L["Player Names"] = true
L["Player's Average iLvl"] = true
L["Player's Class"] = true
L["Player's Gender"] = true
L["Player's Health"] = true
L["Player's Health Deficit"] = true
L["Player's Health Percent"] = true
L["Players Level"] = true
L["Player's Location"] = true
L["Player's Mana"] = true
L["Player's Mana Deficit"] = true
L["Player's Mana Percent"] = true
L["Player's Max Health"] = true
L["Player's Max Mana"] = true
L["Player's Name"] = true
L["Player's X-Coordinate"] = true
L["Player's Y-Coordinate"] = true
L["Player's Zone"] = true
L["Plays a sound when one of your ElvUI keywords is found."] = true
L["Plays a sound, of your choosing (via LibSharedMedia-3.0), whenever a message is received in a given channel."] = true
L["Plugins by |cff0070deCrackpotx|r"] = true
L["Popup"] = true
L["Popup Messages"] = true
L["PopupMessage"] = true
L["power"] = true
L["Prefix Character"] = true
L["prefix when a message's output is"] = true
L["PRIEST"] = true
L["Priest"] = true
L["Print Addon Version"] = true
L["Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues."] = true
L["Print this again."] = true
L["Prints a link you can click to congratulate when someone obtains an achievement."] = true
L["Prints a message in the chat with your remain XP needed to level up."] = true
L["Prints module status."] = true
L["Progress Updates"] = true
L["Provides |cff00ff00/ginv|r, an alternative to |cff00ff00/ginvite|r command, for us lazy folks."] = true
L[ [=[Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.

Module Written by Björn Benjamin Hiller <bjoern.hiller@gmail.com>]=] ] = true
L["Provides a /in command to delay the execution of code in macros and other settings."] = true
L["Provides a |cff00ff00/gkick|r command, as it should be."] = true
L["Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically."] = true
L[ [=[Provides a few tools to help me (Crackpotx), develop this addon as well as diagnose and fix any errors that are reported.

|cff00ff00You can leave this addon disabled unless I (Crackpotx) ask you to enable it for some debugging.|r]=] ] = true
L["Provides basic chat subtitutions."] = true
L["Provides keybinds to make talking in a specific chat easier."] = true
L["Provides options to color player names, add player levels, and add tab completion of player names."] = true
L[ [=[Put each emote on a separate line.
Separate the command from the text with a colon (":").]=] ] = true
L["Quality"] = true
L["Quality Notification"] = true
L["Raid"] = true
L["Raid Boss Emote"] = true
L["Raid Channel"] = true
L["Raid Leader"] = true
L["Raid Members"] = true
L["Raid Warning"] = true
L["Raid Warning Channel"] = true
L["Random Number"] = true
L["Ready Check Command"] = true
L["RealID Brackets"] = true
L["Really remove this word from your trigger list?"] = true
L["Release Command"] = true
L["ReloadUI"] = true
L["Remaining: %s, Cost: $%d"] = true
L["Reminder"] = true
L["Remove"] = true
L["Remove a word from your group invite trigger list"] = true
L["Remove a word from your guild invite trigget list."] = true
L["Remove Group Trigger"] = true
L["Remove Guild Trigger"] = true
L["Removes the combat log chattab from the chat window."] = true
L["Repeat Command"] = true
L["Repeat Question"] = true
L["Repeat the question when giving a response."] = true
L["Replace this channel name with..."] = true
L["Reply hazy, try again."] = true
L["Reported by %s"] = true
L["Reputation"] = true
L["Reputation Color"] = true
L["Require the alt key to be pressed to use the arrow keys on editboxes."] = true
L["Reroute Auction Messages"] = true
L["Reset alt names and their mains."] = true
L["Reset ChatFrame text justifications to defaults (left)."] = true
L["Reset Data"] = true
L["Reset Font Data"] = true
L["Reset Materials"] = true
L["Reset Names"] = true
L[ [=[Reset saved mains/alts.

|cffff0000This CANNOT be undone.|r]=] ] = true
L["Reset Text Justitification"] = true
L["Resets all chat frames to their original font settings."] = true
L["Right"] = true
L["Right Bracket"] = true
L["Right Click"] = true
L["Rogue"] = true
L["ROGUE"] = true
L["Role Poll Command"] = true
L["Role Set: %s%s|r"] = true
L["Role will not be set while in combat."] = true
L["Roll Color"] = true
L["Roll Pattern: |cffffff00%s|r"] = true
L["'s"] = true
L["Save all /who data"] = true
L["Save class data from /who queries between sessions."] = true
L["Save class data from friends between sessions."] = true
L["Save class data from groups between sessions."] = true
L["Save class data from guild between sessions."] = true
L["Save class data from target/mouseover between sessions."] = true
L["Save Data"] = true
L["Save data between sessions. Will increase memory usage"] = true
L["Say"] = true
L["Say Chat"] = true
L["Scrape Time"] = true
L["Scroll Reminder"] = true
L["Search"] = true
L["Search Results |cff9382c9(%d Found)|r:"] = true
L["Search Results:"] = true
L["Search term is too short."] = true
L["Second"] = true
L["Select a color for this channel."] = true
L["Select a method for coloring player names"] = true
L["Select an option if you want the zone list to only contain pets you own or do not own."] = true
L["Select channels"] = true
L["Select how you want the player's level colored."] = true
L["Select the channels to apply the filter to."] = true
L["Select the channels you want monitored."] = true
L["Select the channels you want to monitor."] = true
L["Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number."] = true
L["Select the custom color to use for alt names"] = true
L["Select which channels to flash when a message is received."] = true
L["Select which factions you would like to receive notifications for."] = true
L["Self"] = true
L["Semi-Auto Congratulate"] = true
L["Send a chat message when a role is set/changed."] = true
L["Send a tell to your target."] = true
L["Send a whisper to the person who left."] = true
L["Send Guild Messages"] = true
L["Send guild recruitment messages to various chat channels."] = true
L["Send messages to guild chat when someone leaves."] = true
L["Send Reminder"] = true
L["Send Whisper"] = true
L["Separator"] = true
L["Set DND"] = true
L["Set DND message"] = true
L["Set Main"] = true
L["Set the coloring mode for alt names"] = true
L["Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel."] = true
L["Set the sound to play."] = true
L["Settings"] = true
L["Shaman"] = true
L["SHAMAN"] = true
L["Shift + Left Click"] = true
L["Shift + Right Click"] = true
L["Short Format"] = true
L["Short format (P for plate, L for leather, ...)"] = true
L["Show Alts"] = true
L["Show Armor Type"] = true
L["Show current to total XP percentage."] = true
L["Show current token price at login."] = true
L["Show current token price."] = true
L["Show ElvUI Chat Tweaks Config Window"] = true
L["Show how many whispers you've received this session."] = true
L["Show how many whispers, you've received this session."] = true
L["Show Main"] = true
L["Show Percentage"] = true
L["Show remaining rested XP."] = true
L["Show Rested XP"] = true
L["Show the total number of modules on the datatext."] = true
L["Show toon names instead of real names"] = true
L["Show Total XP"] = true
L["Show total XP needed to level."] = true
L["Show welcome message when logging in."] = true
L["Showing Configuration Options"] = true
L["Shows messages in a popup frame."] = true
L["Signs point to yes."] = true
L["Silence in M+"] = true
L["Silence Learned/Unlearned system messages."] = true
L["silver"] = true
L["Similar to the |cffffffIn Command|r module, except it will repeat the command X times."] = true
L["Size of the coin icons.  Generally you want to use your font size or smaller."] = true
L["Skipping. Message already advertised by %s"] = true
L["Skipping. Trade: %d LFG: %d"] = true
L["Smart Group Channel"] = true
L["Sound"] = true
L[ [=[Sound to play when a message in %s is received.

|cff00ff00To disable set to "None"|r.]=] ] = true
L["Spam CoolDown"] = true
L["Spam Delay"] = true
L["SPAM protection, lines"] = true
L["Spam Throttle"] = true
L["Squelch"] = true
L["sretteL esreveR"] = true
L["Standard Emote: |cffffff00%s|r"] = true
L["Standard Emotes"] = true
L["Standing Color"] = true
L["Stopped tracking %s."] = true
L["Strip RealID brackets"] = true
L["Substitutions"] = true
L["Suppress"] = true
L["Suppress Recount/Skada/TinyDPS output into a clickable link, or filter it entirely."] = true
L["Symbol: |cffffff00%s|r"] = true
L["SYNC_KEY_HELP"] = true
L["Synchronization key"] = true
L["Tailoring"] = true
L["Talent Squelch"] = true
L["Talk to your group based on party/raid status."] = true
L["Target/Mouseover"] = true
L["Target: |cffffff00%s|r"] = true
L["Target's Class"] = true
L["Target's Gender"] = true
L["Target's Health"] = true
L["Target's Health Deficit"] = true
L["Target's Health Percent"] = true
L["Target's Level"] = true
L["Target's Mana"] = true
L["Target's Mana Deficit"] = true
L["Target's Mana Percent"] = true
L["Target's Max Health"] = true
L["Target's Max Mana"] = true
L["Target's Name"] = true
L["taunt"] = true
L["taunted"] = true
L["Tell Target"] = true
L["Test mode"] = true
L["Text Justification"] = true
L["Text justification for ChatFrame %d."] = true
L["Text to trigger the addon to answer a question."] = true
L[ [=[Thanks for using and supporting my work!  -- |cff0070deCrackpotx|r

|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge.]=] ] = true
L["The amount of each material you'd like to farm.  If you want an unlimited amount simply put a 0.  You must add a quantity for every entry, and it must correspond to the same line in the other box."] = true
L["The character in front of abbreviations to be recognised as such."] = true
L["The chat window taunts will be announced in when the output is set to"] = true
L["The classic Magic 8-Ball brought to World of Warcraft!"] = true
L["The color to highlight the search term."] = true
L["The color to use when highlighting a substitution."] = true
L["The default color to use to color names."] = true
L[ [=[The name or ID of the material you'd like to track.

|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r]=] ] = true
L["The name that should be displayed in your chat messages."] = true
L["The percent chance the module has to bid someone farewell.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["The percent chance the module has to congratulate someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["The percent chance the module has to welcome someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["The size of the icon in the chat frame."] = true
L["The time, in seconds, it takes for the same person to trigger the addon again."] = true
L["The time, in seconds, it takes for the same person to trigger the addon by saying ding."] = true
L["These are the keywords that the addon will look for first, when it finds a match then it will look for the actual profession being requested."] = true
L["These channels apply to the General tab only."] = true
L["Thick Outline"] = true
L[ [=[This addon is designed to add a lot of the functionality of full fledged chat addons like Prat or Chatter, but without a lot of the unneeded bloat.  I wrote it to be as lightweight as possible, while still powerful enough to accomplish it's intended function.
]=] ] = true
L["This add-on will try to prevent spamming to idle channels. If there is no activity in a channel, then it waits a little longer. Specify how many lines should pass before add-on is allowed to announce message."] = true
L[ [=[This module adds a command to check your progress on the Keystone Conqueror and Master achievements.

|cff00ff00/ksc|r - Keystone Conqueror Progress
|cff00ff00/ksm|r - Keystone Master Progress
Use |cff00ff00track|r to toggle achievement tracking for each achievement.]=] ] = true
L[ [=[This module is for named channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.

For more information see this addon's Curse page.]=] ] = true
L[ [=[This module is for numbered channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.

For more information see this addon's Curse page.]=] ] = true
L[ [=[This module keeps watch on your chat for certain commands and responds accordingly.
Type |cff00ff96!ctk|r or |cff00ff96!keys|r to pull keystone information.]=] ] = true
L["This module will send a chat message every time you loot an item on your list with how many you have, and if applicable it will tell you how many more you need based on your set quantity.  This is useful if you need X amount of Y to be able to cook Z."] = true
L["This will synchronize message and settings between guild members. Latter version of a message will be used by all guild members with synchronization enabled."] = true
L["Throttle"] = true
L["Throttle Interval"] = true
L["Throttle Messages"] = true
L["Throttle output messages to prevent spam."] = true
L["Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable."] = true
L["Throttle Time"] = true
L["Throttle time prevented %s update."] = true
L[ [=[Throttle to only answer a question every X seconds, to prevent spam.

|cffff0000Not recommended to disable this.|r]=] ] = true
L["Time"] = true
L["Time, in seconds, in between running the command."] = true
L[ [=[Time, in seconds, the module will wait after the first line is found to assume it is complete.

|cffffff00One (1) second seems to work.|r]=] ] = true
L["Time, in seconds, to throttle output messages to prevent spam."] = true
L["Time, in seconds, to throttle the zone list to prevent any spam."] = true
L["Time, in seconds, you want the search to continue before it ends."] = true
L["Timestamp color"] = true
L["Timestamp format"] = true
L["Timestamps"] = true
L["To (|HBNplayer.-|h):"] = true
L["To (|Hplayer.-|h):"] = true
L["To <Away>(|HBNplayer.-|h):"] = true
L["To <Busy>(|HBNplayer.-|h):"] = true
L["TOC Version: |cff1784d1%s|r"] = true
L["Toggle Actionbar Keybinds"] = true
L["Toggle Anchors"] = true
L["Toggle coloring and change of the chat frame for pet combat log messages."] = true
L["Toggle coloring and changing of the chat frame for pet battle info messages."] = true
L["Toggle the monitoring of chat events."] = true
L["Toggle the pet list message when you enter a different zone."] = true
L["Toggle the pet quality notifications when you join a wild pet battle."] = true
L["Toggle the requirement of the Alt key to be pressed to use arrow keys to navigate an editbox."] = true
L["Token Price"] = true
L["Tooltip"] = true
L["Total Cost: $%d"] = true
L["Total Modules"] = true
L["Track Pets"] = true
L["Track Stable Masters"] = true
L["Tracking %s."] = true
L["Trigger"] = true
L["Trigger Chat"] = true
L["Trigger Loots"] = true
L["Triggers"] = true
L[ [=[Turns the timestamps into a link.

Click the link to copy the chat line.
Shift+Click the link to send the line to the last chat you used.]=] ] = true
L["Type DND message there."] = true
L["Type the message to announce, every line will be announced. Message should not be longer than 2 lines."] = true
L["Unable to load the Alt Name module, please try again."] = true
L["Unbalanced parameter count. Trailing Symbol: |cffffff00%s|r"] = true
L["Unowned Only"] = true
L["Unrecognized Symbol: |cffffff00%s|r"] = true
L["Unset variable |cffffff00%s|r."] = true
L["Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement."] = true
L["Uppercase"] = true
L["Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."] = true
L["Use Alt Key"] = true
L["Use channel color"] = true
L["Use Channel Color"] = true
L["Use Coins"] = true
L["Use coins in the answers instead of abbreviations."] = true
L["Use Custom Color"] = true
L["Use guildnotes"] = true
L["Use Level Threshold"] = true
L["Use Master Channel"] = true
L["Use PlayerNames Coloring"] = true
L["Use Short Name"] = true
L["Use Tab Complete"] = true
L["Use tab key to automatically complete character names."] = true
L["Use the master channel when playing the sound."] = true
L["Use this key to separate sync settings for different groups of peoples. Leave empty for default."] = true
L["using"] = true
L["Valid Events"] = true
L["valor"] = true
L["Valor Points"] = true
L["Variable |cffffff00%s|r is set to |cff00ff00%s|r."] = true
L["Variable |cffffff00%s|r set to |cff00ff00%s|r."] = true
L["Various Developer Tools"] = true
L["Version"] = true
L["Version %s%s|r is loaded. Type %s/ct|r if you need help."] = true
L["Version: |cff1784d1%s|r"] = true
L["Very doubtful."] = true
L["vp"] = true
L["vpcap"] = true
L["Warlock"] = true
L["WARLOCK"] = true
L["WARRIOR"] = true
L["Warrior"] = true
L["Welcome Message"] = true
L["Welcome Messages"] = true
L["What to do with Recount/Skada/TinyDPS reports in this channel."] = true
L["What to show on the datatext."] = true
L["When an ElvUI keyword is found it will show the message in a popup frame."] = true
L["When setting a variable the variable name must be the first parameter."] = true
L["When Talented Changes Talents"] = true
L["Where AOE Taunts will be announced."] = true
L["Where taunts will be announced."] = true
L["Where the taunt fails will be announced."] = true
L["Whisper"] = true
L["Whisper Answer"] = true
L["Whisper Messages"] = true
L["Whisper Options"] = true
L["Whisper the response to the person.  Otherwise it will be answered in the same channel the request was sent."] = true
L["Whispers"] = true
L["Who"] = true
L["Who is %s's main?"] = true
L["Who Taunted"] = true
L["Who to Congratulate?"] = true
L["Who Whispered Me"] = true
L["Who: |cffffff00%s|r, Roll: |cffffff00%s|r, Min: |cffffff00%s|r, Max: |cffffff00%s|r"] = true
L["Will automatically set your role based on your spec, when appropriate."] = true
L["Will save all data for large /who queries"] = true
L["Win Color"] = true
L["Without a doubt."] = true
L["XP Left To Level"] = true
L["Year"] = true
L["Yell"] = true
L["Yell Chat"] = true
L["Yes"] = true
L["Yes, definitely."] = true
L["You are missing %s%d|r pets."] = true
L["You are running version |cff1784d1%s|r."] = true
L["You asked: %s"] = true
L["You can only send a request once every %d seconds.  You last sent a request at %s."] = true
L["You can use $gname tag in text. This will be replaced by your guild name."] = true
L["You have %s%d (%d unique, %d duplicates)|r pets."] = true
L["You have %s%d|r duplicate pets."] = true
L["You have %s%d|r mounts."] = true
L["You have %s%d|r unique pets."] = true
L["You have |cff%s%d|r of %s, you need |cff%s%d|r more. |cff%s(%d/%d)|r"] = true
L["You have |cff%s%d|r of %s."] = true
L["You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it."] = true
L["You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it."] = true
L["You have already completed %s."] = true
L["You have met your quota of %s%s. |cff%s(%d/%d)|r"] = true
L["You may rely on it."] = true
L["You must provide a calculation or set a variable."] = true
L["You need %s%s%s%sto hit level %d."] = true
L["You Need To Move"] = true
L["Your Color"] = true
L["Your version of %s is out of date.  Latest version is |cff1784d1%d|r."] = true
L["Your Version: |cffffff00%d|r, Latest Version: |cffffff00%d|r"] = true
L["Yours"] = true
L["Zone List"] = true

