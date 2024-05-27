--[[
	Lear's Custom Merchant Restock Script:
		version 1.00 (for TES3MP 0.8 & 0.8.1)

	DESCRIPTION:
		This simple script will ensure your designated merchants always have their gold restocked.
		Simply add the refId of the merchant you want to always restock gold into the `restockingGoldMerchants` table below.

	INSTALLATION:
		1) Place this file as `customMerchantRestock.lua` inside your TES3MP servers `server\scripts\custom` folder.
		2) Open your `customScripts.lua` file in a text editor.
				(It can be found in `server\scripts` folder.)
		3) Add the below line to your `customScripts.lua` file:
				require("custom.customMerchantRestock")
		4) BE SURE THERE IS NO `--` SYMBOLS TO THE LEFT OF IT, ELSE IT WILL NOT WORK.
		5) Save `customScripts.lua` and restart your server.


	VERSION HISTORY:
		1.00 (5/30/2022)		- Initial public release.

		05/16/2023          - modified by skoomabreath for item restocking
		07/16/2023          - modified by magicaldave (S3ctor) & NuclearWaste to include all restocking merchants' inventories https://github.com/magicaldave/motherJungle/releases/tag/merchantIndexGrabber
--]]


customMerchantRestock = {}

-- Add the refId of merchants you want to restock their gold every time the "Barter" option is selected below:
local restockingGoldMerchants = {
	"mudcrab_unique",
	"scamp_creeper"
}
-- Add the refId of merchants that will restock items specified in the itemsToRestock table
local itemRestockingMerchants = {
	"manicky",
	"elegal",
	"arangaer",
	"anruin",
	"danso indules",
	"vedran balen",
	"dandera selaro",
	"orero omothan",
	"shulki ashunbabi",
	"ashuma-nud matluberib",
	"hannabi zabynatus",
	"lanabi",
	"sinnammu mirpal",
	"boderi farano",
	"daynes redothril",
	"gildan",
	"ergnir",
	"tanar llervi",
	"heem_la",
	"anarenen",
	"guls llervu",
	"llether vari",
	"lassour zenammu",
	"mivanu retheran",
	"folvys andalor",
	"ureso drath",
	"danoso andrano",
	"lloros sarano",
	"allding",
	"lirielle stoine",
	"galtis guvron",
	"tuveso beleth",
	"gladroon",
	"marasa aren",
	"banor seran",
	"thanelen velas",
	"madrale thirith",
	"dorisa darvel",
	"dralasa nithryon",
	"dulnea ralaal",
	"wayn",
	"ajira",
	"galbedir",
	"bolnor andrani",
	"nileno dorvayn",
	"hickim",
	"benunius agrudilius",
	"meldor",
	"milie hastien",
	"gilyan sedas",
	"nalcarya of white haven",
	"ra'virr",
	"habasi",
	"chirranirr",
	"sottilde",
	"bacola closcius",
	"telis salvani",
	"ilen faveran",
	"llathyno hlaalu",
	"llarara omayn",
	"dralval andrano",
	"thorek",
	"arnand liric",
	"dulian",
	"yambagorn gor-shulor",
	"cocistian quaspus",
	"foves arenim",
	"ernand thierry",
	"folms mirel",
	"hodlismod",
	"shenk",
	"hreirek the lean",
	"hjotra the peacock",
	"kjeld",
	"sirollus saccus",
	"kaye",
	"sauleius cullian",
	"agning",
	"massarapal",
	"manirai",
	"arenara",
	"teril savani",
	"faras thirano",
	"galore salvi",
	"dronos llervu",
	"hinald",
	"selvura andrano",
	"anas ulven",
	"hetman abelmawia",
	"chaplain ogrul",
	"ulumpha gra-sharob",
	"mug gro-dulob",
	"fenas madach",
	"zanmulk sammalamus",
	"mehra drora",
	"dalam gavyn",
	"trasteve",
	"perien aurelie",
	"llemisa marys",
	"felayn andral",
	"tivam sadri",
	"uvele berendas",
	"lliros tures",
	"gilyne omoren",
	"manse andus",
	"alds baro",
	"sedris omalen",
	"salen ravel",
	"hakar the candle",
	"saetring",
	"erla",
	"somutis vunnis",
	"peragon",
	"crulius pontanian",
	"ygfa",
	"shadbak gra-burbug",
	"drelasa ramothran",
	"mebestian ence",
	"uulernil",
	"lliryn fendyn",
	"anis seloth",
	"muriel sette",
	"big helende",
	"both gro-durug",
	"fara",
	"ery",
	"dunsalipal dun-ahhe",
	"meder nulen",
	"minasi bavani",
	"pierlette rostorard",
	"miraso seran",
	"galar rothan",
	"thervul serethi",
	"hrundi",
	"aunius autrus",
	"scelian plebo",
	"dabienne mornardl",
	"tusamircil",
	"arrille",
	"garothmuk gro-muzgub",
	"ravoso aryon",
	"avon oran",
	"ashumanu eraishah",
	"aryne telnim",
	"bildren areleth",
	"maren uvaren",
	"drarayne girith",
	"brarayni sarys",
	"irna maryon",
	"barusi venim",
	"felara andrethi",
	"fadase selvayn",
	"galen berer",
	"llorayna sethan",
	"gils drelas",
	"jolda",
	"daynali dren",
	"radras",
	"thaeril",
	"hlendrisa seleth",
	"milar maryon",
	"alenus vendu",
	"andil",
	"kurapli",
	"nibani maesa",
	"alusaron",
	"andilu drothan",
	"rogdul gro-bularz",
	"aurane frernis",
	"huleeya",
	"raril giral",
	"sovali uvayn",
	"gadela andus",
	"idonea munia",
	"lorbumol gro-aglakh",
	"craeita jullalian",
	"janand maulinie",
	"dileno lloran",
	"llandris thirandus",
	"ganalyn saram",
	"elo arethan",
	"telvon llethan",
	"j'rasha",
	"jeanne",
	"miun_gei",
	"rarvela teran",
	"brathus dals",
	"traldrisa tervayn",
	"gilan daynes",
	"belos falos",
	"ralen tilvur",
	"savard",
	"relms gilvilo",
	"balen andrano",
	"vaval selas",
	"garas seloth",
	"galuro belan",
	"audenian valius",
	"sorosi radobar",
	"manara othan",
	"burcanius varo",
	"eldrilu dalen",
	"ababael timsar-dadisun",
	"ashur-dan",
	"sonummu zabamat",
	"nerile andaren",
	"galsa andrano",
	"catia sosia",
	"elbert nermarc",
	"bols indalen",
	"daron",
	"mehra helas",
	"ra'tesh",
	"alcedonia amnis",
    "aradraen",
}
-- Item restocking for containers that are not the npc's inventory is not implemented
-- items will only show up in the barter window for sale if its an item type the merchant deals in?
-- they will also equip gear you put in their inventory if its better than what they are currently wearing?
-- Add the uniqueIndex of the merchant and table of items you want to restock in the format shown below
local itemsToRestock = {
    ["437377-0"] = { -- manicky
        {
            refId = "bonemold bolt",
            count = 25,
        },
        {
            refId = "bonemold arrow",
            count = 50,
        },
        {
            refId = "steel crossbow",
            count = 1,
        },
        {
            refId = "bonemold long bow",
            count = 1,
        },
        {
            refId = "steel longbow",
            count = 1,
        },
        {
            refId = "steel battle axe",
            count = 1,
        },
        {
            refId = "steel axe",
            count = 1,
        },
        {
            refId = "steel club",
            count = 1,
        },
        {
            refId = "steel broadsword",
            count = 1,
        },
        {
            refId = "steel katana",
            count = 1,
        },
        {
            refId = "steel dagger",
            count = 1,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
    },
    ["437379-0"] = { -- elegal
        {
            refId = "steel arrow",
            count = 30,
        },
        {
            refId = "silver arrow",
            count = 20,
        },
        {
            refId = "iron arrow",
            count = 40,
        },
        {
            refId = "silver dart",
            count = 15,
        },
        {
            refId = "silver throwing star",
            count = 15,
        },
        {
            refId = "iron throwing knife",
            count = 25,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["437378-0"] = { -- arangaer
        {
            refId = "p_restore_fatigue_s",
            count = 2,
        },
        {
            refId = "p_restore_health_s",
            count = 2,
        },
        {
            refId = "p_restore_health_c",
            count = 4,
        },
        {
            refId = "p_restore_fatigue_c",
            count = 4,
        },
        {
            refId = "p_cure_common_s",
            count = 2,
        },
        {
            refId = "p_cure_blight_s",
            count = 1,
        },
        {
            refId = "p_cure_poison_s",
            count = 1,
        },
    },
    ["437376-0"] = { -- anruin
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
    },
    ["270565-0"] = { -- danso indules
        {
            refId = "p_disease_resistance_s",
            count = 2,
        },
        {
            refId = "p_cure_poison_s",
            count = 2,
        },
        {
            refId = "p_restore_fatigue_b",
            count = 2,
        },
        {
            refId = "p_restore_health_c",
            count = 5,
        },
        {
            refId = "p_restore_health_b",
            count = 5,
        },
        {
            refId = "p_levitation_b",
            count = 1,
        },
    },
    ["409110-0"] = { -- vedran balen
        {
            refId = "pick_journeyman_01",
            count = 4,
        },
        {
            refId = "pick_apprentice_01",
            count = 2,
        },
        {
            refId = "probe_apprentice_01",
            count = 1,
        },
        {
            refId = "probe_journeyman_01",
            count = 3,
        },
    },
    ["28777-0"] = { -- dandera selaro
        {
            refId = "random_iron_weapon",
            count = 4,
        },
        {
            refId = "random_silver_weapon",
            count = 2,
        },
        {
            refId = "random_steel_weapon",
            count = 4,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["287922-0"] = { -- orero omothan
        {
            refId = "hammer_repair",
            count = 10,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
    },
    ["11927-0"] = { -- shulki ashunbabi
        {
            refId = "iron bolt",
            count = 25,
        },
        {
            refId = "iron arrow",
            count = 50,
        },
        {
            refId = "chitin throwing star",
            count = 30,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["11925-0"] = { -- ashuma-nud matluberib
        {
            refId = "steel arrow",
            count = 50,
        },
        {
            refId = "chitin arrow",
            count = 100,
        },
        {
            refId = "random_steel_weapon",
            count = 2,
        },
        {
            refId = "random_iron_weapon",
            count = 3,
        },
        {
            refId = "repair_journeyman_01",
            count = 8,
        },
        {
            refId = "repair_prongs",
            count = 15,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
    },
    ["11926-0"] = { -- hannabi zabynatus
        {
            refId = "hammer_repair",
            count = 10,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
    },
    ["131082-0"] = { -- lanabi
        {
            refId = "chitin arrow",
            count = 25,
        },
        {
            refId = "chitin throwing star",
            count = 15,
        },
        {
            refId = "random_armor_chitin",
            count = 3,
        },
        {
            refId = "random ashlander weapon",
            count = 5,
        },
        {
            refId = "hammer_repair",
            count = 2,
        },
    },
    ["131035-0"] = { -- sinnammu mirpal
        {
            refId = "p_restore_fatigue_c",
            count = 2,
        },
        {
            refId = "p_restore_health_s",
            count = 1,
        },
        {
            refId = "p_cure_common_s",
            count = 1,
        },
        {
            refId = "p_cure_poison_s",
            count = 1,
        },
    },
    ["78887-0"] = { -- boderi farano
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 2,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 5,
        },
    },
    ["13944-0"] = { -- daynes redothril
        {
            refId = "torch",
            count = 3,
        },
    },
    ["10595-0"] = { -- gildan
        {
            refId = "Gold_001",
            count = 100,
        },
    },
    ["9220-0"] = { -- ergnir
        {
            refId = "iron bolt",
            count = 50,
        },
        {
            refId = "iron arrow",
            count = 100,
        },
        {
            refId = "steel arrow",
            count = 50,
        },
    },
    ["8210-0"] = { -- tanar llervi
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_divineintervention",
            count = 2,
        },
        {
            refId = "sc_corruptarcanix",
            count = 2,
        },
        {
            refId = "sc_elevramssty",
            count = 5,
        },
        {
            refId = "sc_firstbarrier",
            count = 6,
        },
        {
            refId = "sc_secondbarrier",
            count = 5,
        },
        {
            refId = "sc_thirdbarrier",
            count = 1,
        },
        {
            refId = "sc_healing",
            count = 5,
        },
        {
            refId = "sc_mark",
            count = 1,
        },
        {
            refId = "sc_leaguestep",
            count = 1,
        },
        {
            refId = "sc_drathiswinterguest",
            count = 2,
        },
        {
            refId = "sc_taldamsscorcher",
            count = 2,
        },
        {
            refId = "sc_reynosbeastfinder",
            count = 5,
        },
        {
            refId = "sc_reynosfins",
            count = 1,
        },
        {
            refId = "random_scroll_all",
            count = 6,
        },
    },
    ["8208-0"] = { -- heem_la
        {
            refId = "random_scroll_all",
            count = 3,
        },
    },
    ["8207-0"] = { -- anarenen
        {
            refId = "ingred_vampire_dust_01",
            count = 1,
        },
        {
            refId = "ingred_bloat_01",
            count = 5,
        },
        {
            refId = "ingred_bonemeal_01",
            count = 5,
        },
        {
            refId = "ingred_comberry_01",
            count = 10,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 10,
        },
        {
            refId = "ingred_diamond_01",
            count = 2,
        },
        {
            refId = "ingred_fire_salts_01",
            count = 5,
        },
        {
            refId = "ingred_heather_01",
            count = 10,
        },
    },
    ["132175-0"] = { -- guls llervu
        {
            refId = "ingred_scuttle_01",
            count = 5,
        },
        {
            refId = "ingred_scathecraw_01",
            count = 5,
        },
        {
            refId = "ingred_saltrice_01",
            count = 5,
        },
        {
            refId = "ingred_resin_01",
            count = 5,
        },
        {
            refId = "ingred_kagouti_hide_01",
            count = 5,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 5,
        },
    },
    ["31900-0"] = { -- llether vari
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_reddeath",
            count = 1,
        },
        {
            refId = "sc_reddespair",
            count = 1,
        },
        {
            refId = "sc_redfate",
            count = 1,
        },
        {
            refId = "sc_redmind",
            count = 1,
        },
        {
            refId = "sc_redscorn",
            count = 1,
        },
        {
            refId = "sc_redsloth",
            count = 1,
        },
        {
            refId = "sc_redweakness",
            count = 1,
        },
        {
            refId = "sc_elementalburstfire",
            count = 2,
        },
        {
            refId = "sc_elementalburstfrost",
            count = 2,
        },
        {
            refId = "sc_elementalburstshock",
            count = 1,
        },
        {
            refId = "sc_gamblersprayer",
            count = 5,
        },
        {
            refId = "sc_galmsesseal",
            count = 5,
        },
        {
            refId = "sc_lesserdomination",
            count = 1,
        },
        {
            refId = "sc_bloodthief",
            count = 2,
        },
        {
            refId = "sc_argentglow",
            count = 2,
        },
        {
            refId = "sc_daynarsairybubble",
            count = 2,
        },
        {
            refId = "sc_nerusislockjaw",
            count = 1,
        },
        {
            refId = "sc_telvinscourage",
            count = 5,
        },
        {
            refId = "sc_tevralshawkshaw",
            count = 5,
        },
        {
            refId = "sc_ulmjuicedasfeather",
            count = 2,
        },
        {
            refId = "random_scroll_all",
            count = 6,
        },
    },
    ["311528-0"] = { -- lassour zenammu
        {
            refId = "iron spider dagger",
            count = 1,
        },
        {
            refId = "steel spider blade",
            count = 2,
        },
        {
            refId = "pick_apprentice_01",
            count = 15,
        },
        {
            refId = "pick_master",
            count = 4,
        },
        {
            refId = "pick_journeyman_01",
            count = 8,
        },
        {
            refId = "probe_apprentice_01",
            count = 15,
        },
        {
            refId = "probe_journeyman_01",
            count = 7,
        },
        {
            refId = "probe_master",
            count = 3,
        },
    },
    ["385399-0"] = { -- mivanu retheran
        {
            refId = "random_book_dunmer",
            count = 2,
        },
    },
    ["259847-0"] = { -- folvys andalor
        {
            refId = "ingred_scuttle_01",
            count = 10,
        },
        {
            refId = "ingred_scrib_jerky_01",
            count = 10,
        },
        {
            refId = "ingred_scrib_jelly_01",
            count = 10,
        },
        {
            refId = "ingred_scamp_skin_01",
            count = 10,
        },
        {
            refId = "ingred_rat_meat_01",
            count = 10,
        },
        {
            refId = "ingred_guar_hide_01",
            count = 10,
        },
        {
            refId = "ingred_emerald_01",
            count = 3,
        },
        {
            refId = "ingred_corprus_weepings_01",
            count = 5,
        },
        {
            refId = "ingred_ash_salts_01",
            count = 5,
        },
    },
    ["259845-0"] = { -- ureso drath
        {
            refId = "sc_daerirsmiracle",
            count = 5,
        },
        {
            refId = "sc_daydenespanacea",
            count = 5,
        },
        {
            refId = "sc_almsiviintervention",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 1,
        },
        {
            refId = "sc_gamblersprayer",
            count = 2,
        },
        {
            refId = "sc_dawnsprite",
            count = 2,
        },
        {
            refId = "sc_heartwise",
            count = 2,
        },
        {
            refId = "sc_insight",
            count = 2,
        },
        {
            refId = "sc_argentglow",
            count = 1,
        },
        {
            refId = "sc_bloodfire",
            count = 2,
        },
        {
            refId = "sc_mark",
            count = 1,
        },
    },
    ["259846-0"] = { -- danoso andrano
        {
            refId = "ingred_bc_bungler's_bane",
            count = 10,
        },
        {
            refId = "ingred_bc_hypha_facia",
            count = 10,
        },
        {
            refId = "ingred_bc_coda_flower",
            count = 10,
        },
        {
            refId = "ingred_bc_spore_pod",
            count = 10,
        },
        {
            refId = "ingred_wickwheat_01",
            count = 10,
        },
        {
            refId = "ingred_roobrush_01",
            count = 10,
        },
        {
            refId = "ingred_pearl_01",
            count = 3,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 10,
        },
        {
            refId = "ingred_ectoplasm_01",
            count = 5,
        },
        {
            refId = "ingred_dreugh_wax_01",
            count = 5,
        },
        {
            refId = "apparatus_j_mortar_01",
            count = 1,
        },
        {
            refId = "apparatus_j_retort_01",
            count = 1,
        },
        {
            refId = "apparatus_j_alembic_01",
            count = 1,
        },
    },
    ["259849-0"] = { -- lloros sarano
        {
            refId = "ingred_ghoul_heart_01",
            count = 2,
        },
        {
            refId = "ingred_shalk_resin_01",
            count = 5,
        },
        {
            refId = "ingred_red_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_gravedust_01",
            count = 10,
        },
        {
            refId = "p_restore_health_c",
            count = 5,
        },
        {
            refId = "p_restore_health_b",
            count = 5,
        },
        {
            refId = "p_restore_fatigue_c",
            count = 3,
        },
    },
    ["9443-0"] = { -- allding
        {
            refId = "iron arrow",
            count = 75,
        },
        {
            refId = "iron throwing knife",
            count = 20,
        },
        {
            refId = "iron war axe",
            count = 1,
        },
        {
            refId = "iron spear",
            count = 1,
        },
        {
            refId = "iron warhammer",
            count = 1,
        },
        {
            refId = "iron longsword",
            count = 1,
        },
        {
            refId = "iron shortsword",
            count = 1,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["9441-0"] = { -- lirielle stoine
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "pick_apprentice_01",
            count = 10,
        },
        {
            refId = "probe_apprentice_01",
            count = 10,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
    },
    ["9445-0"] = { -- galtis guvron
        {
            refId = "torch",
            count = 3,
        },
        {
            refId = "misc_6th_ash_statue_01",
            count = 3,
        },
    },
    ["132351-0"] = { -- tuveso beleth
        {
            refId = "repair_master_01",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
    },
    ["195061-0"] = { -- gladroon
        {
            refId = "repair_master_01",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["67624-0"] = { -- marasa aren
        {
            refId = "iron arrow",
            count = 50,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["67622-0"] = { -- banor seran
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
    },
    ["366330-0"] = { -- thanelen velas
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
    },
    ["67625-0"] = { -- madrale thirith
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "pick_apprentice_01",
            count = 10,
        },
        {
            refId = "probe_apprentice_01",
            count = 10,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
    },
    ["41845-0"] = { -- dorisa darvel
        {
            refId = "bk_ChroniclesNchuleft",
            count = 1,
        },
    },
    ["42308-0"] = { -- dralasa nithryon
        {
            refId = "hammer_repair",
            count = 2,
        },
    },
    ["67599-0"] = { -- dulnea ralaal
        {
            refId = "random_food",
            count = 12,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
    },
    ["67611-0"] = { -- wayn
        {
            refId = "silver arrow",
            count = 100,
        },
        {
            refId = "steel arrow",
            count = 100,
        },
        {
            refId = "steel throwing knife",
            count = 30,
        },
        {
            refId = "steel throwing star",
            count = 20,
        },
        {
            refId = "iron spider dagger",
            count = 1,
        },
        {
            refId = "steel spider blade",
            count = 1,
        },
        {
            refId = "imperial netch blade",
            count = 1,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 8,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
    },
    ["67618-0"] = { -- ajira
        {
            refId = "ingred_willow_anther_01",
            count = 5,
        },
        {
            refId = "ingred_scales_01",
            count = 5,
        },
        {
            refId = "food_kwama_egg_01",
            count = 5,
        },
        {
            refId = "ingred_kwama_cuttle_01",
            count = 5,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 5,
        },
        {
            refId = "ingred_heather_01",
            count = 5,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 5,
        },
        {
            refId = "ingred_comberry_01",
            count = 5,
        },
        {
            refId = "ingred_black_anther_01",
            count = 5,
        },
    },
    ["67621-0"] = { -- galbedir
        {
            refId = "sc_taldamsscorcher",
            count = 2,
        },
        {
            refId = "sc_vitality",
            count = 2,
        },
        {
            refId = "sc_vigor",
            count = 2,
        },
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_divineintervention",
            count = 2,
        },
        {
            refId = "sc_almsiviintervention",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_tinurshoptoad",
            count = 5,
        },
        {
            refId = "sc_drathiswinterguest",
            count = 2,
        },
        {
            refId = "sc_celerity",
            count = 2,
        },
        {
            refId = "sc_dedresmasterfuleye",
            count = 2,
        },
        {
            refId = "sc_salensvivication",
            count = 2,
        },
        {
            refId = "sc_savagemight",
            count = 2,
        },
        {
            refId = "sc_secondbarrier",
            count = 2,
        },
        {
            refId = "sc_firstbarrier",
            count = 2,
        },
        {
            refId = "sc_healing",
            count = 5,
        },
    },
    ["67639-0"] = { -- bolnor andrani
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "pick_apprentice_01",
            count = 10,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
        {
            refId = "probe_apprentice_01",
            count = 10,
        },
    },
    ["67633-0"] = { -- nileno dorvayn
        {
            refId = "pick_master",
            count = 3,
        },
        {
            refId = "probe_master",
            count = 3,
        },
    },
    ["42190-0"] = { -- hickim
        {
            refId = "pick_apprentice_01",
            count = 6,
        },
        {
            refId = "pick_journeyman_01",
            count = 3,
        },
        {
            refId = "probe_journeyman_01",
            count = 3,
        },
        {
            refId = "probe_apprentice_01",
            count = 6,
        },
    },
    ["42189-0"] = { -- benunius agrudilius
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 4,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 4,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
    },
    ["41720-0"] = { -- meldor
        {
            refId = "repair_journeyman_01",
            count = 20,
        },
    },
    ["67645-0"] = { -- milie hastien
        {
            refId = "extravagant_belt_02",
            count = 1,
        },
        {
            refId = "extravagant_belt_01",
            count = 1,
        },
        {
            refId = "extravagant_shirt_01",
            count = 1,
        },
        {
            refId = "extravagant_shirt_01_h",
            count = 1,
        },
        {
            refId = "extravagant_shirt_02",
            count = 1,
        },
        {
            refId = "extravagant_pants_01",
            count = 1,
        },
        {
            refId = "extravagant_pants_02",
            count = 1,
        },
        {
            refId = "random_expensive_de_mclothes_02",
            count = 5,
        },
        {
            refId = "random_expensive_de_fclothes_02",
            count = 5,
        },
    },
    ["67643-0"] = { -- gilyan sedas
        {
            refId = "pick_journeyman_01",
            count = 1,
        },
        {
            refId = "probe_journeyman_01",
            count = 1,
        },
    },
    ["132148-0"] = { -- nalcarya of white haven
        {
            refId = "ingred_vampire_dust_01",
            count = 1,
        },
        {
            refId = "ingred_trama_root_01",
            count = 10,
        },
        {
            refId = "ingred_sload_soap_01",
            count = 10,
        },
        {
            refId = "ingred_scrap_metal_01",
            count = 10,
        },
        {
            refId = "ingred_scales_01",
            count = 10,
        },
        {
            refId = "ingred_ruby_01",
            count = 3,
        },
        {
            refId = "ingred_racer_plumes_01",
            count = 10,
        },
        {
            refId = "ingred_pearl_01",
            count = 3,
        },
        {
            refId = "ingred_muck_01",
            count = 10,
        },
        {
            refId = "ingred_kwama_cuttle_01",
            count = 10,
        },
        {
            refId = "ingred_fire_salts_01",
            count = 5,
        },
        {
            refId = "ingred_frost_salts_01",
            count = 5,
        },
        {
            refId = "ingred_diamond_01",
            count = 1,
        },
        {
            refId = "ingred_daedras_heart_01",
            count = 1,
        },
        {
            refId = "ingred_daedra_skin_01",
            count = 1,
        },
        {
            refId = "ingred_bloat_01",
            count = 10,
        },
        {
            refId = "ingred_black_anther_01",
            count = 10,
        },
        {
            refId = "ingred_alit_hide_01",
            count = 10,
        },
        {
            refId = "ingred_void_salts_01",
            count = 7,
        },
        {
            refId = "apparatus_m_alembic_01",
            count = 1,
        },
        {
            refId = "apparatus_m_calcinator_01",
            count = 1,
        },
        {
            refId = "apparatus_m_mortar_01",
            count = 1,
        },
        {
            refId = "apparatus_m_retort_01",
            count = 1,
        },
    },
    ["132059-0"] = { -- ra'virr
        {
            refId = "devil spear",
            count = 1,
        },
        {
            refId = "fiend katana",
            count = 1,
        },
        {
            refId = "fiend tanto",
            count = 1,
        },
        {
            refId = "demon tanto",
            count = 1,
        },
        {
            refId = "misc_de_bowl_orange_green_01",
            count = 2,
        },
    },
    ["367742-0"] = { -- habasi
        {
            refId = "pick_master",
            count = 5,
        },
        {
            refId = "pick_journeyman_01",
            count = 10,
        },
        {
            refId = "pick_apprentice_01",
            count = 15,
        },
        {
            refId = "probe_master",
            count = 5,
        },
        {
            refId = "probe_journeyman_01",
            count = 10,
        },
        {
            refId = "probe_apprentice_01",
            count = 15,
        },
    },
    ["367738-0"] = { -- chirranirr
        {
            refId = "pick_apprentice_01",
            count = 4,
        },
        {
            refId = "pick_journeyman_01",
            count = 2,
        },
        {
            refId = "probe_apprentice_01",
            count = 3,
        },
        {
            refId = "probe_journeyman_01",
            count = 1,
        },
    },
    ["367740-0"] = { -- sottilde
        {
            refId = "iron arrow",
            count = 50,
        },
        {
            refId = "iron throwing knife",
            count = 20,
        },
        {
            refId = "chitin shortsword",
            count = 1,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["367735-0"] = { -- bacola closcius
        {
            refId = "random_food",
            count = 12,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 10,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 10,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 5,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 5,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 10,
        },
        {
            refId = "potion_local_liquor_01",
            count = 10,
        },
    },
    ["243210-0"] = { -- telis salvani
        {
            refId = "ingred_rat_meat_01",
            count = 5,
        },
        {
            refId = "ingred_netch_leather_01",
            count = 5,
        },
        {
            refId = "ingred_green_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_comberry_01",
            count = 5,
        },
        {
            refId = "ingred_chokeweed_01",
            count = 5,
        },
        {
            refId = "ingred_bittergreen_petals_01",
            count = 5,
        },
        {
            refId = "ingred_ash_salts_01",
            count = 5,
        },
        {
            refId = "p_restore_health_c",
            count = 1,
        },
        {
            refId = "p_restore_fatigue_c",
            count = 1,
        },
        {
            refId = "p_fortify_health_c",
            count = 1,
        },
        {
            refId = "p_disease_resistance_c",
            count = 1,
        },
        {
            refId = "p_restore_fatigue_b",
            count = 1,
        },
        {
            refId = "p_restore_health_b",
            count = 1,
        },
    },
    ["259837-0"] = { -- ilen faveran
        {
            refId = "sc_ondusisunhinging",
            count = 1,
        },
        {
            refId = "sc_daydenespanacea",
            count = 5,
        },
        {
            refId = "sc_almsiviintervention",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 1,
        },
        {
            refId = "sc_vitality",
            count = 2,
        },
        {
            refId = "sc_oathfast",
            count = 2,
        },
        {
            refId = "sc_mageweal",
            count = 2,
        },
        {
            refId = "sc_insight",
            count = 2,
        },
        {
            refId = "sc_celerity",
            count = 2,
        },
        {
            refId = "sc_bloodthief",
            count = 1,
        },
        {
            refId = "sc_telvinscourage",
            count = 2,
        },
        {
            refId = "sc_restoration",
            count = 1,
        },
        {
            refId = "random_scroll_all",
            count = 6,
        },
    },
    ["259839-0"] = { -- llathyno hlaalu
        {
            refId = "ingred_willow_anther_01",
            count = 5,
        },
        {
            refId = "ingred_trama_root_01",
            count = 5,
        },
        {
            refId = "ingred_stoneflower_petals_01",
            count = 5,
        },
        {
            refId = "ingred_scuttle_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jelly_01",
            count = 5,
        },
        {
            refId = "ingred_resin_01",
            count = 5,
        },
        {
            refId = "ingred_muck_01",
            count = 5,
        },
        {
            refId = "ingred_kresh_fiber_01",
            count = 5,
        },
        {
            refId = "ingred_gravedust_01",
            count = 5,
        },
    },
    ["259838-0"] = { -- llarara omayn
        {
            refId = "ingred_wickwheat_01",
            count = 5,
        },
        {
            refId = "ingred_shalk_resin_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jerky_01",
            count = 5,
        },
        {
            refId = "ingred_saltrice_01",
            count = 5,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 5,
        },
        {
            refId = "ingred_ectoplasm_01",
            count = 5,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 5,
        },
        {
            refId = "p_cure_poison_s",
            count = 2,
        },
        {
            refId = "p_restore_health_c",
            count = 5,
        },
        {
            refId = "p_restore_health_b",
            count = 5,
        },
    },
    ["243209-0"] = { -- dralval andrano
        {
            refId = "ingred_bc_hypha_facia",
            count = 5,
        },
        {
            refId = "ingred_bc_bungler's_bane",
            count = 5,
        },
        {
            refId = "ingred_wickwheat_01",
            count = 5,
        },
        {
            refId = "ingred_scathecraw_01",
            count = 5,
        },
        {
            refId = "ingred_red_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 5,
        },
        {
            refId = "ingred_kagouti_hide_01",
            count = 5,
        },
        {
            refId = "ingred_green_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_black_lichen_01",
            count = 5,
        },
    },
    ["67598-0"] = { -- thorek
        {
            refId = "steel bolt",
            count = 40,
        },
        {
            refId = "steel arrow",
            count = 50,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "hammer_repair",
            count = 15,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
    },
    ["352874-0"] = { -- arnand liric
        {
            refId = "ingred_hound_meat_01",
            count = 10,
        },
        {
            refId = "ingred_netch_leather_01",
            count = 5,
        },
        {
            refId = "ingred_scamp_skin_01",
            count = 5,
        },
        {
            refId = "ingred_corprus_weepings_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jelly_01",
            count = 10,
        },
        {
            refId = "ingred_gravedust_01",
            count = 10,
        },
    },
    ["352877-0"] = { -- dulian
        {
            refId = "ingred_ash_yam_01",
            count = 10,
        },
        {
            refId = "ingred_kwama_cuttle_01",
            count = 10,
        },
        {
            refId = "ingred_muck_01",
            count = 5,
        },
        {
            refId = "ingred_resin_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jerky_01",
            count = 10,
        },
        {
            refId = "ingred_willow_anther_01",
            count = 5,
        },
        {
            refId = "ingred_trama_root_01",
            count = 5,
        },
    },
    ["352875-0"] = { -- yambagorn gor-shulor
        {
            refId = "l_n_repair item",
            count = 10,
        },
        {
            refId = "random_imp_armor",
            count = 4,
        },
        {
            refId = "random_imp_weapon",
            count = 4,
        },
        {
            refId = "random_iron_weapon",
            count = 4,
        },
    },
    ["352870-0"] = { -- cocistian quaspus
        {
            refId = "ingred_fire_petal_01",
            count = 5,
        },
        {
            refId = "ingred_stoneflower_petals_01",
            count = 5,
        },
        {
            refId = "ingred_scathecraw_01",
            count = 10,
        },
        {
            refId = "ingred_rat_meat_01",
            count = 10,
        },
        {
            refId = "ingred_kresh_fiber_01",
            count = 10,
        },
        {
            refId = "ingred_emerald_01",
            count = 2,
        },
        {
            refId = "ingred_bittergreen_petals_01",
            count = 10,
        },
    },
    ["175812-0"] = { -- foves arenim
        {
            refId = "imperial netch blade",
            count = 1,
        },
        {
            refId = "pick_journeyman_01",
            count = 7,
        },
        {
            refId = "probe_journeyman_01",
            count = 7,
        },
    },
    ["175836-0"] = { -- ernand thierry
        {
            refId = "ingred_bc_spore_pod",
            count = 5,
        },
        {
            refId = "ingred_russula_01",
            count = 5,
        },
        {
            refId = "ingred_coprinus_01",
            count = 5,
        },
        {
            refId = "ingred_bc_ampoule_pod",
            count = 5,
        },
        {
            refId = "ingred_bc_coda_flower",
            count = 5,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 5,
        },
        {
            refId = "ingred_alit_hide_01",
            count = 5,
        },
    },
    ["175839-0"] = { -- folms mirel
        {
            refId = "sparkstar",
            count = 10,
        },
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_blackdeath",
            count = 1,
        },
        {
            refId = "sc_blackdespair",
            count = 1,
        },
        {
            refId = "sc_blackfate",
            count = 1,
        },
        {
            refId = "sc_blackmind",
            count = 1,
        },
        {
            refId = "sc_blackscorn",
            count = 1,
        },
        {
            refId = "sc_blacksloth",
            count = 1,
        },
        {
            refId = "sc_blackstorm",
            count = 1,
        },
        {
            refId = "sc_blackweakness",
            count = 1,
        },
        {
            refId = "sc_cureblight_ranged",
            count = 1,
        },
        {
            refId = "sc_divineintervention",
            count = 5,
        },
        {
            refId = "sc_elementalburstfire",
            count = 2,
        },
        {
            refId = "sc_elementalburstfrost",
            count = 2,
        },
        {
            refId = "sc_elementalburstshock",
            count = 2,
        },
        {
            refId = "sc_drathissoulrot",
            count = 1,
        },
        {
            refId = "sc_mark",
            count = 5,
        },
        {
            refId = "sc_leaguestep",
            count = 5,
        },
        {
            refId = "sc_nerusislockjaw",
            count = 5,
        },
        {
            refId = "sc_purityofbody",
            count = 5,
        },
        {
            refId = "sc_sixthbarrier",
            count = 5,
        },
        {
            refId = "sc_summongoldensaint",
            count = 1,
        },
        {
            refId = "sc_summonfrostatronach",
            count = 5,
        },
        {
            refId = "sc_summonflameatronach",
            count = 5,
        },
        {
            refId = "sc_tranasasspellmire",
            count = 2,
        },
        {
            refId = "sc_tranasasspelltrap",
            count = 2,
        },
        {
            refId = "sc_ninthbarrier",
            count = 1,
        },
    },
    ["172892-0"] = { -- hodlismod
        {
            refId = "steel bolt",
            count = 50,
        },
        {
            refId = "steel arrow",
            count = 200,
        },
        {
            refId = "silver arrow",
            count = 50,
        },
        {
            refId = "steel dart",
            count = 30,
        },
        {
            refId = "steel throwing knife",
            count = 20,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["172887-0"] = { -- shenk
        {
            refId = "random_food",
            count = 12,
        },
        {
            refId = "potion_local_liquor_01",
            count = 7,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 7,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
    },
    ["262195-0"] = { -- hreirek the lean
        {
            refId = "pick_journeyman_01",
            count = 3,
        },
        {
            refId = "pick_apprentice_01",
            count = 5,
        },
        {
            refId = "probe_apprentice_01",
            count = 5,
        },
        {
            refId = "probe_journeyman_01",
            count = 3,
        },
    },
    ["213577-0"] = { -- hjotra the peacock
        {
            refId = "torch",
            count = 3,
        },
    },
    ["196603-0"] = { -- kjeld
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "repair_master_01",
            count = 10,
        },
    },
    ["147873-0"] = { -- sirollus saccus
        {
            refId = "glass arrow",
            count = 25,
        },
        {
            refId = "imperial cuirass_armor",
            count = 2,
        },
        {
            refId = "repair_secretmaster_01",
            count = 1,
        },
        {
            refId = "repair_master_01",
            count = 10,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "repair_grandmaster_01",
            count = 10,
        },
    },
    ["276859-0"] = { -- kaye
        {
            refId = "steel bolt",
            count = 50,
        },
        {
            refId = "iron arrow",
            count = 150,
        },
        {
            refId = "steel arrow",
            count = 75,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["276857-0"] = { -- sauleius cullian
        {
            refId = "sc_divineintervention",
            count = 2,
        },
        {
            refId = "sc_daerirsmiracle",
            count = 5,
        },
        {
            refId = "sc_daydenespanacea",
            count = 5,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_vitality",
            count = 2,
        },
        {
            refId = "sc_vigor",
            count = 2,
        },
        {
            refId = "sc_argentglow",
            count = 2,
        },
        {
            refId = "sc_greydeath",
            count = 2,
        },
        {
            refId = "sc_greydespair",
            count = 2,
        },
        {
            refId = "sc_greyfate",
            count = 2,
        },
        {
            refId = "sc_greymind",
            count = 2,
        },
        {
            refId = "sc_greyscorn",
            count = 2,
        },
        {
            refId = "sc_greysloth",
            count = 2,
        },
        {
            refId = "sc_greyweakness",
            count = 2,
        },
        {
            refId = "sc_heartwise",
            count = 5,
        },
        {
            refId = "sc_insight",
            count = 5,
        },
        {
            refId = "sc_mark",
            count = 2,
        },
        {
            refId = "sc_princeovsbrightball",
            count = 5,
        },
        {
            refId = "sc_psychicprison",
            count = 2,
        },
    },
    ["147916-0"] = { -- agning
        {
            refId = "ingred_bread_01",
            count = 5,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 2,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
    },
    ["130858-0"] = { -- massarapal
        {
            refId = "chitin arrow",
            count = 25,
        },
        {
            refId = "chitin throwing star",
            count = 10,
        },
        {
            refId = "random ashlander weapon",
            count = 3,
        },
        {
            refId = "random_armor_chitin",
            count = 3,
        },
    },
    ["130640-0"] = { -- manirai
        {
            refId = "p_restore_health_s",
            count = 1,
        },
        {
            refId = "p_restore_health_c",
            count = 3,
        },
        {
            refId = "p_cure_common_s",
            count = 1,
        },
        {
            refId = "p_disease_resistance_s",
            count = 1,
        },
    },
    ["250195-0"] = { -- arenara
        {
            refId = "repair_master_01",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["270754-0"] = { -- teril savani
        {
            refId = "p_cure_common_s",
            count = 10,
        },
        {
            refId = "p_cure_blight_s",
            count = 10,
        },
        {
            refId = "p_disease_resistance_q",
            count = 5,
        },
        {
            refId = "p_disease_resistance_e",
            count = 2,
        },
    },
    ["271159-0"] = { -- faras thirano
        {
            refId = "dire frostarrow",
            count = 20,
        },
        {
            refId = "sc_daerirsmiracle",
            count = 5,
        },
        {
            refId = "sc_almsiviintervention",
            count = 2,
        },
        {
            refId = "sc_salensvivication",
            count = 2,
        },
        {
            refId = "sc_restoration",
            count = 2,
        },
        {
            refId = "sc_warriorsblessing",
            count = 2,
        },
        {
            refId = "sc_purityofbody",
            count = 1,
        },
        {
            refId = "sc_flameguard",
            count = 2,
        },
        {
            refId = "sc_frostguard",
            count = 2,
        },
        {
            refId = "sc_shockguard",
            count = 2,
        },
        {
            refId = "sc_tranasasspellmire",
            count = 1,
        },
        {
            refId = "sc_mindfeeder",
            count = 1,
        },
        {
            refId = "sc_ninthbarrier",
            count = 1,
        },
        {
            refId = "sc_sixthbarrier",
            count = 2,
        },
    },
    ["270864-0"] = { -- galore salvi
        {
            refId = "random_food",
            count = 20,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 3,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 3,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 2,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 2,
        },
    },
    ["271451-0"] = { -- dronos llervu
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["113181-0"] = { -- hinald
        {
            refId = "chitin arrow",
            count = 50,
        },
        {
            refId = "chitin throwing star",
            count = 40,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["113439-0"] = { -- selvura andrano
        {
            refId = "iron arrow",
            count = 50,
        },
        {
            refId = "iron throwing knife",
            count = 25,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["113440-0"] = { -- anas ulven
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "pick_apprentice_01",
            count = 10,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
        {
            refId = "probe_apprentice_01",
            count = 10,
        },
    },
    ["8162-0"] = { -- hetman abelmawia
        {
            refId = "sc_cureblight_ranged",
            count = 5,
        },
    },
    ["12196-0"] = { -- chaplain ogrul
        {
            refId = "ingred_wickwheat_01",
            count = 10,
        },
        {
            refId = "ingred_saltrice_01",
            count = 10,
        },
        {
            refId = "ingred_rat_meat_01",
            count = 10,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 10,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 10,
        },
        {
            refId = "ingred_ash_yam_01",
            count = 10,
        },
    },
    ["12199-0"] = { -- ulumpha gra-sharob
        {
            refId = "food_kwama_egg_01",
            count = 10,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 10,
        },
        {
            refId = "ingred_frost_salts_01",
            count = 5,
        },
        {
            refId = "ingred_bonemeal_01",
            count = 5,
        },
    },
    ["12198-0"] = { -- mug gro-dulob
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 8,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
    },
    ["33328-0"] = { -- fenas madach
        {
            refId = "pick_apprentice_01",
            count = 7,
        },
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "Gold_001",
            count = 200,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
        {
            refId = "probe_apprentice_01",
            count = 7,
        },
    },
    ["11936-0"] = { -- zanmulk sammalamus
        {
            refId = "food_kwama_egg_01",
            count = 10,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 10,
        },
        {
            refId = "ingred_rat_meat_01",
            count = 10,
        },
        {
            refId = "ingred_ash_yam_01",
            count = 10,
        },
        {
            refId = "ingred_bittergreen_petals_01",
            count = 10,
        },
    },
    ["11934-0"] = { -- mehra drora
        {
            refId = "ingred_netch_leather_01",
            count = 10,
        },
        {
            refId = "ingred_stoneflower_petals_01",
            count = 10,
        },
        {
            refId = "ingred_fire_petal_01",
            count = 5,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 5,
        },
        {
            refId = "ingred_ghoul_heart_01",
            count = 1,
        },
        {
            refId = "ingred_bloat_01",
            count = 10,
        },
        {
            refId = "ingred_dreugh_wax_01",
            count = 5,
        },
        {
            refId = "p_restore_fatigue_c",
            count = 2,
        },
        {
            refId = "p_restore_health_c",
            count = 5,
        },
        {
            refId = "p_restore_health_b",
            count = 5,
        },
    },
    ["118863-0"] = { -- dalam gavyn
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
    },
    ["118880-0"] = { -- trasteve
        {
            refId = "torch",
            count = 2,
        },
    },
    ["118879-0"] = { -- perien aurelie
        {
            refId = "torch",
            count = 3,
        },
    },
    ["118862-0"] = { -- llemisa marys
        {
            refId = "pick_apprentice_01",
            count = 5,
        },
        {
            refId = "pick_journeyman_01",
            count = 10,
        },
        {
            refId = "probe_apprentice_01",
            count = 10,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
    },
    ["472805-0"] = { -- felayn andral
        {
            refId = "sc_ondusisunhinging",
            count = 1,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_vaerminaspromise",
            count = 2,
        },
        {
            refId = "sc_argentglow",
            count = 5,
        },
        {
            refId = "sc_bloodfire",
            count = 5,
        },
        {
            refId = "sc_corruptarcanix",
            count = 2,
        },
        {
            refId = "sc_dawnsprite",
            count = 5,
        },
        {
            refId = "sc_dedresmasterfuleye",
            count = 2,
        },
        {
            refId = "sc_drathiswinterguest",
            count = 5,
        },
        {
            refId = "sc_elevramssty",
            count = 2,
        },
        {
            refId = "sc_golnaraseyemaze",
            count = 2,
        },
        {
            refId = "sc_gamblersprayer",
            count = 5,
        },
        {
            refId = "sc_insight",
            count = 5,
        },
        {
            refId = "sc_mark",
            count = 2,
        },
        {
            refId = "sc_oathfast",
            count = 5,
        },
        {
            refId = "random_scroll_all",
            count = 10,
        },
    },
    ["472804-0"] = { -- tivam sadri
        {
            refId = "ingred_ash_salts_01",
            count = 5,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 5,
        },
        {
            refId = "ingred_ectoplasm_01",
            count = 10,
        },
        {
            refId = "ingred_ghoul_heart_01",
            count = 1,
        },
        {
            refId = "ingred_gravedust_01",
            count = 10,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 10,
        },
        {
            refId = "ingred_muck_01",
            count = 10,
        },
        {
            refId = "ingred_saltrice_01",
            count = 10,
        },
        {
            refId = "ingred_scrib_jerky_01",
            count = 10,
        },
    },
    ["279010-0"] = { -- uvele berendas
        {
            refId = "p_restore_health_b",
            count = 2,
        },
        {
            refId = "p_restore_health_c",
            count = 5,
        },
        {
            refId = "p_disease_resistance_s",
            count = 2,
        },
        {
            refId = "p_restore_magicka_c",
            count = 2,
        },
    },
    ["279013-0"] = { -- lliros tures
        {
            refId = "steel bolt",
            count = 75,
        },
        {
            refId = "steel arrow",
            count = 100,
        },
        {
            refId = "steel dart",
            count = 40,
        },
        {
            refId = "steel throwing knife",
            count = 50,
        },
        {
            refId = "steel throwing star",
            count = 50,
        },
        {
            refId = "torch",
            count = 3,
        },
        {
            refId = "p_restore_health_b",
            count = 2,
        },
        {
            refId = "p_restore_magicka_b",
            count = 2,
        },
        {
            refId = "p_restore_fatigue_b",
            count = 2,
        },
    },
    ["279012-0"] = { -- gilyne omoren
        {
            refId = "silver war axe",
            count = 1,
        },
        {
            refId = "silver spear",
            count = 1,
        },
        {
            refId = "steel halberd",
            count = 1,
        },
        {
            refId = "steel spear",
            count = 1,
        },
        {
            refId = "steel warhammer",
            count = 2,
        },
        {
            refId = "silver claymore",
            count = 1,
        },
        {
            refId = "silver longsword",
            count = 1,
        },
        {
            refId = "silver shortsword",
            count = 1,
        },
        {
            refId = "silver dagger",
            count = 1,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["341085-0"] = { -- manse andus
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "potion_local_liquor_01",
            count = 6,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 6,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 6,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 6,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
    },
    ["233184-0"] = { -- alds baro
        {
            refId = "silver bolt",
            count = 50,
        },
        {
            refId = "silver arrow",
            count = 100,
        },
        {
            refId = "repair_master_01",
            count = 6,
        },
        {
            refId = "repair_journeyman_01",
            count = 6,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
    },
    ["233188-0"] = { -- sedris omalen
        {
            refId = "ingred_saltrice_01",
            count = 10,
        },
        {
            refId = "ingred_alit_hide_01",
            count = 10,
        },
        {
            refId = "ingred_black_lichen_01",
            count = 3,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 10,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 5,
        },
    },
    ["233552-0"] = { -- salen ravel
        {
            refId = "ingred_dreugh_wax_01",
            count = 5,
        },
        {
            refId = "ingred_ectoplasm_01",
            count = 5,
        },
        {
            refId = "ingred_gravedust_01",
            count = 10,
        },
        {
            refId = "ingred_kagouti_hide_01",
            count = 10,
        },
        {
            refId = "ingred_shalk_resin_01",
            count = 5,
        },
    },
    ["248395-0"] = { -- hakar the candle
        {
            refId = "repair_master_01",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["248439-0"] = { -- saetring
        {
            refId = "bonemold bolt",
            count = 50,
        },
        {
            refId = "bonemold arrow",
            count = 150,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "repair_master_01",
            count = 10,
        },
    },
    ["353281-0"] = { -- erla
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["353288-0"] = { -- somutis vunnis
        {
            refId = "ingred_black_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_ash_salts_01",
            count = 5,
        },
        {
            refId = "ingred_dreugh_wax_01",
            count = 5,
        },
        {
            refId = "ingred_kresh_fiber_01",
            count = 5,
        },
        {
            refId = "ingred_roobrush_01",
            count = 5,
        },
        {
            refId = "ingred_fire_petal_01",
            count = 5,
        },
    },
    ["353285-0"] = { -- peragon
        {
            refId = "ingred_bc_spore_pod",
            count = 5,
        },
        {
            refId = "ingred_bc_coda_flower",
            count = 5,
        },
        {
            refId = "ingred_russula_01",
            count = 5,
        },
        {
            refId = "ingred_sload_soap_01",
            count = 5,
        },
        {
            refId = "ingred_pearl_01",
            count = 2,
        },
        {
            refId = "ingred_heather_01",
            count = 5,
        },
        {
            refId = "ingred_gold_kanet_01",
            count = 5,
        },
    },
    ["353286-0"] = { -- crulius pontanian
        {
            refId = "sc_divineintervention",
            count = 3,
        },
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_daerirsmiracle",
            count = 5,
        },
        {
            refId = "sc_daydenespanacea",
            count = 5,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_restoration",
            count = 2,
        },
        {
            refId = "sc_healing",
            count = 5,
        },
        {
            refId = "sc_purityofbody",
            count = 5,
        },
        {
            refId = "sc_sertisesporphyry",
            count = 5,
        },
        {
            refId = "sc_fifthbarrier",
            count = 5,
        },
        {
            refId = "sc_sixthbarrier",
            count = 2,
        },
    },
    ["22870-0"] = { -- ygfa
        {
            refId = "ingred_ash_yam_01",
            count = 5,
        },
        {
            refId = "ingred_bittergreen_petals_01",
            count = 5,
        },
        {
            refId = "ingred_chokeweed_01",
            count = 5,
        },
        {
            refId = "ingred_guar_hide_01",
            count = 4,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 5,
        },
        {
            refId = "p_cure_common_s",
            count = 1,
        },
        {
            refId = "p_cure_paralyzation_s",
            count = 1,
        },
        {
            refId = "p_cure_poison_s",
            count = 1,
        },
        {
            refId = "p_cure_blight_s",
            count = 1,
        },
    },
    ["22867-0"] = { -- shadbak gra-burbug
        {
            refId = "iron arrow",
            count = 60,
        },
        {
            refId = "imperial broadsword",
            count = 1,
        },
        {
            refId = "imperial shortsword",
            count = 1,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
    },
    ["48754-0"] = { -- drelasa ramothran
        {
            refId = "random_food",
            count = 15,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 2,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 2,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
    },
    ["368078-0"] = { -- mebestian ence
        {
            refId = "steel staff",
            count = 1,
        },
        {
            refId = "silver staff",
            count = 1,
        },
        {
            refId = "steel warhammer",
            count = 1,
        },
        {
            refId = "iron warhammer",
            count = 1,
        },
        {
            refId = "steel club",
            count = 1,
        },
        {
            refId = "steel mace",
            count = 1,
        },
        {
            refId = "spiked club",
            count = 1,
        },
        {
            refId = "iron mace",
            count = 1,
        },
        {
            refId = "iron club",
            count = 1,
        },
    },
    ["7600-0"] = { -- uulernil
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
    },
    ["278956-0"] = { -- lliryn fendyn
        {
            refId = "pick_apprentice_01",
            count = 10,
        },
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "probe_apprentice_01",
            count = 10,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
    },
    ["77710-0"] = { -- anis seloth
        {
            refId = "ingred_coprinus_01",
            count = 10,
        },
        {
            refId = "ingred_russula_01",
            count = 10,
        },
        {
            refId = "ingred_bc_hypha_facia",
            count = 10,
        },
        {
            refId = "ingred_bc_coda_flower",
            count = 10,
        },
        {
            refId = "ingred_willow_anther_01",
            count = 10,
        },
        {
            refId = "ingred_wickwheat_01",
            count = 10,
        },
        {
            refId = "ingred_vampire_dust_01",
            count = 2,
        },
        {
            refId = "ingred_trama_root_01",
            count = 10,
        },
        {
            refId = "ingred_sload_soap_01",
            count = 10,
        },
        {
            refId = "ingred_scrap_metal_01",
            count = 5,
        },
        {
            refId = "ingred_scales_01",
            count = 10,
        },
        {
            refId = "ingred_ruby_01",
            count = 4,
        },
        {
            refId = "ingred_pearl_01",
            count = 4,
        },
        {
            refId = "ingred_muck_01",
            count = 10,
        },
        {
            refId = "ingred_kwama_cuttle_01",
            count = 10,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 10,
        },
        {
            refId = "ingred_heather_01",
            count = 10,
        },
        {
            refId = "ingred_ghoul_heart_01",
            count = 2,
        },
        {
            refId = "ingred_frost_salts_01",
            count = 5,
        },
        {
            refId = "ingred_fire_salts_01",
            count = 5,
        },
        {
            refId = "ingred_diamond_01",
            count = 4,
        },
        {
            refId = "ingred_daedras_heart_01",
            count = 2,
        },
        {
            refId = "ingred_daedra_skin_01",
            count = 2,
        },
        {
            refId = "ingred_bonemeal_01",
            count = 10,
        },
        {
            refId = "ingred_bloat_01",
            count = 10,
        },
        {
            refId = "ingred_alit_hide_01",
            count = 5,
        },
    },
    ["270616-0"] = { -- muriel sette
        {
            refId = "pick_journeyman_01",
            count = 4,
        },
        {
            refId = "probe_journeyman_01",
            count = 4,
        },
    },
    ["270619-0"] = { -- big helende
        {
            refId = "pick_master",
            count = 3,
        },
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "probe_master",
            count = 3,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
    },
    ["270620-0"] = { -- both gro-durug
        {
            refId = "iron bolt",
            count = 50,
        },
        {
            refId = "chitin arrow",
            count = 75,
        },
        {
            refId = "iron arrow",
            count = 50,
        },
        {
            refId = "chitin throwing star",
            count = 20,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["77967-0"] = { -- fara
        {
            refId = "pick_apprentice_01",
            count = 5,
        },
        {
            refId = "pick_journeyman_01",
            count = 3,
        },
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
        {
            refId = "probe_journeyman_01",
            count = 3,
        },
        {
            refId = "probe_apprentice_01",
            count = 5,
        },
    },
    ["47940-0"] = { -- ery
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
    },
    ["85708-0"] = { -- dunsalipal dun-ahhe
        {
            refId = "pick_master",
            count = 3,
        },
        {
            refId = "pick_apprentice_01",
            count = 15,
        },
        {
            refId = "pick_journeyman_01",
            count = 7,
        },
        {
            refId = "probe_master",
            count = 3,
        },
        {
            refId = "probe_journeyman_01",
            count = 6,
        },
    },
    ["86101-0"] = { -- meder nulen
        {
            refId = "iron bolt",
            count = 40,
        },
        {
            refId = "iron arrow",
            count = 50,
        },
        {
            refId = "chitin arrow",
            count = 75,
        },
        {
            refId = "chitin throwing star",
            count = 20,
        },
        {
            refId = "torch",
            count = 3,
        },
    },
    ["86102-0"] = { -- minasi bavani
        {
            refId = "pick_apprentice_01",
            count = 4,
        },
        {
            refId = "pick_journeyman_01",
            count = 2,
        },
        {
            refId = "probe_journeyman_01",
            count = 2,
        },
        {
            refId = "probe_apprentice_01",
            count = 4,
        },
    },
    ["315499-0"] = { -- pierlette rostorard
        {
            refId = "ingred_fire_petal_01",
            count = 5,
        },
        {
            refId = "ingred_stoneflower_petals_01",
            count = 10,
        },
        {
            refId = "ingred_shalk_resin_01",
            count = 5,
        },
        {
            refId = "ingred_scathecraw_01",
            count = 10,
        },
        {
            refId = "ingred_roobrush_01",
            count = 5,
        },
        {
            refId = "ingred_resin_01",
            count = 10,
        },
        {
            refId = "ingred_red_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_kresh_fiber_01",
            count = 10,
        },
        {
            refId = "ingred_kagouti_hide_01",
            count = 10,
        },
        {
            refId = "ingred_ectoplasm_01",
            count = 5,
        },
        {
            refId = "ingred_dreugh_wax_01",
            count = 5,
        },
        {
            refId = "ingred_black_lichen_01",
            count = 5,
        },
        {
            refId = "p_cure_blight_s",
            count = 3,
        },
    },
    ["428199-0"] = { -- miraso seran
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_almsiviintervention",
            count = 2,
        },
        {
            refId = "sc_daerirsmiracle",
            count = 5,
        },
        {
            refId = "sc_daydenespanacea",
            count = 5,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 1,
        },
        {
            refId = "sc_dawnsprite",
            count = 2,
        },
        {
            refId = "sc_gamblersprayer",
            count = 2,
        },
        {
            refId = "sc_oathfast",
            count = 2,
        },
        {
            refId = "sc_savagemight",
            count = 2,
        },
        {
            refId = "sc_vitality",
            count = 2,
        },
        {
            refId = "sc_vigor",
            count = 2,
        },
        {
            refId = "sc_secondbarrier",
            count = 2,
        },
        {
            refId = "sc_firstbarrier",
            count = 2,
        },
        {
            refId = "sc_bloodthief",
            count = 2,
        },
        {
            refId = "sc_mageweal",
            count = 2,
        },
    },
    ["338964-0"] = { -- galar rothan
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_blackdeath",
            count = 1,
        },
        {
            refId = "sc_blackdespair",
            count = 1,
        },
        {
            refId = "sc_blackfate",
            count = 1,
        },
        {
            refId = "sc_blackmind",
            count = 1,
        },
        {
            refId = "sc_blackscorn",
            count = 1,
        },
        {
            refId = "sc_blacksloth",
            count = 1,
        },
        {
            refId = "sc_blackweakness",
            count = 1,
        },
        {
            refId = "sc_summonflameatronach",
            count = 1,
        },
        {
            refId = "sc_summonfrostatronach",
            count = 1,
        },
        {
            refId = "sc_summonskeletalservant",
            count = 1,
        },
        {
            refId = "sc_sertisesporphyry",
            count = 2,
        },
        {
            refId = "sc_inaschastening",
            count = 2,
        },
        {
            refId = "sc_gonarsgoad",
            count = 5,
        },
        {
            refId = "sc_lesserdomination",
            count = 1,
        },
        {
            refId = "sc_alvusiaswarping",
            count = 5,
        },
        {
            refId = "sc_tranasasspelltrap",
            count = 5,
        },
    },
    ["77652-0"] = { -- thervul serethi
        {
            refId = "ingred_corprus_weepings_01",
            count = 5,
        },
        {
            refId = "ingred_bittergreen_petals_01",
            count = 10,
        },
        {
            refId = "ingred_wickwheat_01",
            count = 10,
        },
        {
            refId = "ingred_scuttle_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jelly_01",
            count = 5,
        },
        {
            refId = "ingred_netch_leather_01",
            count = 5,
        },
        {
            refId = "food_kwama_egg_01",
            count = 10,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 10,
        },
    },
    ["479452-0"] = { -- hrundi
        {
            refId = "bonemold arrow",
            count = 150,
        },
        {
            refId = "random_silver_weapon",
            count = 3,
        },
        {
            refId = "random_steel_weapon",
            count = 5,
        },
        {
            refId = "repair_journeyman_01",
            count = 15,
        },
        {
            refId = "repair_master_01",
            count = 10,
        },
    },
    ["479559-0"] = { -- aunius autrus
        {
            refId = "ingred_guar_hide_01",
            count = 5,
        },
        {
            refId = "ingred_scamp_skin_01",
            count = 5,
        },
        {
            refId = "ingred_ash_yam_01",
            count = 10,
        },
        {
            refId = "ingred_bloat_01",
            count = 5,
        },
        {
            refId = "ingred_netch_leather_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jerky_01",
            count = 10,
        },
        {
            refId = "ingred_gravedust_01",
            count = 5,
        },
    },
    ["479560-0"] = { -- scelian plebo
        {
            refId = "ingred_green_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_emerald_01",
            count = 2,
        },
        {
            refId = "ingred_corprus_weepings_01",
            count = 5,
        },
        {
            refId = "ingred_chokeweed_01",
            count = 10,
        },
        {
            refId = "ingred_saltrice_01",
            count = 10,
        },
        {
            refId = "ingred_rat_meat_01",
            count = 10,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 10,
        },
        {
            refId = "ingred_comberry_01",
            count = 10,
        },
        {
            refId = "ingred_bonemeal_01",
            count = 5,
        },
        {
            refId = "ingred_bittergreen_petals_01",
            count = 10,
        },
        {
            refId = "ingred_ash_salts_01",
            count = 5,
        },
    },
    ["369036-0"] = { -- dabienne mornardl
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_balefulsuffering",
            count = 2,
        },
        {
            refId = "sc_brevasavertedeyes",
            count = 2,
        },
        {
            refId = "sc_daynarsairybubble",
            count = 2,
        },
        {
            refId = "sc_fadersleadenflesh",
            count = 2,
        },
        {
            refId = "sc_flameguard",
            count = 5,
        },
        {
            refId = "sc_frostguard",
            count = 5,
        },
        {
            refId = "sc_shockguard",
            count = 5,
        },
        {
            refId = "sc_summonskeletalservant",
            count = 1,
        },
        {
            refId = "sc_reynosbeastfinder",
            count = 2,
        },
        {
            refId = "sc_reynosfins",
            count = 1,
        },
        {
            refId = "sc_thirdbarrier",
            count = 5,
        },
        {
            refId = "l_m_enchantitem_imperial_rank0",
            count = 3,
        },
        {
            refId = "random_scroll_all",
            count = 6,
        },
    },
    ["369033-0"] = { -- tusamircil
        {
            refId = "ingred_bc_bungler's_bane",
            count = 5,
        },
        {
            refId = "ingred_bc_ampoule_pod",
            count = 5,
        },
        {
            refId = "ingred_bc_spore_pod",
            count = 5,
        },
        {
            refId = "ingred_trama_root_01",
            count = 10,
        },
        {
            refId = "ingred_racer_plumes_01",
            count = 10,
        },
        {
            refId = "food_kwama_egg_01",
            count = 10,
        },
        {
            refId = "ingred_kwama_cuttle_01",
            count = 10,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 10,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 10,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 10,
        },
    },
    ["331473-0"] = { -- arrille
        {
            refId = "ingred_scrib_jerky_01",
            count = 5,
        },
        {
            refId = "ingred_shalk_resin_01",
            count = 5,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 5,
        },
        {
            refId = "sc_drathiswinterguest",
            count = 2,
        },
        {
            refId = "sc_almsiviintervention",
            count = 2,
        },
        {
            refId = "sc_heartwise",
            count = 2,
        },
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_summonskeletalservant",
            count = 2,
        },
        {
            refId = "sc_vigor",
            count = 2,
        },
        {
            refId = "sc_vitality",
            count = 2,
        },
        {
            refId = "sc_argentglow",
            count = 2,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 2,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 2,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 2,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 2,
        },
        {
            refId = "potion_local_liquor_01",
            count = 2,
        },
    },
    ["480987-0"] = { -- garothmuk gro-muzgub
        {
            refId = "chitin throwing star",
            count = 40,
        },
        {
            refId = "l_n_repair item",
            count = 6,
        },
        {
            refId = "l_n_wpn_melee",
            count = 4,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["262206-0"] = { -- ravoso aryon
        {
            refId = "steel bolt",
            count = 50,
        },
        {
            refId = "steel arrow",
            count = 100,
        },
        {
            refId = "pick_apprentice_01",
            count = 1,
        },
        {
            refId = "random_de_pants",
            count = 2,
        },
        {
            refId = "random_de_robe",
            count = 2,
        },
        {
            refId = "random_de_shirt",
            count = 2,
        },
        {
            refId = "random_de_shoes_common",
            count = 2,
        },
    },
    ["262207-0"] = { -- avon oran
        {
            refId = "pick_master",
            count = 2,
        },
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "probe_master",
            count = 2,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
    },
    ["262457-0"] = { -- ashumanu eraishah
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
    },
    ["176855-0"] = { -- aryne telnim
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "hammer_repair",
            count = 15,
        },
    },
    ["176700-0"] = { -- bildren areleth
        {
            refId = "ingred_stoneflower_petals_01",
            count = 10,
        },
        {
            refId = "ingred_resin_01",
            count = 5,
        },
        {
            refId = "ingred_kresh_fiber_01",
            count = 10,
        },
        {
            refId = "ingred_kagouti_hide_01",
            count = 5,
        },
        {
            refId = "ingred_heather_01",
            count = 10,
        },
        {
            refId = "ingred_ectoplasm_01",
            count = 5,
        },
        {
            refId = "ingred_bittergreen_petals_01",
            count = 10,
        },
        {
            refId = "potion_t_bug_musk_01",
            count = 1,
        },
    },
    ["176759-0"] = { -- maren uvaren
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_greydeath",
            count = 2,
        },
        {
            refId = "sc_greydespair",
            count = 2,
        },
        {
            refId = "sc_greyfate",
            count = 2,
        },
        {
            refId = "sc_greymind",
            count = 2,
        },
        {
            refId = "sc_greyscorn",
            count = 2,
        },
        {
            refId = "sc_greysloth",
            count = 2,
        },
        {
            refId = "sc_greyweakness",
            count = 2,
        },
        {
            refId = "sc_golnaraseyemaze",
            count = 5,
        },
        {
            refId = "sc_frostguard",
            count = 2,
        },
        {
            refId = "sc_shockguard",
            count = 2,
        },
        {
            refId = "sc_flameguard",
            count = 2,
        },
        {
            refId = "sc_invisibility",
            count = 2,
        },
        {
            refId = "sc_radrenesspellbreaker",
            count = 1,
        },
        {
            refId = "sc_manarape",
            count = 5,
        },
        {
            refId = "sc_salensvivication",
            count = 5,
        },
        {
            refId = "sc_stormward",
            count = 5,
        },
    },
    ["176968-0"] = { -- drarayne girith
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
    },
    ["315228-0"] = { -- brarayni sarys
        {
            refId = "ingred_vampire_dust_01",
            count = 1,
        },
        {
            refId = "ingred_bc_coda_flower",
            count = 5,
        },
        {
            refId = "ingred_bc_spore_pod",
            count = 5,
        },
        {
            refId = "ingred_sload_soap_01",
            count = 5,
        },
        {
            refId = "ingred_racer_plumes_01",
            count = 10,
        },
        {
            refId = "ingred_muck_01",
            count = 10,
        },
        {
            refId = "ingred_heather_01",
            count = 10,
        },
        {
            refId = "ingred_ghoul_heart_01",
            count = 1,
        },
        {
            refId = "ingred_diamond_01",
            count = 2,
        },
        {
            refId = "ingred_daedra_skin_01",
            count = 2,
        },
        {
            refId = "ingred_black_anther_01",
            count = 10,
        },
    },
    ["315229-0"] = { -- irna maryon
        {
            refId = "ingred_wickwheat_01",
            count = 10,
        },
        {
            refId = "ingred_fire_petal_01",
            count = 10,
        },
        {
            refId = "ingred_scathecraw_01",
            count = 10,
        },
        {
            refId = "ingred_roobrush_01",
            count = 5,
        },
        {
            refId = "ingred_red_lichen_01",
            count = 3,
        },
        {
            refId = "ingred_kwama_cuttle_01",
            count = 5,
        },
        {
            refId = "ingred_green_lichen_01",
            count = 3,
        },
        {
            refId = "ingred_emerald_01",
            count = 2,
        },
        {
            refId = "ingred_black_lichen_01",
            count = 3,
        },
    },
    ["315344-0"] = { -- barusi venim
        {
            refId = "sc_fphyggisgemfeeder",
            count = 4,
        },
        {
            refId = "sc_radiyasicymask",
            count = 5,
        },
        {
            refId = "sc_princeovsbrightball",
            count = 5,
        },
        {
            refId = "sc_inasismysticfinger",
            count = 5,
        },
        {
            refId = "sc_inaschastening",
            count = 5,
        },
        {
            refId = "sc_gonarsgoad",
            count = 5,
        },
        {
            refId = "sc_fadersleadenflesh",
            count = 5,
        },
        {
            refId = "sc_firstbarrier",
            count = 5,
        },
        {
            refId = "sc_secondbarrier",
            count = 5,
        },
        {
            refId = "sc_selisfieryward",
            count = 5,
        },
        {
            refId = "sc_tevilspeace",
            count = 5,
        },
        {
            refId = "sc_toususabidingbeast",
            count = 5,
        },
        {
            refId = "sc_vitality",
            count = 5,
        },
        {
            refId = "sc_healing",
            count = 5,
        },
        {
            refId = "sc_leaguestep",
            count = 5,
        },
    },
    ["315343-0"] = { -- felara andrethi
        {
            refId = "ingred_scuttle_01",
            count = 5,
        },
        {
            refId = "ingred_scamp_skin_01",
            count = 5,
        },
        {
            refId = "ingred_saltrice_01",
            count = 10,
        },
        {
            refId = "ingred_rat_meat_01",
            count = 10,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 10,
        },
        {
            refId = "food_kwama_egg_01",
            count = 10,
        },
        {
            refId = "ingred_comberry_01",
            count = 10,
        },
        {
            refId = "ingred_chokeweed_01",
            count = 4,
        },
    },
    ["190375-0"] = { -- fadase selvayn
        {
            refId = "Misc_SoulGem_Petty",
            count = 10,
        },
        {
            refId = "Misc_SoulGem_Lesser",
            count = 5,
        },
        {
            refId = "Misc_SoulGem_Common",
            count = 3,
        },
    },
    ["190301-0"] = { -- galen berer
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["190263-0"] = { -- llorayna sethan
        {
            refId = "random_food",
            count = 20,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 2,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
    },
    ["357798-0"] = { -- gils drelas
        {
            refId = "ingred_willow_anther_01",
            count = 10,
        },
        {
            refId = "ingred_void_salts_01",
            count = 2,
        },
        {
            refId = "ingred_trama_root_01",
            count = 5,
        },
        {
            refId = "ingred_scrap_metal_01",
            count = 5,
        },
        {
            refId = "ingred_scales_01",
            count = 10,
        },
        {
            refId = "ingred_ruby_01",
            count = 3,
        },
        {
            refId = "ingred_pearl_01",
            count = 3,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 10,
        },
        {
            refId = "ingred_gold_kanet_01",
            count = 10,
        },
        {
            refId = "ingred_frost_salts_01",
            count = 4,
        },
        {
            refId = "ingred_fire_salts_01",
            count = 4,
        },
        {
            refId = "ingred_daedras_heart_01",
            count = 2,
        },
    },
    ["361488-0"] = { -- jolda
        {
            refId = "ingred_coprinus_01",
            count = 10,
        },
        {
            refId = "ingred_russula_01",
            count = 10,
        },
        {
            refId = "ingred_bc_bungler's_bane",
            count = 5,
        },
        {
            refId = "ingred_bc_hypha_facia",
            count = 5,
        },
        {
            refId = "ingred_bc_ampoule_pod",
            count = 5,
        },
        {
            refId = "ingred_void_salts_01",
            count = 5,
        },
        {
            refId = "ingred_resin_01",
            count = 10,
        },
        {
            refId = "ingred_pearl_01",
            count = 2,
        },
        {
            refId = "ingred_dreugh_wax_01",
            count = 5,
        },
        {
            refId = "ingred_black_lichen_01",
            count = 5,
        },
    },
    ["361697-0"] = { -- daynali dren
        {
            refId = "ingred_bloat_01",
            count = 10,
        },
        {
            refId = "ingred_alit_hide_01",
            count = 5,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 10,
        },
        {
            refId = "ingred_willow_anther_01",
            count = 10,
        },
        {
            refId = "ingred_trama_root_01",
            count = 10,
        },
        {
            refId = "ingred_scrap_metal_01",
            count = 5,
        },
        {
            refId = "ingred_scales_01",
            count = 10,
        },
        {
            refId = "ingred_ruby_01",
            count = 4,
        },
        {
            refId = "ingred_racer_plumes_01",
            count = 10,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 10,
        },
        {
            refId = "ingred_gold_kanet_01",
            count = 10,
        },
        {
            refId = "ingred_frost_salts_01",
            count = 5,
        },
        {
            refId = "ingred_diamond_01",
            count = 3,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 10,
        },
        {
            refId = "ingred_black_anther_01",
            count = 10,
        },
        {
            refId = "apparatus_g_retort_01",
            count = 1,
        },
        {
            refId = "apparatus_g_mortar_01",
            count = 1,
        },
        {
            refId = "apparatus_g_calcinator_01",
            count = 1,
        },
        {
            refId = "apparatus_g_alembic_01",
            count = 1,
        },
    },
    ["361925-0"] = { -- radras
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["361996-0"] = { -- thaeril
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
    },
    ["276257-0"] = { -- hlendrisa seleth
        {
            refId = "sc_ondusisunhinging",
            count = 1,
        },
        {
            refId = "sc_restoration",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_supremedomination",
            count = 1,
        },
        {
            refId = "sc_summonflameatronach",
            count = 1,
        },
        {
            refId = "sc_summonfrostatronach",
            count = 1,
        },
        {
            refId = "sc_blackdeath",
            count = 2,
        },
        {
            refId = "sc_blackstorm",
            count = 2,
        },
        {
            refId = "sc_drathissoulrot",
            count = 1,
        },
        {
            refId = "sc_elementalburstfire",
            count = 2,
        },
        {
            refId = "sc_elementalburstfrost",
            count = 2,
        },
        {
            refId = "sc_elementalburstshock",
            count = 2,
        },
        {
            refId = "sc_hellfire",
            count = 1,
        },
        {
            refId = "sc_ninthbarrier",
            count = 1,
        },
        {
            refId = "sc_sixthbarrier",
            count = 3,
        },
        {
            refId = "sc_illneasbreath",
            count = 2,
        },
        {
            refId = "random_scroll_all",
            count = 6,
        },
    },
    ["312900-0"] = { -- milar maryon
        {
            refId = "ingred_wickwheat_01",
            count = 10,
        },
        {
            refId = "ingred_rat_meat_01",
            count = 10,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 10,
        },
        {
            refId = "ingred_gravedust_01",
            count = 10,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 10,
        },
        {
            refId = "ingred_comberry_01",
            count = 10,
        },
        {
            refId = "ingred_bonemeal_01",
            count = 5,
        },
        {
            refId = "ingred_ash_yam_01",
            count = 5,
        },
    },
    ["312897-0"] = { -- alenus vendu
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_princeovsbrightball",
            count = 5,
        },
        {
            refId = "sc_psychicprison",
            count = 2,
        },
        {
            refId = "sc_radiyasicymask",
            count = 5,
        },
        {
            refId = "sc_selisfieryward",
            count = 5,
        },
        {
            refId = "sc_stormward",
            count = 5,
        },
        {
            refId = "sc_shockbane",
            count = 5,
        },
        {
            refId = "sc_flamebane",
            count = 5,
        },
        {
            refId = "sc_frostbane",
            count = 5,
        },
        {
            refId = "sc_reddeath",
            count = 1,
        },
        {
            refId = "sc_reddespair",
            count = 1,
        },
        {
            refId = "sc_redfate",
            count = 1,
        },
        {
            refId = "sc_redmind",
            count = 1,
        },
        {
            refId = "sc_redscorn",
            count = 1,
        },
        {
            refId = "sc_redsloth",
            count = 1,
        },
        {
            refId = "sc_redweakness",
            count = 1,
        },
        {
            refId = "sc_fourthbarrier",
            count = 2,
        },
        {
            refId = "sc_fifthbarrier",
            count = 1,
        },
        {
            refId = "sc_greaterdomination",
            count = 1,
        },
        {
            refId = "sc_healing",
            count = 3,
        },
    },
    ["312901-0"] = { -- andil
        {
            refId = "ingred_stoneflower_petals_01",
            count = 10,
        },
        {
            refId = "ingred_shalk_resin_01",
            count = 5,
        },
        {
            refId = "ingred_scathecraw_01",
            count = 10,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 10,
        },
        {
            refId = "ingred_kresh_fiber_01",
            count = 5,
        },
        {
            refId = "ingred_gold_kanet_01",
            count = 10,
        },
        {
            refId = "ingred_black_anther_01",
            count = 10,
        },
    },
    ["130421-0"] = { -- kurapli
        {
            refId = "chitin arrow",
            count = 20,
        },
        {
            refId = "chitin throwing star",
            count = 15,
        },
        {
            refId = "random ashlander weapon",
            count = 4,
        },
        {
            refId = "random_armor_chitin",
            count = 4,
        },
        {
            refId = "repair_journeyman_01",
            count = 2,
        },
    },
    ["130071-0"] = { -- nibani maesa
        {
            refId = "p_disease_resistance_s",
            count = 1,
        },
        {
            refId = "p_cure_common_s",
            count = 1,
        },
        {
            refId = "p_restore_health_c",
            count = 3,
        },
        {
            refId = "p_restore_health_s",
            count = 1,
        },
    },
    ["331415-0"] = { -- alusaron
        {
            refId = "spark arrow",
            count = 100,
        },
        {
            refId = "bonemold arrow",
            count = 150,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "repair_master_01",
            count = 10,
        },
    },
    ["218504-0"] = { -- andilu drothan
        {
            refId = "ingred_trama_root_01",
            count = 5,
        },
        {
            refId = "ingred_sload_soap_01",
            count = 5,
        },
        {
            refId = "ingred_scrap_metal_01",
            count = 4,
        },
        {
            refId = "ingred_heather_01",
            count = 5,
        },
        {
            refId = "ingred_gold_kanet_01",
            count = 5,
        },
        {
            refId = "ingred_comberry_01",
            count = 5,
        },
        {
            refId = "ingred_muck_01",
            count = 5,
        },
    },
    ["242314-0"] = { -- rogdul gro-bularz
        {
            refId = "pick_master",
            count = 3,
        },
        {
            refId = "pick_journeyman_01",
            count = 5,
        },
        {
            refId = "probe_master",
            count = 3,
        },
        {
            refId = "probe_journeyman_01",
            count = 5,
        },
    },
    ["218461-0"] = { -- aurane frernis
        {
            refId = "ingred_black_anther_01",
            count = 5,
        },
        {
            refId = "ingred_resin_01",
            count = 5,
        },
        {
            refId = "ingred_red_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_shalk_resin_01",
            count = 5,
        },
        {
            refId = "ingred_bc_coda_flower",
            count = 5,
        },
        {
            refId = "ingred_bc_hypha_facia",
            count = 5,
        },
        {
            refId = "ingred_corprus_weepings_01",
            count = 3,
        },
        {
            refId = "ingred_green_lichen_01",
            count = 5,
        },
    },
    ["217856-0"] = { -- huleeya
        {
            refId = "pick_journeyman_01",
            count = 2,
        },
        {
            refId = "probe_journeyman_01",
            count = 2,
        },
    },
    ["217851-0"] = { -- raril giral
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
    },
    ["201958-0"] = { -- sovali uvayn
        {
            refId = "pick_apprentice_01",
            count = 4,
        },
        {
            refId = "pick_journeyman_01",
            count = 2,
        },
        {
            refId = "probe_journeyman_01",
            count = 2,
        },
    },
    ["201957-0"] = { -- gadela andus
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "random_drinks_01",
            count = 10,
        },
    },
    ["215911-0"] = { -- idonea munia
        {
            refId = "p_restore_health_b",
            count = 2,
        },
        {
            refId = "p_cure_poison_s",
            count = 2,
        },
    },
    ["215280-0"] = { -- lorbumol gro-aglakh
        {
            refId = "steel bolt",
            count = 50,
        },
        {
            refId = "silver bolt",
            count = 30,
        },
        {
            refId = "steel arrow",
            count = 100,
        },
        {
            refId = "silver arrow",
            count = 75,
        },
        {
            refId = "silver dart",
            count = 25,
        },
        {
            refId = "silver throwing star",
            count = 25,
        },
        {
            refId = "steel dart",
            count = 25,
        },
        {
            refId = "steel throwing knife",
            count = 30,
        },
        {
            refId = "steel throwing star",
            count = 30,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "repair_master_01",
            count = 10,
        },
        {
            refId = "repair_grandmaster_01",
            count = 10,
        },
    },
    ["214970-0"] = { -- craeita jullalian
        {
            refId = "ingred_bc_ampoule_pod",
            count = 5,
        },
        {
            refId = "ingred_fire_salts_01",
            count = 5,
        },
        {
            refId = "ingred_frost_salts_01",
            count = 5,
        },
        {
            refId = "ingred_bloat_01",
            count = 5,
        },
        {
            refId = "ingred_daedras_heart_01",
            count = 1,
        },
        {
            refId = "ingred_diamond_01",
            count = 2,
        },
        {
            refId = "ingred_ruby_01",
            count = 2,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 5,
        },
        {
            refId = "ingred_alit_hide_01",
            count = 5,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 5,
        },
        {
            refId = "ingred_emerald_01",
            count = 2,
        },
        {
            refId = "ingred_pearl_01",
            count = 2,
        },
        {
            refId = "ingred_racer_plumes_01",
            count = 5,
        },
        {
            refId = "ingred_ghoul_heart_01",
            count = 1,
        },
    },
    ["214973-0"] = { -- janand maulinie
        {
            refId = "sc_divineintervention",
            count = 2,
        },
        {
            refId = "sc_ondusisunhinging",
            count = 1,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 3,
        },
        {
            refId = "sc_shockbane",
            count = 5,
        },
        {
            refId = "sc_frostbane",
            count = 5,
        },
        {
            refId = "sc_flamebane",
            count = 5,
        },
        {
            refId = "sc_fourthbarrier",
            count = 2,
        },
        {
            refId = "sc_thirdbarrier",
            count = 5,
        },
        {
            refId = "sc_radrenesspellbreaker",
            count = 2,
        },
        {
            refId = "sc_galmsesseal",
            count = 5,
        },
        {
            refId = "sc_invisibility",
            count = 1,
        },
        {
            refId = "sc_llirosglowingeye",
            count = 2,
        },
        {
            refId = "sc_mageseye",
            count = 2,
        },
        {
            refId = "sc_mageweal",
            count = 2,
        },
        {
            refId = "random_scroll_all",
            count = 6,
        },
    },
    ["215787-0"] = { -- dileno lloran
        {
            refId = "p_levitation_s",
            count = 2,
        },
    },
    ["414038-0"] = { -- llandris thirandus
        {
            refId = "sc_almsiviintervention",
            count = 2,
        },
        {
            refId = "sc_daerirsmiracle",
            count = 5,
        },
        {
            refId = "sc_daydenespanacea",
            count = 5,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_vigor",
            count = 2,
        },
        {
            refId = "sc_firstbarrier",
            count = 2,
        },
        {
            refId = "sc_secondbarrier",
            count = 2,
        },
        {
            refId = "sc_celerity",
            count = 2,
        },
        {
            refId = "sc_heartwise",
            count = 2,
        },
        {
            refId = "sc_savagemight",
            count = 2,
        },
        {
            refId = "sc_argentglow",
            count = 1,
        },
    },
    ["241957-0"] = { -- ganalyn saram
        {
            refId = "ingred_corkbulb_root_01",
            count = 5,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 5,
        },
        {
            refId = "ingred_kwama_cuttle_01",
            count = 5,
        },
        {
            refId = "ingred_scales_01",
            count = 5,
        },
        {
            refId = "ingred_willow_anther_01",
            count = 5,
        },
        {
            refId = "ingred_bc_bungler's_bane",
            count = 5,
        },
        {
            refId = "ingred_bc_spore_pod",
            count = 5,
        },
    },
    ["201387-0"] = { -- elo arethan
        {
            refId = "random_book_imperial_hlaalu",
            count = 5,
        },
    },
    ["281754-0"] = { -- telvon llethan
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["218842-0"] = { -- j'rasha
        {
            refId = "ingred_ash_yam_01",
            count = 5,
        },
        {
            refId = "ingred_chokeweed_01",
            count = 5,
        },
        {
            refId = "food_kwama_egg_01",
            count = 5,
        },
        {
            refId = "ingred_marshmerrow_01",
            count = 5,
        },
        {
            refId = "ingred_scamp_skin_01",
            count = 3,
        },
        {
            refId = "ingred_saltrice_01",
            count = 5,
        },
        {
            refId = "ingred_scuttle_01",
            count = 5,
        },
    },
    ["218747-0"] = { -- jeanne
        {
            refId = "iron battle axe",
            count = 1,
        },
        {
            refId = "nordic battle axe",
            count = 1,
        },
        {
            refId = "steel battle axe",
            count = 1,
        },
        {
            refId = "chitin war axe",
            count = 1,
        },
        {
            refId = "iron war axe",
            count = 1,
        },
        {
            refId = "silver war axe",
            count = 1,
        },
        {
            refId = "steel axe",
            count = 1,
        },
        {
            refId = "steel war axe",
            count = 1,
        },
    },
    ["218883-0"] = { -- miun_gei
        {
            refId = "cruel flamestar",
            count = 20,
        },
        {
            refId = "sc_divineintervention",
            count = 2,
        },
        {
            refId = "sc_ondusisunhinging",
            count = 1,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_blackdeath",
            count = 1,
        },
        {
            refId = "sc_blackdespair",
            count = 1,
        },
        {
            refId = "sc_blackfate",
            count = 1,
        },
        {
            refId = "sc_blackmind",
            count = 1,
        },
        {
            refId = "sc_blackscorn",
            count = 1,
        },
        {
            refId = "sc_blacksloth",
            count = 1,
        },
        {
            refId = "sc_blackweakness",
            count = 1,
        },
        {
            refId = "sc_reddeath",
            count = 1,
        },
        {
            refId = "sc_reddespair",
            count = 1,
        },
        {
            refId = "sc_redfate",
            count = 1,
        },
        {
            refId = "sc_redmind",
            count = 1,
        },
        {
            refId = "sc_redscorn",
            count = 1,
        },
        {
            refId = "sc_redsloth",
            count = 1,
        },
        {
            refId = "sc_redweakness",
            count = 1,
        },
        {
            refId = "sc_restoration",
            count = 2,
        },
        {
            refId = "sc_tendilstrembling",
            count = 5,
        },
        {
            refId = "sc_tinurshoptoad",
            count = 5,
        },
    },
    ["201618-0"] = { -- rarvela teran
        {
            refId = "pick_apprentice_01",
            count = 2,
        },
        {
            refId = "torch",
            count = 3,
        },
        {
            refId = "probe_apprentice_01",
            count = 2,
        },
    },
    ["201620-0"] = { -- brathus dals
        {
            refId = "random_drinks_01",
            count = 10,
        },
        {
            refId = "random_food",
            count = 10,
        },
    },
    ["201622-0"] = { -- traldrisa tervayn
        {
            refId = "random_book_imperial_hlaalu",
            count = 3,
        },
    },
    ["201617-0"] = { -- gilan daynes
        {
            refId = "steel throwing knife",
            count = 50,
        },
        {
            refId = "iron throwing knife",
            count = 50,
        },
        {
            refId = "steel dagger",
            count = 1,
        },
        {
            refId = "iron dagger",
            count = 1,
        },
        {
            refId = "chitin dagger",
            count = 1,
        },
        {
            refId = "iron tanto",
            count = 1,
        },
        {
            refId = "steel tanto",
            count = 1,
        },
        {
            refId = "iron spider dagger",
            count = 1,
        },
        {
            refId = "steel spider blade",
            count = 1,
        },
        {
            refId = "repair_journeyman_01",
            count = 5,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
    },
    ["201621-0"] = { -- belos falos
        {
            refId = "pick_journeyman_01",
            count = 3,
        },
        {
            refId = "pick_apprentice_01",
            count = 5,
        },
        {
            refId = "probe_journeyman_01",
            count = 3,
        },
        {
            refId = "probe_apprentice_01",
            count = 5,
        },
    },
    ["399059-0"] = { -- ralen tilvur
        {
            refId = "chitin arrow",
            count = 50,
        },
        {
            refId = "chitin throwing star",
            count = 20,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
        {
            refId = "repair_prongs",
            count = 10,
        },
        {
            refId = "hammer_repair",
            count = 10,
        },
    },
    ["189001-0"] = { -- savard
        {
            refId = "steel bolt",
            count = 40,
        },
        {
            refId = "steel arrow",
            count = 150,
        },
        {
            refId = "steel throwing knife",
            count = 25,
        },
        {
            refId = "steel throwing star",
            count = 20,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["241814-0"] = { -- relms gilvilo
        {
            refId = "ingred_ash_salts_01",
            count = 5,
        },
        {
            refId = "ingred_black_lichen_01",
            count = 5,
        },
        {
            refId = "ingred_dreugh_wax_01",
            count = 5,
        },
        {
            refId = "ingred_fire_salts_01",
            count = 5,
        },
        {
            refId = "ingred_ghoul_heart_01",
            count = 1,
        },
        {
            refId = "ingred_roobrush_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jelly_01",
            count = 5,
        },
        {
            refId = "p_restore_health_s",
            count = 10,
        },
    },
    ["188930-0"] = { -- balen andrano
        {
            refId = "chitin spear",
            count = 1,
        },
        {
            refId = "iron halberd",
            count = 1,
        },
        {
            refId = "iron spear",
            count = 1,
        },
        {
            refId = "Iron Long Spear",
            count = 1,
        },
        {
            refId = "silver spear",
            count = 1,
        },
        {
            refId = "steel halberd",
            count = 1,
        },
        {
            refId = "steel spear",
            count = 1,
        },
    },
    ["241628-0"] = { -- vaval selas
        {
            refId = "ingred_rat_meat_01",
            count = 5,
        },
        {
            refId = "ingred_saltrice_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jerky_01",
            count = 5,
        },
        {
            refId = "ingred_gravedust_01",
            count = 5,
        },
        {
            refId = "ingred_bittergreen_petals_01",
            count = 5,
        },
        {
            refId = "ingred_chokeweed_01",
            count = 5,
        },
        {
            refId = "food_kwama_egg_01",
            count = 5,
        },
    },
    ["242026-0"] = { -- garas seloth
        {
            refId = "ingred_void_salts_01",
            count = 2,
        },
        {
            refId = "ingred_pearl_01",
            count = 2,
        },
        {
            refId = "ingred_wickwheat_01",
            count = 5,
        },
        {
            refId = "ingred_bonemeal_01",
            count = 5,
        },
        {
            refId = "ingred_daedra_skin_01",
            count = 2,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 5,
        },
        {
            refId = "ingred_racer_plumes_01",
            count = 5,
        },
    },
    ["204395-0"] = { -- galuro belan
        {
            refId = "ingred_ectoplasm_01",
            count = 3,
        },
        {
            refId = "ingred_kresh_fiber_01",
            count = 5,
        },
        {
            refId = "ingred_kagouti_hide_01",
            count = 5,
        },
        {
            refId = "ingred_scathecraw_01",
            count = 5,
        },
        {
            refId = "ingred_stoneflower_petals_01",
            count = 5,
        },
        {
            refId = "ingred_fire_petal_01",
            count = 5,
        },
    },
    ["204308-0"] = { -- audenian valius
        {
            refId = "sc_ondusisunhinging",
            count = 2,
        },
        {
            refId = "sc_fphyggisgemfeeder",
            count = 2,
        },
        {
            refId = "sc_summonskeletalservant",
            count = 2,
        },
        {
            refId = "sc_summonfrostatronach",
            count = 2,
        },
        {
            refId = "sc_summonflameatronach",
            count = 2,
        },
        {
            refId = "sc_taldamsscorcher",
            count = 5,
        },
        {
            refId = "sc_uthshandofheaven",
            count = 5,
        },
        {
            refId = "sc_sertisesporphyry",
            count = 5,
        },
        {
            refId = "sc_thirdbarrier",
            count = 5,
        },
        {
            refId = "sc_fourthbarrier",
            count = 2,
        },
        {
            refId = "sc_feldramstrepidation",
            count = 2,
        },
        {
            refId = "sc_mondensinstigator",
            count = 2,
        },
        {
            refId = "sc_llirosglowingeye",
            count = 5,
        },
        {
            refId = "random_scroll_all",
            count = 10,
        },
    },
    ["188619-0"] = { -- sorosi radobar
        {
            refId = "random_food",
            count = 15,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 10,
        },
        {
            refId = "potion_local_liquor_01",
            count = 10,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 10,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 10,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 5,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 5,
        },
    },
    ["203758-0"] = { -- manara othan
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "random_drinks_01",
            count = 4,
        },
        {
            refId = "potion_local_liquor_01",
            count = 6,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 6,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 6,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 6,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 4,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 4,
        },
    },
    ["200187-0"] = { -- burcanius varo
        {
            refId = "random_food",
            count = 10,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 3,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 3,
        },
    },
    ["283942-0"] = { -- eldrilu dalen
        {
            refId = "ingred_scrib_jerky_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jelly_01",
            count = 5,
        },
        {
            refId = "ingred_saltrice_01",
            count = 10,
        },
        {
            refId = "ingred_netch_leather_01",
            count = 10,
        },
        {
            refId = "ingred_guar_hide_01",
            count = 10,
        },
        {
            refId = "ingred_fire_salts_01",
            count = 5,
        },
        {
            refId = "ingred_corkbulb_root_01",
            count = 10,
        },
        {
            refId = "ingred_ash_yam_01",
            count = 5,
        },
        {
            refId = "ingred_ash_salts_01",
            count = 5,
        },
    },
    ["131351-0"] = { -- ababael timsar-dadisun
        {
            refId = "chitin arrow",
            count = 40,
        },
        {
            refId = "chitin throwing star",
            count = 30,
        },
        {
            refId = "random_armor_chitin",
            count = 5,
        },
        {
            refId = "random ashlander weapon",
            count = 5,
        },
        {
            refId = "random_scroll_all",
            count = 5,
        },
        {
            refId = "l_m_potion",
            count = 6,
        },
        {
            refId = "repair_master_01",
            count = 1,
        },
    },
    ["131665-0"] = { -- ashur-dan
        {
            refId = "chitin arrow",
            count = 20,
        },
        {
            refId = "chitin throwing star",
            count = 20,
        },
        {
            refId = "random_armor_chitin",
            count = 3,
        },
        {
            refId = "random ashlander weapon",
            count = 3,
        },
        {
            refId = "hammer_repair",
            count = 2,
        },
    },
    ["192882-0"] = { -- sonummu zabamat
        {
            refId = "p_cure_common_s",
            count = 1,
        },
        {
            refId = "p_disease_resistance_s",
            count = 1,
        },
        {
            refId = "p_restore_health_c",
            count = 2,
        },
        {
            refId = "p_restore_fatigue_s",
            count = 2,
        },
    },
    ["7437-0"] = { -- nerile andaren
        {
            refId = "p_cure_poison_s",
            count = 1,
        },
        {
            refId = "p_cure_common_s",
            count = 1,
        },
        {
            refId = "p_restore_fatigue_q",
            count = 5,
        },
        {
            refId = "p_restore_health_q",
            count = 5,
        },
        {
            refId = "p_restore_health_e",
            count = 3,
        },
        {
            refId = "p_restore_magicka_s",
            count = 5,
        },
    },
    ["25636-0"] = { -- galsa andrano
        {
            refId = "Ingred_horn_lily_bulb_01",
            count = 5,
        },
        {
            refId = "Ingred_nirthfly_stalks_01",
            count = 5,
        },
        {
            refId = "Ingred_sweetpulp_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jerky_01",
            count = 5,
        },
    },
    ["24254-0"] = { -- catia sosia
        {
            refId = "repair_master_01",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 15,
        },
        {
            refId = "repair_grandmaster_01",
            count = 3,
        },
        {
            refId = "repair_prongs",
            count = 15,
        },
    },
    ["25693-0"] = { -- elbert nermarc
        {
            refId = "l_m_enchantitem_redoran_rank8",
            count = 5,
        },
        {
            refId = "l_m_enchantitem_hlaalu_rank6",
            count = 5,
        },
        {
            refId = "l_m_enchantitem_telvanni_rank8",
            count = 5,
        },
        {
            refId = "l_m_enchantitem_temple_rank8_1",
            count = 2,
        },
        {
            refId = "l_m_enchantitem_temple_rank8_2",
            count = 2,
        },
        {
            refId = "random_scroll_all",
            count = 15,
        },
        {
            refId = "Misc_SoulGem_Grand",
            count = 5,
        },
        {
            refId = "Misc_SoulGem_Greater",
            count = 10,
        },
        {
            refId = "Misc_SoulGem_Common",
            count = 15,
        },
    },
    ["25691-0"] = { -- bols indalen
        {
            refId = "repair_grandmaster_01",
            count = 5,
        },
        {
            refId = "repair_master_01",
            count = 10,
        },
        {
            refId = "repair_journeyman_01",
            count = 15,
        },
    },
    ["24260-0"] = { -- daron
        {
            refId = "hammer_repair",
            count = 15,
        },
        {
            refId = "repair_journeyman_01",
            count = 10,
        },
    },
    ["16846-0"] = { -- mehra helas
        {
            refId = "ingred_netch_leather_01",
            count = 10,
        },
        {
            refId = "ingred_stoneflower_petals_01",
            count = 10,
        },
        {
            refId = "ingred_fire_petal_01",
            count = 5,
        },
        {
            refId = "ingred_hackle-lo_leaf_01",
            count = 5,
        },
        {
            refId = "ingred_ghoul_heart_01",
            count = 1,
        },
        {
            refId = "ingred_bloat_01",
            count = 10,
        },
        {
            refId = "ingred_dreugh_wax_01",
            count = 5,
        },
        {
            refId = "p_restore_fatigue_c",
            count = 2,
        },
        {
            refId = "p_restore_health_c",
            count = 5,
        },
        {
            refId = "p_restore_health_b",
            count = 5,
        },
    },
    ["18049-0"] = { -- ra'tesh
        {
            refId = "ingred_ash_yam_01",
            count = 5,
        },
        {
            refId = "ingred_bread_01",
            count = 5,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 5,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 5,
        },
        {
            refId = "ingred_scrib_jerky_01",
            count = 5,
        },
        {
            refId = "ingred_wickwheat_01",
            count = 5,
        },
        {
            refId = "ingred_saltrice_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 5,
        },
        {
            refId = "Potion_Cyro_Whiskey_01",
            count = 5,
        },
        {
            refId = "Potion_Local_Brew_01",
            count = 5,
        },
        {
            refId = "potion_local_liquor_01",
            count = 5,
        },
    },
    ["29547-0"] = { -- alcedonia amnis
        {
            refId = "ingred_bread_01",
            count = 10,
        },
        {
            refId = "ingred_crab_meat_01",
            count = 3,
        },
        {
            refId = "ingred_hound_meat_01",
            count = 3,
        },
        {
            refId = "potion_cyro_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_brandy_01",
            count = 5,
        },
        {
            refId = "potion_comberry_wine_01",
            count = 5,
        },
    },
    ["6-0"] = { -- aradraen
        {
            refId = "chitin throwing star",
            count = 20,
        },
        {
            refId = "cruel flamestar",
            count = 20,
        },
        {
            refId = "cruel shardstar",
            count = 20,
        },
        {
            refId = "cruel sparkstar",
            count = 20,
        },
        {
            refId = "cruel viperstar",
            count = 20,
        },
        {
            refId = "cruel_firestorm_star",
            count = 20,
        },
        {
            refId = "cruel_frostbloom_star",
            count = 20,
        },
        {
            refId = "cruel_poisonbloom_star",
            count = 20,
        },
        {
            refId = "cruel_shockbloom_star",
            count = 20,
        },
        {
            refId = "dire_firestorm_star",
            count = 20,
        },
        {
            refId = "dire_frostbloom_star",
            count = 20,
        },
        {
            refId = "dire_shockbloom_star",
            count = 20,
        },
        {
            refId = "dire_poisonbloom_star",
            count = 20,
        },
        {
            refId = "firebite star",
            count = 20,
        },
        {
            refId = "flamestar",
            count = 20,
        },
        {
            refId = "glass throwing star",
            count = 20,
        },
        {
            refId = "shardstar",
            count = 20,
        },
        {
            refId = "sparkstar",
            count = 20,
        },
        {
            refId = "viperstar",
            count = 20,
        },
        {
            refId = "steel throwing star",
            count = 20,
        },
        {
            refId = "corkbulb bolt",
            count = 50,
        },
        {
            refId = "iron bolt",
            count = 50,
        },
        {
            refId = "steel bolt",
            count = 50,
        },
        {
            refId = "silver bolt",
            count = 50,
        },
        {
            refId = "bonemold bolt",
            count = 50,
        },
        {
            refId = "orcish bolt",
            count = 50,
        },
        {
            refId = "flame_bolt",
            count = 50,
        },
        {
            refId = "shard_bolt",
            count = 50,
        },
        {
            refId = "spark_bolt",
            count = 50,
        },
        {
            refId = "viper_bolt",
            count = 50,
        },
        {
            refId = "cruel flame bolt",
            count = 50,
        },
        {
            refId = "cruel shard bolt",
            count = 50,
        },
        {
            refId = "cruel spark bolt",
            count = 50,
        },
        {
            refId = "cruel viper bolt",
            count = 50,
        },
        {
            refId = "dire flame bolt",
            count = 50,
        },
        {
            refId = "dire shard bolt",
            count = 50,
        },
        {
            refId = "dire spark bolt",
            count = 50,
        },
        {
            refId = "dire viper bolt",
            count = 50,
        },
        {
            refId = "cruel_firestorm_bolt",
            count = 50,
        },
        {
            refId = "cruel_frostbloom_bolt",
            count = 50,
        },
        {
            refId = "cruel_poisonbloom_bolt",
            count = 50,
        },
        {
            refId = "cruel_shockbloom_bolt",
            count = 50,
        },
        {
            refId = "dire_firestorm_bolt",
            count = 50,
        },
        {
            refId = "dire_frostbloom_bolt",
            count = 50,
        },
        {
            refId = "dire_poisonbloom_bolt",
            count = 50,
        },
        {
            refId = "dire_shockbloom_bolt",
            count = 50,
        },
        {
            refId = "dire flamearrow",
            count = 50,
        },
        {
            refId = "dire frostarrow",
            count = 50,
        },
        {
            refId = "dire shardarrow",
            count = 50,
        },
        {
            refId = "dire sparkarrow",
            count = 50,
        },
        {
            refId = "dire viperarrow",
            count = 50,
        },
        {
            refId = "dire_firestorm_arrow",
            count = 50,
        },
        {
            refId = "dire_frostbloom_arrow",
            count = 50,
        },
        {
            refId = "dire_poisonbloom_arrow",
            count = 50,
        },
        {
            refId = "dire_shockbloom_arrow",
            count = 50,
        },
        {
            refId = "dread_firestorm_arrow",
            count = 50,
        },
        {
            refId = "dread_frostbloom_arrow",
            count = 50,
        },
        {
            refId = "dread_poisonbloom_arrow",
            count = 50,
        },
        {
            refId = "dread_shockbloom_arrow",
            count = 50,
        },
        {
            refId = "iron arrow",
            count = 50,
        },
        {
            refId = "shard arrow",
            count = 50,
        },
        {
            refId = "silver arrow",
            count = 50,
        },
        {
            refId = "spark arrow",
            count = 50,
        },
        {
            refId = "steel arrow",
            count = 50,
        },
        {
            refId = "viper arrow",
            count = 50,
        },
        {
            refId = "glass throwing knife",
            count = 20,
        },
        {
            refId = "iron throwing knife",
            count = 20,
        },
        {
            refId = "steel throwing knife",
            count = 20,
        },
        {
            refId = "cruel_firestorm_dart",
            count = 20,
        },
        {
            refId = "cruel_frostbloom_dart",
            count = 20,
        },
        {
            refId = "cruel_poisonbloom_dart",
            count = 20,
        },
        {
            refId = "cruel_shockbloom_dart",
            count = 20,
        },
        {
            refId = "dire_firestorm_dart",
            count = 20,
        },
        {
            refId = "dire_frostbloom_dart",
            count = 20,
        },
        {
            refId = "dire_poisonbloom_dart",
            count = 20,
        },
        {
            refId = "dire_shockbloom_dart",
            count = 20,
        },
        {
            refId = "silver dart",
            count = 20,
        },
        {
            refId = "steel dart",
            count = 20,
        },
        {
            refId = "arrow of wasting flame",
            count = 50,
        },
        {
            refId = "arrow of wasting shard",
            count = 50,
        },
        {
            refId = "arrow of wasting spark",
            count = 50,
        },
        {
            refId = "arrow of wasting viper",
            count = 50,
        },
        {
            refId = "bonemold arrow",
            count = 50,
        },
        {
            refId = "chitin arrow",
            count = 50,
        },
        {
            refId = "corkbulb arrow",
            count = 50,
        },
        {
            refId = "cruel flamearrow",
            count = 50,
        },
        {
            refId = "cruel frostarrow",
            count = 50,
        },
        {
            refId = "cruel shardarrow",
            count = 50,
        },
        {
            refId = "cruel sparkarrow",
            count = 50,
        },
        {
            refId = "cruel viperarrow",
            count = 50,
        },
        {
            refId = "cruel_firestorm_arrow",
            count = 50,
        },
        {
            refId = "cruel_frostbloom_arrow",
            count = 50,
        },
        {
            refId = "cruel_poisonbloom_arrow",
            count = 50,
        },
        {
            refId = "cruel_shockbloom_arrow",
            count = 50,
        },
    },
}

local initialMerchantGoldTracking = {} -- Used below for tracking merchant uniqueIndexes and their goldPools.
local fixGoldPool = function(pid, cellDescription, uniqueIndex)

	if initialMerchantGoldTracking[uniqueIndex] ~= nil then

		local cell = LoadedCells[cellDescription]
		local objectData = cell.data.objectData
		if objectData[uniqueIndex] ~= nil and objectData[uniqueIndex].refId ~= nil then

			local currentGoldPool = objectData[uniqueIndex].goldPool

			if currentGoldPool ~= nil and currentGoldPool < initialMerchantGoldTracking[uniqueIndex] then

				tes3mp.ClearObjectList()
				tes3mp.SetObjectListPid(pid)
				tes3mp.SetObjectListCell(cellDescription)

				local lastGoldRestockHour = objectData[uniqueIndex].lastGoldRestockHour
				local lastGoldRestockDay = objectData[uniqueIndex].lastGoldRestockDay

				if lastGoldRestockHour == nil or lastGoldRestockDay == nil then
					objectData[uniqueIndex].lastGoldRestockHour = 0
					objectData[uniqueIndex].lastGoldRestockDay = 0
				end

				objectData[uniqueIndex].goldPool = initialMerchantGoldTracking[uniqueIndex]

				packetBuilder.AddObjectMiscellaneous(uniqueIndex, objectData[uniqueIndex])

				tes3mp.SendObjectMiscellaneous()

			end

		end

	end

end

local restockItems = function(pid, cellDescription, uniqueIndex)

    if itemsToRestock[uniqueIndex] ~= nil then

        local cell = LoadedCells[cellDescription]
        local objectData = cell.data.objectData
				local reloadInventory = false
				local itr = itemsToRestock[uniqueIndex]
				local currentInventory = objectData[uniqueIndex].inventory

        if objectData[uniqueIndex] ~= nil then

						for _, object in pairs(currentInventory) do
								for i, itemData in pairs(itr) do
										if object.refId == itr[i].refId then
												if object.count < itr[i].count then
														object.count = itr[i].count
														if not reloadInventory then reloadInventory = true end
												else
														itr[i].count = object.count
												end
										end
								end
						end

						for i, v in pairs(itr) do
								if not tableHelper.containsValue(currentInventory, itr[i].refId, true) then
										inventoryHelper.addItem(currentInventory, itr[i].refId, itr[i].count, itr[i].charge or -1, itr[i].enchantmentCharge or -1, itr[i].soul or "")
										if not reloadInventory then reloadInventory = true end
								end
						end

						if reloadInventory then
								--load container data for all pid's in the cell
								for i = 0, #Players do
										if Players[i] ~= nil and Players[i]:IsLoggedIn() then
												if Players[i].data.location.cell == cellDescription then
														cell:LoadContainers(i, cell.data.objectData, {uniqueIndex})
												end
										end
								end
						end

        end
    end
end

customEventHooks.registerValidator("OnObjectDialogueChoice", function(eventStatus, pid, cellDescription, objects)
	if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then

		for uniqueIndex, object in pairs(objects) do

			for _,refId in pairs(restockingGoldMerchants) do
				if object.refId == refId then
					if object.dialogueChoiceType == 3 then -- BARTER
						fixGoldPool(pid, cellDescription, uniqueIndex)
					end
				end
			end

			for i, merchantRefid in pairs(itemRestockingMerchants) do
				if itemRestockingMerchants[i] == object.refId then
					if object.dialogueChoiceType == 3 then -- BARTER
						restockItems(pid, cellDescription, uniqueIndex)
					end
				end
			end

		end
	end
end)

customEventHooks.registerValidator("OnObjectMiscellaneous", function(eventStatus, pid, cellDescription, objects)
	if Players[pid] ~= nil and Players[pid]:IsLoggedIn() then

		for uniqueIndex, object in pairs(objects) do

			if object.goldPool ~= nil and object.goldPool > 0 then
				for _,refId in pairs(restockingGoldMerchants) do
					if object.refId == refId then
						if initialMerchantGoldTracking[uniqueIndex] == nil then
							initialMerchantGoldTracking[uniqueIndex] = object.goldPool
						else
							fixGoldPool(pid, cellDescription, uniqueIndex)
						end
					end
				end
			end

    end
	end
end)

return customMerchantRestock
