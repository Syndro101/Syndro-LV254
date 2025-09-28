/obj/item/hardpoint/secondary/longstreet/towlauncher
	name = "\improper TOW Launcher"
	desc = "A rocket tube that shoots heavy anti-tank guided missiles, this one shoots TOW missiles."

	icon_state = "tow_launcher"
	disp_icon = "tank"
	disp_icon_state = "towlauncher"
	activation_sounds = list('sound/weapons/gun_rocketlauncher.ogg')

	health = 500
	firing_arc = 60
	point_cost = 800

	ammo = new /obj/item/ammo_magazine/hardpoint/secondary/longstreet/missile

	max_clips = 1

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/secondary/longstreet/missile,
		/obj/item/ammo_magazine/hardpoint/primary/jeep/missile
	)

	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	muzzle_flash_pos = list(
		"1" = list(8, -1),
		"2" = list(-8, -16),
		"4" = list(5, -8),
		"8" = list(-5, 10)
	)

	use_muzzle_flash = FALSE

	scatter = 4
	fire_delay = 15.0 SECONDS
