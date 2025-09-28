/obj/item/hardpoint/primary/lav/chaingun
	name = "\improper PARS 40/70 Boyars Chaingun"
	desc = "A devastating automatic chain-driven cannon for the LAV that shoots 40mm rounds, not IFF-Friendly, ouch."
	icon = 'icons/obj/vehicles/hardpoints/lav.dmi'

	icon_state = "chaingun"
	disp_icon = "lav"
	disp_icon_state = "chaingun"
	activation_sounds = list('sound/weapons/vehicles/autocannon_fire.ogg')

	damage_multiplier = 0.15

	health = 500
	firing_arc = 90
	point_cost = 600

	origins = list(0, 1)

	ammo = new /obj/item/ammo_magazine/hardpoint/primary/lav/chaingun

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/primary/lav/chaingun,
		/obj/item/ammo_magazine/hardpoint/primary/lav/chaingun/ap,
		/obj/item/ammo_magazine/hardpoint/primary/lav/chaingun/he
	)

	max_clips = 1

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(0, 30),
		"2" = list(0, -61),
		"4" = list(45, -16),
		"8" = list(-45, -16)
	)

	scatter = 1
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.6 SECONDS
