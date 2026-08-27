// =========================
// CAMO COLOR DEFINES
// =========================

// USCM
#define CAMO_JUNGLE "#9ca779"
#define CAMO_DESERT "#d3b893"
#define CAMO_SNOW   "#e4e4e4"
#define CAMO_URBAN  "#999e95"

// MARSOC
#define JUNGLE_MARSOC "#9ca779a1"
#define DESERT_MARSOC "#d3b893a1"
#define SNOW_MARSOC   "#e4e4e4a1"
#define URBAN_MARSOC  "#999e95a1"

// UPP
#define JUNGLE_UPP "#9ca779d5"
#define DESERT_UPP "#d3b893d5"
#define SNOW_UPP   "#e4e4e4d5"
#define URBAN_UPP  "#999e95d5"

// COLORS
#define CAMO_BLACK  "#505050"
#define CAMO_BROWN  "#968265"
#define CAMO_RED    "#7C2F2F"
#define CAMO_BLUE   "#4A638C"
#define CAMO_GOLD   "#B08A33"
#define CAMO_SILVER "#C6C6C6"

// Returns a hex color or null (to clear tint)
// Global proc
/proc/camo_hex_for_type(camo_type)
	if(!camo_type)
		return null

	var/key = lowertext("[camo_type]")
	var/static/list/_camo_map = list(
		"jungle" = CAMO_JUNGLE,
		"desert" = CAMO_DESERT,
		"snow"   = CAMO_SNOW,
		"urban"  = CAMO_URBAN,
		"black"  = CAMO_BLACK,
		"brown"  = CAMO_BROWN,
		"red"    = CAMO_RED,
		"blue"   = CAMO_BLUE,
		"gold"   = CAMO_GOLD,
		"silver" = CAMO_SILVER,
		"classic" = null
	)

	return _camo_map[key]

/obj/item/proc/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	if(type != expected_type)
		return FALSE
	if(flags_atom & NO_GAMEMODE_SKIN)
		return FALSE

	var/map_name = SSmapping.configs[GROUND_MAP].map_name
	var/camo_type = SSmapping.configs[GROUND_MAP].camouflage_type

	var/new_icon_state
	var/new_protection

	if(LAZYLEN(override_icon_state))
		new_icon_state = override_icon_state[map_name]
	if(LAZYLEN(override_protection))
		new_protection = override_protection[map_name]

	// Apply overrides if present (no more prefixing)
	if(!isnull(new_icon_state))
		icon_state = new_icon_state
		item_state = new_icon_state // keep them in sync unless your item_state differs

	if(!isnull(new_protection))
		min_cold_protection_temperature = new_protection

	// Tint item and on-mob appearances from grayscale using hex
	// If classic (or unknown), clear tint to keep base art
	var/camo_hex = camo_hex_for_type(camo_type)
	color = camo_hex // BYOND accepts "#RRGGBB" or null to clear

	// Unified grayscale inhand icons; overlays will inherit this.color
	if(!item_icons)
		item_icons = list()

	// Ensure these two grayscale files exist and contain the base grayscale hands
	item_icons[WEAR_L_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/grayscale_lefthand.dmi'
	item_icons[WEAR_R_HAND] = 'icons/mob/humans/onmob/inhands/items_by_map/grayscale_righthand.dmi'

	return TRUE
