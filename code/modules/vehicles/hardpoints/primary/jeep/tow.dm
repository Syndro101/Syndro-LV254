/obj/item/hardpoint/primary/jeep/towlauncher
	icon = 'icons/obj/vehicles/hardpoints/jeep.dmi'

	name = "\improper TOW Launcher"
	desc = "A rocket tube that shoots heavy anti-tank guided missiles, this one shoots TOW missiles."

	icon_state = "jeep_tow"
	disp_icon = "jeep"
	disp_icon_state = "jeep_tow"
	activation_sounds = list('sound/weapons/gun_rocketlauncher.ogg')

	health = 500
	firing_arc = 60

	ammo = new /obj/item/ammo_magazine/hardpoint/primary/jeep/missile
	max_clips = 1
	point_cost = 800

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/primary/jeep/missile,
		/obj/item/ammo_magazine/hardpoint/secondary/longstreet/missile
	)

	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash_backwards"

	muzzle_flash_pos = list(
		"1" = list(-12, 50),
		"2" = list(-20, -10),
		"4" = list(-35, -35),
		"8" = list(10, -32)
	)

	scatter = 4
	fire_delay = 15.0 SECONDS
