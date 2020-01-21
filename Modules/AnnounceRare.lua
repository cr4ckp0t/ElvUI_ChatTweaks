-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Crackpotx (US, Lightbringer)
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
local Module = ElvUI_ChatTweaks:NewModule("Announce Rare", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)

Module.name = L["Announce Rare"]
Module.namespace = string.gsub(Module.name, " ", "")
Module.cooldown = 180
Module.rares = {}
Module.correctZone = false
Module.zones = {
	1462, -- mechagon
	1355, -- nazjatar
	1530, -- vale of eternal blossoms
	1527, -- uldum
}

local db, options
local defaults = {
	global = {
		advertise = false,
		drill = true,
		output = "CHANNEL",
	}
}


local function GetTargetId()
	local guid = UnitGUID("target")
	if guid == nil then return nil end
	local unitType, _, _, _, _, unitId = strsplit("-", guid);
	return (unitType == "Creature" or UnitType == "Vehicle") and tonumber(unitId) or nil
end

local function GetNPCGUID(guid)
	if guid == nil then return nil end
	local unitType, _, _, _, _, unitId = strsplit("-", guid);
	return (unitType == "Creature" or UnitType == "Vehicle") and tonumber(unitId) or nil
end

local function GetGeneralChannelNumber()
	local channelFormat = "%s - %s"
	local channelRUFormat = "%s: %s"
	local zoneText = GetZoneText()
	local general = EnumerateServerChannels()
	if zoneText == nil or general == nil then return false end
	return GetChannelName(GetLocale() == "ruRU" and channelRUFormat:format(general, zoneText) or channelFormat:format(general, zoneText))
end

-- Time Displacement
local function IsInAltTimeline()
	for i = 1, 40 do
		local name = UnitAura("player", i)
		if name == L["Time Displacement"] then
			return true
		end
	end
	return false
end

local function FormatNumber(n)
    if n >= 10^6 then
        return format("%.2fm", n / 10^6)
    elseif n >= 10^3 then
        return format("%.2fk", n / 10^3)
    else
        return tostring(n)
    end
end

local function FindInArray(toFind, arraySearch)
	if #arraySearch == 0 then return false end
	for _, value in pairs(arraySearch) do
		if value == toFind then
			return true
		end
	end
	return false
end

local function DecRound(num, decPlaces)
	return format("%." .. (decPlaces or 0) .. "f", num)
end

function Module:ParseLink()

end

function Module:PLAYER_ENTERING_WORLD()
	self.rares = self:LoadRares()
end

function Module:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RawHook("SetItemRef", "ParseLink", true)
end

function Module:OnDisable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnhookAll()
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.global
	self.debug = ElvUI_ChatTweaks.db.global.debugging
end

function Module:GetOptions()
	if not options then
		options = {
			advertise = {
				type = "toggle",
				order = 13,
				name = L["Advertise ECT"],
				desc = L["Adds a prefix to chat messages with the name of the addon."],
				get = function(info) return db.advertise end,
				set = function(info, value) db.advertise = value end,
			},
			output = {
				type = "select",
				order = 14,
				name = L["Channel Output"],
				desc = L["Channel to send the messages to."],
				values = {
					["CHANNEL"] = L["General Chat"],
					["SAY"] = L["Say"],
					["YELL"] = L["Yell"],
					["PARTY"] = L["Party"],
					["RAID"] = L["Raid"],
					["GUILD"] = L["Guild"],
					["OFFICER"] = L["Officer"],
				},
				get = function(info) return db.output end,
				set = function(info, value) db.output = value end,
			},
			drill = {
				type = "toggle",
				order = 15,
				name = L["Drill Announcements"],
				desc = L["Announce drill sites to let people know what mob is about to be available."],
				get = function(info) return db.drill end,
				set = function(info, value) db.drill = value end,
			},
			tomtom = {
				type = "toggle",
				order = 16,
				name = L["TomTom Waypoints"],
				desc = L["Automatically create TomTom waypoints for you when a drill site is activated.\n\n|cffff0000REQUIRES TOMTOM ADDON!|r"],
				disabled = function() return not db.drill end,
				get = function(info) return db.tomtom end,
				set = function(info, value)
					db.tomtom = value
					if value then
						AR.tomtom = IsAddOnLoaded("TomTom")
					end
				end,
			},
		}
	end
	return options
