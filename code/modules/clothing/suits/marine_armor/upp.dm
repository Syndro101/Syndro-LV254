//===========================//U.P.P\\================================\\
//=====================================================================\\

/obj/item/clothing/suit/storage/marine/upp
	name = "\improper U5-M personal armor"
	desc = "Standard body armor of the UPP military, the U5-M (Union MK5 - Medium) is a medium body armor, roughly on par with the M3 pattern body armor in service with the USCM, specialized towards ballistics protection. Unlike the M3, however, the plate has a heavier neckplate. This has earned many UA members to refer to UPP soldiers as 'tin men'."
	icon = 'icons/obj/items/clothing/suits/suits_by_faction/upp_grayscale.dmi'
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/clothing/suits/suits_by_map/upp_grayscale.dmi'
	)
	icon_state = "M1"
	flags_atom = NO_NAME_OVERRIDE
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS|BODY_FLAG_GROIN
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_ARMS|BODY_FLAG_GROIN
	min_cold_protection_temperature = HELMET_MIN_COLD_PROT
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROT
	blood_overlay_type = "armor"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_VERYHIGH
	armor_laser = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	movement_compensation = SLOWDOWN_ARMOR_LIGHT
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP)

// Light
/obj/item/clothing/suit/storage/marine/upp/light
	name = "\improper U5-L personal armor"
	desc = "The U5-L (Union MK5 - Light) is a lightweight version of the U5-M, designed for enhanced mobility and is commonly used by shipside staff or vehicle crews."
	icon_state = "L1"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_LOW
	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/storage/marine/upp/heavy/Initialize()
	. = ..()
	pockets.bypass_w_limit = list(
		/obj/item/ammo_magazine/minigun,
		/obj/item/ammo_magazine/pkp,
		)

// MP
/obj/item/clothing/suit/storage/marine/upp/mp
	flags_atom = NO_GAMEMODE_SKIN
	color = CAMO_BLACK

// Leader
/obj/item/clothing/suit/storage/marine/upp/leader
	name = "\improper U6-M personal armor"
	desc = "Standard body armor of UPP leadership and less expendable troops, the U6-M (Union MK6 - Medium) features a more segmented design to the older U5-M, allowing for greater mobility without loss of protection."
	icon_state = "M3"
	storage_slots = 5
	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/storage/marine/upp/leader/leytenant
	desc = "Standard body armor of UPP leadership and less expendable troops, the U6-M (Union MK6 - Medium) features a more segmented design to the older U5-M, allowing for greater mobility without loss of protection. This set has silver markings, hopefully denoting the wearer as a UPP Leytenant."
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP/officer)

/obj/item/clothing/suit/storage/marine/upp/leader/kapitan
	desc = "Standard body armor of UPP leadership and less expendable troops, the U6-M (Union MK6 - Medium) features a more segmented design to the older U5-M, allowing for greater mobility without loss of protection. This set has gold markings, hopefully denoting the wearer as a UPP Kapitan."
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP/officer)

/obj/item/clothing/suit/storage/marine/upp/leader/komandir
	desc = "Standard body armor of UPP leadership and less expendable troops, the U6-M (Union MK6 - Medium) features a more segmented design to the older U5-M, allowing for greater mobility without loss of protection. This set has platinum markings, hopefully denoting the wearer as a UPP Komandir."
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP/officer)

//===========================//SPECIALIST\\================================\\
//=========================================================================\\

// Scout + Sniper
/obj/item/clothing/suit/storage/marine/upp/scout
	name = "\improper U6-R personal armor"
	desc = "The U6-R (Union MK6 - Recon) is a specialized version of the Chinese-styled UPP armor rigged to use the V86 Thermal Cloak or V77 Sniper Smock. While less protective than heavier variants, its extremely light weight makes it ideal for reconnaissance."
	icon_state = "scout"
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_GROIN
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_GROIN
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_LEGS|BODY_FLAG_GROIN
	slowdown = SLOWDOWN_ARMOR_LIGHT

