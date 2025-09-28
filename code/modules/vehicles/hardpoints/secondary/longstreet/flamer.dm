/obj/item/hardpoint/secondary/longstreet/small_flamer
	name = "\improper LZR-N Flamer Unit"
	desc = "A secondary weapon for tanks that spews hot fire."

	icon_state = "flamer"
	disp_icon = "tank"
	disp_icon_state = "flamer"
	activation_sounds = list('sound/weapons/vehicles/flamethrower.ogg')

	health = 300
	firing_arc = 120
	point_cost = 400

	ammo = new /obj/item/ammo_magazine/hardpoint/secondary/longstreet/flamer
	max_clips = 1

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hardpoint/secondary/longstreet/flamer,
		/obj/item/ammo_magazine/hardpoint/primary/jeep/flamer
	)

	use_muzzle_flash = FALSE

	var/max_range = 14

	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	scatter = 6
	fire_delay = 1 SECONDS

/obj/item/hardpoint/secondary/longstreet/small_flamer/try_fire(atom/target, mob/living/user, params)
	if(get_turf(target) in owner.locs)
		to_chat(user, SPAN_WARNING("The target is too close."))
		return NONE

	return ..()

/obj/item/hardpoint/secondary/longstreet/small_flamer/handle_fire(atom/target, mob/living/user, params)
	//step forward along path so flame starts outside hull
	var/list/turfs = get_line(get_origin_turf(), get_turf(target))
	var/turf/origin_turf
	for(var/turf/turf as anything in turfs)
		if(turf in owner.locs)
			continue
		origin_turf = turf
		break

	var/distance = get_dist(origin_turf, get_turf(target))
	var/fire_amount = min(ammo.current_rounds, distance+1, max_range)
	ammo.current_rounds -= fire_amount

	new /obj/flamer_fire(origin_turf, create_cause_data(initial(name), user), null, fire_amount, null, FLAMESHAPE_LINE, target)

	play_firing_sounds()

	COOLDOWN_START(src, fire_cooldown, fire_delay)

	return AUTOFIRE_CONTINUE
