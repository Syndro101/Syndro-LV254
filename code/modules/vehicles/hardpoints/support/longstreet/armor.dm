// Ballistic

/obj/item/hardpoint/support/longstreet/ballistic
	name = "\improper Ballistic Armor"
	desc = "Protects the vehicle from high-penetration weapons"

	slot = HDPT_ARMOR
	point_cost = 400

	icon_state = "ballistic_armor"
	disp_icon = "tank"
	disp_icon_state = "ballistic_armor"

	type_multipliers = list(
		"bullet" = 0.7,
		"slash" = 0.7,
		"all" = 0.9
	)

// Caustic

/obj/item/hardpoint/support/longstreet/caustic
	name = "\improper Caustic Armor"
	desc = "Protects vehicles from most types of acid"

	slot = HDPT_ARMOR
	point_cost = 400

	icon_state = "caustic_armor"
	disp_icon = "tank"
	disp_icon_state = "caustic_armor"

	type_multipliers = list(
		"acid" = 0.7,
		"all" = 0.9
	)

// Concussive

/obj/item/hardpoint/support/longstreet/concussive
	name = "\improper Concussive Armor"
	desc = "Protects the vehicle from large incoming explosive and high-impact projectiles"

	slot = HDPT_ARMOR
	point_cost = 400

	icon_state = "concussive_armor"
	disp_icon = "tank"
	disp_icon_state = "concussive_armor"

	type_multipliers = list(
		"explosive" = 0.7,
		"blunt" = 0.7,
		"all" = 0.9
	)

// Plow

/obj/item/hardpoint/support/longstreet/snowplow
	name = "\improper Snowplow"
	desc = "Clears a path in the snow for friendlies. It doesn't seem to have much use beyond that."

	icon_state = "snowplow"
	disp_icon = "tank"
	disp_icon_state = "snowplow"

	activatable = 1
	point_cost = 400

/obj/item/hardpoint/support/longstreet/snowplow/livingmob_interact(mob/living/M)
	var/turf/targ = get_step(M, owner.dir)
	targ = get_step(M, owner.dir)
	targ = get_step(M, owner.dir)
	M.throw_atom(targ, 4, SPEED_FAST, src, 1)
	M.apply_damage(7 + rand(0, 3), BRUTE)

/obj/item/hardpoint/support/longstreet/snowplow/on_move(turf/old, turf/new_turf, move_dir)
	if(health <= 0)
		return

	if(dir != move_dir)
		return

	var/turf/ahead = get_step(new_turf, move_dir)

	var/list/turfs_ahead = list(ahead, get_step(ahead, turn(move_dir, 90)), get_step(ahead, turn(move_dir, -90)))
	for(var/turf/T in turfs_ahead)
		if(istype(T, /turf/open/snow))
			var/turf/open/snow/ST = T
			if(!ST || !ST.bleed_layer)
				continue
			new /obj/item/stack/snow(ST, ST.bleed_layer)
			ST.bleed_layer = 0
			ST.update_icon(1, 0)
		else if(istype(T, /turf/open/auto_turf/snow))
			var/turf/open/auto_turf/snow/S = T
			if(!S || !S.bleed_layer)
				continue
			new /obj/item/stack/snow(S, S.bleed_layer)
			S.changing_layer(0)
		else
			continue
