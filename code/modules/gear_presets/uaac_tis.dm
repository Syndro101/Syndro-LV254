/*****************************************************************************************************/
// UAAC-TIS, a collective intelligence agency creted during the UA's formation.
/*****************************************************************************************************/

/datum/equipment_preset/uaac/tis
	name = "UAAC-TIS"
	faction = FACTION_MARINE
	faction_group = FACTION_LIST_MARINE
	minimum_age = 25
	languages = list(LANGUAGE_ENGLISH)

	idtype = /obj/item/card/id/tis
	skills = /datum/skills/tis

/datum/equipment_preset/uaac/tis/New()
	. = ..()
	access = get_access(ACCESS_LIST_MARINE_ALL, ACCESS_TIS)

/************************************************/
/datum/equipment_preset/uaac/tis/es
	name = "UAAC-TIS Escort Officer"
	assignment = JOB_TIS_ES
	rank = JOB_TIS_ES

	paygrades = list(
					PAY_SHORT_NE4 = JOB_PLAYTIME_TIER_0,
					PAY_SHORT_NE5 = JOB_PLAYTIME_TIER_1,
					PAY_SHORT_NE6 = JOB_PLAYTIME_TIER_2,
					PAY_SHORT_NE7 = JOB_PLAYTIME_TIER_3
					)
	role_comm_title = "TIS-ES"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/uaac/tis/es/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel/sec
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/security

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/tis(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/ears/earmuffs/earplugs(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/uaac/tis/es(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/uaac/tis(new_human), WEAR_JACKET)
	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/uaac/tis(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/marsoc(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/mk1_heap(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full_advanced(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/tis(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m46c/tactical(new_human), WEAR_J_STORE)

	to_chat(new_human, SPAN_WARNING("You are an Escort Officer for UAAC-TIS, an intelligence agency with tremendous power. You are tasked with protecting your superiors and them alone, follow their orders. You are outside the normal USCM chain of command."))

/*****************************************************************************************************/
/datum/equipment_preset/uaac/tis/io
	name = "UAAC-TIS Intelligence Officer"
	skills = /datum/skills/tis

	assignment = JOB_TIS_IO
	rank = JOB_TIS_IO
	paygrades = list(
					PAY_SHORT_NO1 = JOB_PLAYTIME_TIER_0,
					PAY_SHORT_NO2 = JOB_PLAYTIME_TIER_1,
					)
	role_comm_title = "TIS-IO"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/uaac/tis/io/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel/lockable
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/satchel/lockable

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/tis(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/ears/earmuffs/earplugs(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/uaac/tis(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/dress(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/webbing(new_human), WEAR_JACKET)
	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/document(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/tis(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder(new_human), WEAR_IN_R_STORE)

	to_chat(new_human, SPAN_WARNING("You are an Intelligence Officer for UAAC-TIS, an intelligence agency with tremendous power. You are tasked with retrieving or transporting sensitive materials to and from a location, you may also be involved in sensative operations. You are outside the normal USCM chain of command."))


/*****************************************************************************************************/
/datum/equipment_preset/uaac/tis/sio
	name = "UAAC-TIS Senior Intelligence Officer"
	minimum_age = 27

	assignment = JOB_TIS_SIO
	rank = JOB_TIS_SIO
	paygrades = list(PAY_SHORT_NO3 = JOB_PLAYTIME_TIER_0,)
	role_comm_title = "TIS-SIO"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/uaac/tis/sio/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel/lockable
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/satchel/lockable

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/tis(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/ears/earmuffs/earplugs(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/uaac/tis/senior(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/dress(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/commander(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/webbing(new_human), WEAR_JACKET)
	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/uaac/tis(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/document(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/tis(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/portable_vendor/antag/tis(new_human), WEAR_IN_BACK)

	to_chat(new_human, SPAN_WARNING("You are a Senior Intelligence Officer for UAAC-TIS, an intelligence agency with tremendous power. You are tasked with retrieving or transporting sensitive materials to and from a location, you may also be involved in sensative operations. You are outside the normal USCM chain of command."))

/*****************************************************************************************************/
/datum/equipment_preset/uaac/tis/sa
	name = "UAAC-TIS Special Agent"
	minimum_age = 30
	skills = /datum/skills/tiscomm
	languages = ALL_HUMAN_LANGUAGES // Know thy enemy.

	assignment = JOB_TIS_SA
	rank = JOB_TIS_SA
	paygrades = list(
					PAY_SHORT_NO4 = JOB_PLAYTIME_TIER_0,
					PAY_SHORT_NO5 = JOB_PLAYTIME_TIER_1,
					PAY_SHORT_NO6 = JOB_PLAYTIME_TIER_2
					)
	role_comm_title = "TIS-SA"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/uaac/tis/sa/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel/lockable
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/satchel/lockable

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/tis(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/ears/earmuffs/earplugs(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/uaac/tis/agent(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/mateba/council/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/uaac/tis/sa(new_human), WEAR_JACKET)
	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/uaac/tis(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol/large/mateba/impact(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/tis(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/mateba_case/captain/council(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular/response(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/portable_vendor/antag/tis(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder(new_human), WEAR_IN_R_STORE)

	to_chat(new_human, SPAN_WARNING("You are a Special Agent for UAAC-TIS, an intelligence agency with tremendous power. You are tasked with investigating sensitive operations and resolving them carefully, you possess a large amount of authority and and may seize UAAC assets to aid in your assigned objectives. You are outside the normal USCM chain of command."))

/*****************************************************************************************************/
/datum/equipment_preset/uaac/tis/co
	name = "UAAC-TIS Coordinator"
	minimum_age = 40
	skills = /datum/skills/tiscomm
	languages = ALL_HUMAN_LANGUAGES // Know thy enemy.

	assignment = JOB_TIS_CO
	rank = JOB_TIS_CO
	paygrades = list(
					PAY_SHORT_NO6E = JOB_PLAYTIME_TIER_0,
					PAY_SHORT_NO6C = JOB_PLAYTIME_TIER_2,
					)
	role_comm_title = "TIS-CO"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/uaac/tis/co/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/satchel/lockable
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/satchel/lockable

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/tis/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/ears/earmuffs/earplugs(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/uaac/tis/co(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/dress/commander(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/mateba/general/impact(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/bomber/armored(new_human), WEAR_JACKET)
	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/hidden(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/uaac/tis/co(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol/large/mateba/impact(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/health/ceramic_plate(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/tis(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/mateba_case/general(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular/response(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/portable_vendor/antag/tis(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder(new_human), WEAR_IN_R_STORE)

	to_chat(new_human, SPAN_WARNING("You are a Coordinator for UAAC-TIS, an intelligence agency with tremendous power. You maintain entire intelligence networks and ensure their smooth running, you possess an extreme amount of authority and will generally outrank anyone in your AO. You are generally not supposed to get involved personally in operations but are allowed if deemed important enough. You are outside the normal USCM chain of command."))
/*****************************************************************************************************/
//----------------------------------------UAAC-OWLF----------------------------------------//
/*****************************************************************************************************/
/datum/equipment_preset/uaac/tis/owlf
	name = "UAAC-OWLF Investigative Agent"
	minimum_age = 30
	skills = /datum/skills/tiscomm
	languages = ALL_HUMAN_LANGUAGES // Know thy enemy.

	assignment = JOB_OWLF_IA
	rank = JOB_OWLF_IA
	paygrades = list(
					PAY_SHORT_NO4 = JOB_PLAYTIME_TIER_0,
					PAY_SHORT_NO5 = JOB_PLAYTIME_TIER_1,
					PAY_SHORT_NO6 = JOB_PLAYTIME_TIER_2
					)
	role_comm_title = "OWLF-IA"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/uaac/tis/owlf/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/scout_cloak

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/tis(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/ears/earmuffs/earplugs(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/owlf(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/uaac/tis/owlf(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/thermal/owlf(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/owlf_mask(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m4ra1(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/socmed/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/explosive/owlf(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/tis(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/ua(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/owlf_vest(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/portable_vendor/antag/owlf(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m4ra1_custom/tactical(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator/scout(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector/intel(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/owlf(new_human), WEAR_IN_BACK)

	to_chat(new_human, SPAN_WARNING("You are an Investigative Agent for the OWLF, a special program under the powerful TIS intelligence agency. You are tasked with investigating and eliminating otherworldly or high-value targets, usually recovering the body or important materials in the process. You possess a large amount of authority and and may seize UAAC assets to aid in your assigned objectives. You are outside the normal USCM chain of command and only answer to TIS Coordinators."))
