/obj/item/hardpoint/primary/lav/plasma
	name = "\improper PARS 20mW Plasma Cannon"
	desc = "An experimental 20mW plasma cannon used for taking out heavy armor, stand infront for an instant tan."
	icon = 'icons/obj/vehicles/hardpoints/lav.dmi'

	icon_state = "plasma"
	disp_icon = "lav"
	disp_icon_state = "plasma"
	activation_sounds = list('sound/weapons/pred_plasmacaster_fire.ogg')

	damage_multiplier = 0.15

	health = 500
	firing_arc = 90
	point_cost = 800

	origins = list(0, 1)

	ammo = new /obj/item/ammo_magazine/hardpoint/primary/lav/plasma

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/primary/lav/plasma
	)

	max_clips = 1

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_energy"

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
	fire_delay = 5 SECONDS
