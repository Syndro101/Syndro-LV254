/obj/item/hardpoint/primary/jeep/grenade_launcher
	icon = 'icons/obj/vehicles/hardpoints/jeep.dmi'

	name = "\improper FRA9-V Grenade Launcher"
	desc = "A magazine-fed grenade launcher that shoots M40 grenades, this one is for a jeep."

	icon_state = "jeep_gl"
	disp_icon = "jeep"
	disp_icon_state = "jeep_gl"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	health = 500
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/primary/jeep/grenade
	max_clips = 3
	point_cost = 500

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/primary/jeep/grenade,
		/obj/item/ammo_magazine/hardpoint/secondary/longstreet/grenade
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

/obj/item/hardpoint/primary/jeep/grenade_launcher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/hardpoint/primary/jeep/grenade_launcher/try_fire(atom/target, mob/living/user, params)
	if(get_turf(target) in owner.locs)
		to_chat(user, SPAN_WARNING("The target is too close."))
		return NONE

	return ..()

/obj/item/hardpoint/primary/jeep/grenade_launcher/riot
	name = "\improper R10T Dispersal System"
	desc = "A magazine-fed grenade launcher that shoots M66 Teargas grenades and HIRR Baton Slugs, this one is for a jeep."

	icon_state = "jeep_riot"
	disp_icon = "jeep"
	disp_icon_state = "jeep_riot"
	fire_delay = 1.0 SECONDS

	ammo = new /obj/item/ammo_magazine/hardpoint/primary/jeep/grenade/teargas
	max_clips = 1
	point_cost = 400

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/primary/jeep/grenade/teargas
	)

/obj/item/hardpoint/secondary/grenade_launcher/jeep/riot/set_bullet_traits()
	return