// Gunner
/obj/item/clothing/suit/storage/marine/upp/gunner
	name = "\improper U5-H personal armor"
	desc = "The U5-H (Union MK5 - Heavy) is an extreme modification of the standard U5-M, known for having powerful ballistic protection. The suit covers nearly the entire body and is popular among UPP Heavy Gunners."
	icon_state = "gunner"
	storage_slots = 3
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	flags_armor_protection = BODY_FLAG_ALL_BUT_HEAD
	flags_cold_protection = BODY_FLAG_ALL_BUT_HEAD
	flags_heat_protection = BODY_FLAG_ALL_BUT_HEAD
	armor_melee = CLOTHING_ARMOR_ULTRAHIGH
	armor_bullet = CLOTHING_ARMOR_GIGAHIGH
	armor_internaldamage = CLOTHING_ARMOR_VERYHIGHPLUS
	slowdown = SLOWDOWN_ARMOR_HEAVY

// Pyro
/obj/item/clothing/suit/storage/marine/upp/pyro
	name = "\improper U6-P personal armor"
	desc = "The U6-P (Union MK6 - Pyrotech) is a specialized version of the Chinese-styled UPP armor rigged to use the V32 Flame System, under the armor sits a thick insulating suit to keep flames at bay."
	icon_state = "pyro"
	flags_armor_protection = BODY_FLAG_ALL_BUT_HEAD
	flags_cold_protection = BODY_FLAG_ALL_BUT_HEAD
	flags_heat_protection = BODY_FLAG_ALL_BUT_HEAD
	armor_bio = CLOTHING_ARMOR_HIGH
	fire_intensity_resistance = BURN_LEVEL_TIER_1
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROT

// Grenadier
/obj/item/clothing/suit/storage/marine/upp/grenadier
	name = "\improper U6-G personal armor"
	desc = "The U6-G (Union MK6 - Grenadier) is a variant of the German-styled UPP armor, packed to the brim with padding to dampen explosive impacts."
	icon_state = "grenadier"
	flags_armor_protection = BODY_FLAG_ALL_BUT_HEAD
	flags_cold_protection = BODY_FLAG_ALL_BUT_HEAD
	flags_heat_protection = BODY_FLAG_ALL_BUT_HEAD
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_internaldamage = CLOTHING_ARMOR_VERYHIGH

// Demo
/obj/item/clothing/suit/storage/marine/upp/demo
	name = "\improper U6-D personal armor"
	desc = "The U6-D (Union MK6 - Demolition) is a lightened variant of the German-styled UPP armor, used by UPP demolitionists to carry their gear."
	icon_state = "demo"
	slowdown = SLOWDOWN_ARMOR_LIGHT

//===========================//Officer Jackets\\================================\\
//==============================================================================\\

/obj/item/clothing/suit/storage/marine/upp/officer
	name = "\improper UL4 officer jacket"
	desc = "A lightweight jacket, issued to officers of the UPP's military. Slightly protective from incoming damage, best off with proper armor however."
	icon_state = "coat_officer"
	slowdown = SLOWDOWN_ARMOR_NONE
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	armor_melee = CLOTHING_ARMOR_LOW //wear actual armor if you go into combat
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP/officer)

/obj/item/clothing/suit/storage/marine/upp/kapitan
	name = "\improper UL4 senior officer jacket"
	desc = "A lightweight jacket, issued to senior officers of the UPP's military. Made of high-quality materials, even going as far as having the ranks and insignia of the Kapitan and their Company emblazoned on the shoulders and front of the jacket. Slightly protective from incoming damage, best off with proper armor however."
	icon_state = "upp_coat_kapitan"
	slowdown = SLOWDOWN_ARMOR_NONE
	armor_melee = CLOTHING_ARMOR_LOW //wear actual armor if you go into combat
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS
	uniform_restricted = list(/obj/item/clothing/under/marine/veteran/UPP/officer)
