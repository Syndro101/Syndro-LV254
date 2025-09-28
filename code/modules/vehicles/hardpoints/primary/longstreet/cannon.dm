/obj/item/hardpoint/primary/longstreet/cannon
	name = "\improper LTB Cannon"
	desc = "A 80mm cannon for the M34A2 Longstreet tank, you know what to do with it."

	icon_state = "ltb_cannon"
	disp_icon = "tank"
	disp_icon_state = "ltb_cannon"
	activation_sounds = list('sound/weapons/vehicles/cannon_fire1.ogg', 'sound/weapons/vehicles/cannon_fire2.ogg')

	health = 500
	firing_arc = 60
	point_cost = 800

	ammo = new /obj/item/ammo_magazine/hardpoint/primary/longstreet/he
	max_clips = 2

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/primary/longstreet/he,
		/obj/item/ammo_magazine/hardpoint/primary/longstreet/ap
	)

	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	muzzle_flash_pos = list(
		"1" = list(0, 59),
		"2" = list(0, -74),
		"4" = list(89, -4),
		"8" = list(-89, -4)
	)

	scatter = 2
	fire_delay = 9.0 SECONDS