end

function Module:Info()
	return L["Announce when rares are targeted/dies in Mechagon, Nazjatar, Uldum, and the Vale. Based on one of my other addons, AnnounceRare 2."]
end

function Module:LoadRares()
	return {
		-- mechagon
		[151934] = {
			["name"] = L["Arachnoid Harvester"],
			["announced"] = false
		},
		[150394] = {
			["name"] = L["Armored Vaultbot"],
			["announced"] = false
		},
		[153200] = {
			["name"] = L["Boilburn"],
			["announced"] = false
		},
		[151308] = {
			["name"] = L["Boggac Skullbash"],
			["announced"] = false
		},
		[152001] = {
			["name"] = L["Bonepicker"],
			["announced"] = false
		},
		[154739] = {
			["name"] = L["Caustic Mechaslime"],
			["announced"] = false
		},
		[151569] = {
			["name"] = L["Deepwater Maw"],
			["announced"] = false
		},
		[150342] = {
			["name"] = L["Earthbreaker Gulroc"],
			["announced"] = false
		},
		[154153] = {
			["name"] = L["Enforcer KX-T57"],
			["announced"] = false
		},
		[151202] = {
			["name"] = L["Foul Manifestation"],
			["announced"] = false
		},
		[151884] = {
			["name"] = L["Fungarian Furor"],
			["announced"] = false
		},
		[135497] = {
			["name"] = L["Fungarian Furor"],
			["announced"] = false
		},
		[153228] = {
			["name"] = L["Gear Checker Cogstar"],
			["announced"] = false
		},
		[153205] = {
			["name"] = L["Gemicide"],
			["announced"] = false
		},
		[154701] = {
			["name"] = L["Gorged Gear-Cruncher"],
			["announced"] = false
		},
		[151684] = {
			["name"] = L["Jawbreaker"],
			["announced"] = false
		},
		[152007] = {
			["name"] = L["Killsaw"],
			["announced"] = false
		},
		[151933] = {
			["name"] = L["Malfunctioning Beastbot"],
			["announced"] = false
		},
		[151124] = {
			["name"] = L["Mechagonian Nullifier"],
			["announced"] = false
		},
		[151672] = {
			["name"] = L["Mecharantula"],
			["announced"] = false
		},
		[151627] = {
			["name"] = L["Mr. Fixthis"],
			["announced"] = false
		},
		[151296] = {
			["name"] = L["OOX-Avenger/MG"],
			["announced"] = false
		},
		[153206] = {
			["name"] = L["Ol' Big Tusk"],
			["announced"] = false
		},
		[152764] = {
			["name"] = L["Oxidized Leachbeast"],
			["announced"] = false
		},
		[151702] = {
			["name"] = L["Paol Pondwader"],
			["announced"] = false
		},
		[150575] = {
			["name"] = L["Rumblerocks"],
			["announced"] = false
		},
		[152182] = {
			["name"] = L["Rustfeather"],
			["announced"] = false
		},
		[155583] = {
			["name"] = L["Scrapclaw"],
			["announced"] = false
		},
		[150937] = {
			["name"] = L["Seaspit"],
			["announced"] = false
		},
		[153000] = {
			["name"] = L["Sparkqueen P'Emp"],
			["announced"] = false
		},
		[153226] = {
			["name"] = L["Steel Singer Freza"],
			["announced"] = false
		},
		[155060] = {
			["name"] = L["The Doppel Gang"],
			["announced"] = false
		},
		[152113] = {
			["name"] = L["The Kleptoboss"],
			["announced"] = false
		},
		[151940] = {
			["name"] = L["Uncle T'Rogg"],
			["announced"] = false
		},
		[151625] = {
			["name"] = L["The Scrap King"],
			["announced"] = false
		},
		[151623] = {
			["name"] = L["The Scrap King (Mounted)"],
			["announced"] = false
		},
		[154342] = {
			["name"] = L["Arachnoid Harvester (Alt Time)"],
			["announced"] = false
		},
		[154225] = {
			["name"] = L["The Rusty Prince (Alt Time)"],
			["announced"] = false
		},
		[154968] = {
			["name"] = L["Armored Vaultbot (Alt Time)"],
			["announced"] = false
		},
		[152569] = {
			["name"] = L["Crazed Trogg (Green)"],
			["announced"] = false
		},
		[152570] = {
			["name"] = L["Crazed Trogg (Blue)"],
			["announced"] = false
		},
		[149847] = {
			["name"] = L["Crazed Trogg (Orange)"],
			["announced"] = false
		},

		-- nazjatar
		[152415] = {
			["name"] = L["Alga the Eyeless"],
			["announced"] = false
		},                 
		[152681] = {
			["name"] = L["Prince Typhonus"],
			["announced"] = false
		},                  
		[153658] = {
			["name"] = L["Shiz'narasz the Consumer"],
			["announced"] = false
		},         
		[151719] = {
			["name"] = L["Voice in the Deeps"],
			["announced"] = false
		},               
		[152794] = {
			["name"] = L["Amethyst Spireshell"],
			["announced"] = false
		},              
		[152756] = {
			["name"] = L["Daggertooth Terror"],
			["announced"] = false
		},               
		[144644] = {
			["name"] = L["Mirecrawler"],
			["announced"] = false
		},                      
		[152465] = {
			["name"] = L["Needlespine"],
			["announced"] = false
		},                      
		[152795] = {
			["name"] = L["Sandclaw Stoneshell"],
			["announced"] = false
		},              
		[150191] = {
			["name"] = L["Avarius"],
			["announced"] = false
		},                          
		[152361] = {
			["name"] = L["Banescale the Packfather"],
			["announced"] = false
		},         
		[149653] = {
			["name"] = L["Carnivorous Lasher"],
			["announced"] = false
		},               
		[152323] = {
			["name"] = L["King Gakula"],
			["announced"] = false
		},                      
		[150583] = {
			["name"] = L["Rockweed Shambler"],
			["announced"] = false
		},                
		[151870] = {
			["name"] = L["Sandcastle"],
			["announced"] = false
		},                       
		[153898] = {
			["name"] = L["Tidelord Aquatus"],
			["announced"] = false
		},                 
		[153928] = {
			["name"] = L["Tidelord Dispersius"],
			["announced"] = false
		},              
		[154148] = {
			["name"] = L["Tidemistress Leth'sindra"],
			["announced"] = false
		},         
		[150468] = {
			["name"] = L["Vor'koth"],
			["announced"] = false
		},                         
		[152566] = {
			["name"] = L["Anemonar"],
			["announced"] = false
		},                         
		[152567] = {
			["name"] = L["Kelpwillow"],
			["announced"] = false
		},                       
		[152397] = {
			["name"] = L["Oronu"],
			["announced"] = false
		},                            
		[152568] = {
			["name"] = L["Urduu"],
			["announced"] = false
		},                            
		[152548] = {
			["name"] = L["Scale Matriarch Gratinax"],
			["announced"] = false
		},         
		[152542] = {
			["name"] = L["Scale Matriarch Zodia"],
			["announced"] = false
		},            
		[152545] = {
			["name"] = L["Scale Matriarch Vynara"],
			["announced"] = false
		},           
		[152712] = {
			["name"] = L["Blindlight"],
			["announced"] = false
		},                       
		[152556] = {
			["name"] = L["Chasm-Haunter"],
			["announced"] = false
		},                    
		[152291] = {
			["name"] = L["Deepglider"],
			["announced"] = false
		},                       
		[152555] = {
			["name"] = L["Elderspawn Nalaada"],
			["announced"] = false
		},               
		[152414] = {
			["name"] = L["Elder Unu"],
			["announced"] = false
		},                        
		[152553] = {
			["name"] = L["Garnetscale"],
			["announced"] = false
		},                      
		[152448] = {
			["name"] = L["Iridescent Glimmershell"],
			["announced"] = false
		},          
		[152682] = {
			["name"] = L["Prince Vortran"],
			["announced"] = false
		},                   
		[152552] = {
			["name"] = L["Shassera"],
			["announced"] = false
		},                         
		[152359] = {
			["name"] = L["Siltstalker the Packmother"],
			["announced"] = false
		},       
		[152290] = {
			["name"] = L["Soundless"],
			["announced"] = false
		},                        
		[152360] = {
			["name"] = L["Toxigore the Alpha"],
			["announced"] = false
		},               
		[152416] = {
			["name"] = L["Allseer Oma'kill"],
			["announced"] = false
		},

		-- uldum
		[157170] = {
			["name"] = L["Acolyte Taspu"],
			["announced"] = false
		},
		[158557] = {
			["name"] = L["Actiss the Deceiver"],
			["announced"] = false
		},
		[151883] = {
			["name"] = L["Anaua"],
			["announced"] = false
		},
		[155703] = {
			["name"] = L["Anq'uri the Titanic"],
			["announced"] = false
		},
		[157472] = {
			["name"] = L["Aphrom the Guise of Madness"],
			["announced"] = false
		},
		[154578] = {
			["name"] = L["Aqir Flayer"],
			["announced"] = false
		},
		[154576] = {
			["name"] = L["Aqir Titanus"],
			["announced"] = false
		},
		[162172] = {
			["name"] = L["Aqir Warcaster"],
			["announced"] = false
		},
		[162370] = {
			["name"] = L["Armagedillo"],
			["announced"] = false
		},
		[152757] = {
			["name"] = L["Atekhramun"],
			["announced"] = false
		},
		[162171] = {
			["name"] = L["Captain Dunewalker"],
			["announced"] = false
		},
		[162147] = {
			["name"] = L["Corpse Eater"],
			["announced"] = false
		},
		[158594] = {
			["name"] = L["Doomsayer Vathiris"],
			["announced"] = false
		},
		[158491] = {
			["name"] = L["Falconer Amenophis"],
			["announced"] = false
		},
		[157120] = {
			["name"] = L["Fangtaker Orsa"],
			["announced"] = false
		},
		[158633] = {
			["name"] = L["Gaze of N'Zoth"],
			["announced"] = false
		},
		[158597] = {
			["name"] = L["High Executor Yothrim"],
			["announced"] = false
		},
		[158528] = {
			["name"] = L["High Guard Reshef"],
			["announced"] = false
		},
		[162163] = {
			["name"] = L["High Priest Ytaessis"],
			["announced"] = false
		},
		[151995] = {
			["name"] = L["Hik-ten the Taskmaster"],
			["announced"] = false
		},
		[160623] = {
			["name"] = L["Hungering Miasma"],
			["announced"] = false
		},
		[155531] = {
			["name"] = L["Infested Wastewander Captain"],
			["announced"] = false
		},
		[157134] = {
			["name"] = L["Ishak of the Four Winds"],
			["announced"] = false
		},
		[156655] = {
			["name"] = L["Korzaran the Slaughterer"],
			["announced"] = false
		},
		[154604] = {
			["name"] = L["Lord Aj'qirai"],
			["announced"] = false
		},
		[156078] = {
			["name"] = L["Magus Rehleth"],
			["announced"] = false
		},
		[157157] = {
			["name"] = L["Muminah the Incandescent"],
			["announced"] = false
		},
		[152677] = {
			["name"] = L["Nebet the Ascended"],
			["announced"] = false
		},
		[162196] = {
			["name"] = L["Obsidian Annihilator"],
			["announced"] = false
		},
		[162142] = {
			["name"] = L["Qho"],
			["announced"] = false
		},
		[157470] = {
			["name"] = L["R'aas the Anima Devourer"],
			["announced"] = false
		},
		[156299] = {
			["name"] = L["R'khuzj The Unfathomable"],
			["announced"] = false
		},
		[162173] = {
			["name"] = L["R'krox the Runt"],
			["announced"] = false
		},
		[157146] = {
			["name"] = L["Rotfeaster"],
			["announced"] = false
		},
		[152040] = {
			["name"] = L["Scoutmaster Moswen"],
			["announced"] = false
		},
		[151948] = {
			["name"] = L["Senbu the Pridefather"],
			["announced"] = false
		},
		[161033] = {
			["name"] = L["Shadowmaw"],
			["announced"] = false
		},
		[156654] = {
			["name"] = L["Shol'thoss the Doomspeaker"],
			["announced"] = false
		},
		[160532] = {
			["name"] = L["Shoth the Darkened"],
			["announced"] = false
		},
		[157476] = {
			["name"] = L["Shugshul the Flesh Gorger"],
			["announced"] = false
		},
		[162140] = {
			["name"] = L["Skikx'traz"],
			["announced"] = false
		},
		[162372] = {
			["name"] = L["Spirit of Cyrus the Black"],
			["announced"] = false
		},
		[151878] = {
			["name"] = L["Sun King Nahkotep"],
			["announced"] = false
		},
		[151897] = {
			["name"] = L["Sun Priestess Nubitt"],
			["announced"] = false
		},
		[151609] = {
			["name"] = L["Sun Prophet Epaphos"],
			["announced"] = false
		},
		[152657] = {
			["name"] = L["Tat the Bonechewer"],
			["announced"] = false
		},
		[158636] = {
			["name"] = L["The Grand Executor"],
			["announced"] = false
		},
		[162170] = {
			["name"] = L["Warcaster Xeshro"],
			["announced"] = false
		},
		[151852] = {
			["name"] = L["Watcher Rehu"],
			["announced"] = false
		},
		[157164] = {
			["name"] = L["Zealot Tekem"],
			["announced"] = false
		},
		[162141] = {
			["name"] = L["Zuythiz"],
			["announced"] = false
		},
		[157167] = {
			["name"] = L["Champion Sen-mat"],
			["announced"] = false
		},
		[152431] = {
			["name"] = L["Kaneb-ti"],
			["announced"] = false
		},
		[152788] = {
			["name"] = L["Uat-ka the Sun's Wrath"],
			["announced"] = false
		},
		[157188] = {
			["name"] = L["The Tomb Widow"],
			["announced"] = false
		},
		[162352] = {
			["name"] = L["Spirit of Dark Ritualist Zakahn"],
			["announced"] = false
		},
		[158531] = {
			["name"] = L["Corrupted Neferset Guard"],
			["announced"] = false
		},
		[157593] = {
			["name"] = L["Amalgamation of Flesh"],
			["announced"] = false
		},
		[158595] = {
			["name"] = L["Thoughtstealer Vos"],
			["announced"] = false
		},
		[157473] = {
			["name"] = L["Yiphrim the Will Ravager"],
			["announced"] = false
		},
		[157469] = {
			["name"] = L["Zoth'rum the Intellect Pillager"],
			["announced"] = false
		},
		[157390] = {
			["name"] = L["R'oyolok the Reality Eater"],
			["announced"] = false
		},
		[162765] = {
			["name"] = L["Friendly Alpaca"],
			["announced"] = false
		},
		
		-- vale of the eternal blossom
		[154087] = {
			["name"] = L["Zror'um the Infinite"],
			["announced"] = false
		},
		[154106] = {
			["name"] = L["Quid"],
			["announced"] = false
		},
		[154332] = {
			["name"] = L["Voidtender Malketh"],
			["announced"] = false
		},
		[154394] = {
			["name"] = L["Veskan the Fallen"],
			["announced"] = false
		},
		[154447] = {
			["name"] = L["Brother Meller"],
			["announced"] = false
		},
		[154467] = {
			["name"] = L["Chief Mek-mek"],
			["announced"] = false
		},
		[154490] = {
			["name"] = L["Rijz'x the Devourer"],
			["announced"] = false
		},
		[154495] = {
			["name"] = L["Will of N'Zoth"],
			["announced"] = false
		},
		[154559] = {
			["name"] = L["Deeplord Zrihj"],
			["announced"] = false
		},
		[154600] = {
			["name"] = L["Teng the Awakened"],
			["announced"] = false
		},
		[155958] = {
			["name"] = L["Tashara"],
			["announced"] = false
		},
		[156083] = {
			["name"] = L["Sanguifang"],
			["announced"] = false
		},
		[157153] = {
			["name"] = L["Ha-Li"],
			["announced"] = false
		},
		[157160] = {
			["name"] = L["Houndlord Ren"],
			["announced"] = false
		},
		[157162] = {
			["name"] = L["Rei Lun"],
			["announced"] = false
		},
		[157171] = {
			["name"] = L["Heixi the Stonelord"],
			["announced"] = false
		},
		[157176] = {
			["name"] = L["The Forgotten"],
			["announced"] = false
		},
		[157183] = {
			["name"] = L["Coagulated Anima"],
			["announced"] = false
		},
		[157266] = {
			["name"] = L["Kilxl the Gaping Maw"],
			["announced"] = false
		},
		[157267] = {
			["name"] = L["Escaped Mutation"],
			["announced"] = false
		},
		[157279] = {
			["name"] = L["Stormhowl"],
			["announced"] = false
		},
		[157287] = {
			["name"] = L["Dokani Obliterator"],
			["announced"] = false
		},
		[157290] = {
			["name"] = L["Jade Watcher"],
			["announced"] = false
		},
		[157291] = {
			["name"] = L["Spymaster Hul'ach"],
			["announced"] = false
		},
		[157443] = {
			["name"] = L["Xiln the Mountain"],
			["announced"] = false
		},
		[157466] = {
			["name"] = L["Anh-De the Loyal"],
			["announced"] = false
		},
		[157468] = {
			["name"] = L["Tisiphon"],
			["announced"] = false
		},
		[160810] = {
			["name"] = L["Harbinger Il'koxik"],
			["announced"] = false
		},
		[160825] = {
			["name"] = L["Amber-Shaper Esh'ri"],
			["announced"] = false
		},
		[160826] = {
			["name"] = L["Hive-Guard Naz'ruzek"],
			["announced"] = false
		},
		[160867] = {
			["name"] = L["Kzit'kovok"],
			["announced"] = false
		},
		[160868] = {
			["name"] = L["Harrier Nir'verash"],
			["announced"] = false
		},
		[160872] = {
			["name"] = L["Destroyer Krox'tazar"],
			["announced"] = false
		},
		[160874] = {
			["name"] = L["Drone Keeper Ak'thet"],
			["announced"] = false
		},
		[160876] = {
			["name"] = L["Enraged Amber Elemental"],
			["announced"] = false
		},
		[160878] = {
			["name"] = L["Buh'gzaki the Blasphemous"],
			["announced"] = false
		},
		[160893] = {
			["name"] = L["Captain Vor'lek"],
			["announced"] = false
		},
		[160920] = {
			["name"] = L["Kal'tik the Blight"],
			["announced"] = false
		},
		[160922] = {
			["name"] = L["Needler Zhesalla"],
			["announced"] = false
		},
		[160930] = {
			["name"] = L["Infused Amber Ooze"],
			["announced"] = false
		},
		[160968] = {
			["name"] = L["Jade Colossus"],
			["announced"] = false
		},
		[159087] = {
			["name"] = L["Corrupted Bonestripper"],
			["announced"] = false
		},
		[160906] = {
			["name"] = L["Skiver"],
			["announced"] = false
		},
	}
end