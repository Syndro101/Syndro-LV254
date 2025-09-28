/obj/item/hardpoint/secondary/longstreet/grenade_launcher
	name = "\improper M92T Grenade Launcher"
	desc = "A magazine fed secondary grenade launcher for tanks that shoots M40 grenades."

	icon_state = "glauncher"
	disp_icon = "tank"
	disp_icon_state = "glauncher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	health = 500
	firing_arc = 120
	point_cost = 500

	ammo = new /obj/item/ammo_magazine/hardpoint/secondary/longstreet/grenade
	max_clips = 3

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/secondary/longstreet/grenade,
		/obj/item/ammo_magazine/hardpoint/primary/jeep/grenade
	)

	use_muzzle_flash = FALSE

	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)

	scatter = 10
	fire_delay = 1.0 SECONDS

/obj/item/hardpoint/secondary/longstreet/grenade_launcher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/hardpoint/secondary/longstreet/grenade_launcher/try_fire(atom/target, mob/living/user, params)
	if(get_turf(target) in owner.locs)
		to_chat(user, SPAN_WARNING("The target is too close."))
		return NONE

	return ..()
