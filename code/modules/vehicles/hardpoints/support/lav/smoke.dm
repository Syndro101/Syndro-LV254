/obj/item/hardpoint/support/lav/smoke_launcher
	name = "\improper M-90L Smoke Launcher"
	desc = "A support module for LAVs that shoots smoke grenades."
	icon = 'icons/obj/vehicles/hardpoints/lav.dmi'

	icon_state = "smoke_launcher_0"
	disp_icon = "lav"
	disp_icon_state = "smoke_launcher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	damage_multiplier = 0.1

	activatable = TRUE

	health = 500
	firing_arc = 360
	point_cost = 200

	ammo = new /obj/item/ammo_magazine/hardpoint/secondary/lav/smoke
	max_clips = 2

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/secondary/lav/smoke,
	)

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_laser"

	muzzle_flash_pos = list(
		"1" = list(12, -50),
		"2" = list(-10, 24),
		"4" = list(-40, -24),
		"8" = list(40, -4)
	)

	scatter = 3
	fire_delay = 3.0 SECONDS

/obj/item/hardpoint/support/lav/smoke_launcher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))
