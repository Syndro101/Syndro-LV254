/obj/item/hardpoint/support
	name = "support hardpoint"
	desc = "Support module, providing passive buffs and active abilities"

	// Default
	slot = HDPT_SUPPORT
	hdpt_layer = HDPT_LAYER_SUPPORT
	damage_multiplier = 0.075

	// Locomotion
	var/acid_resistant = FALSE
	var/move_delay = 0
	var/move_max_momentum = 0
	var/move_momentum_build_factor = 0
	var/move_turn_momentum_loss_factor = 0

	// Turret
	var/list/accepted_hardpoints
	var/list/hardpoints

/obj/item/hardpoint/support/Initialize()
	. = ..()
	if(is_locomotion())
		hdpt_layer = HDPT_LAYER_WHEELS
		gender = PLURAL
		damage_multiplier = 0.15
		if(!move_delay)
			move_delay = VEHICLE_SPEED_FASTNORMAL
	if(is_turret())
		hdpt_layer = HDPT_LAYER_TURRET
		hardpoints = list()
		if(!accepted_hardpoints)
			accepted_hardpoints = list()
	if(is_armor())
		hdpt_layer = HDPT_LAYER_ARMOR
		if(damage_multiplier == initial(damage_multiplier))
			damage_multiplier = 0.5
		if(health == initial(health))
			health = 1000

//-------------------------------------------------------------------------------//
//---------------------------------- Shared -------------------------------------//
//-------------------------------------------------------------------------------//

/obj/item/hardpoint/support/proc/is_locomotion()
	return (slot == HDPT_WHEELS || slot == HDPT_TREADS)

/obj/item/hardpoint/support/proc/is_turret()
	return (slot == HDPT_TURRET)

/obj/item/hardpoint/support/proc/is_armor()
	return (slot == HDPT_ARMOR)

//-------------------------------------------------------------------------------//
//-------------------------------- Locomotion -----------------------------------//
//-------------------------------------------------------------------------------//

/obj/item/hardpoint/support/proc/loco_are(temp_gender)
	if(!is_locomotion())
		return "is"
	if(!temp_gender)
		temp_gender = gender
	return (temp_gender == PLURAL) ? "are" : "is"

/obj/item/hardpoint/support/proc/loco_they(capitalized, temp_gender)
	if(!is_locomotion())
		return capitalized ? "It" : "it"
	if(!temp_gender)
		temp_gender = gender
	var/txt = (temp_gender == PLURAL) ? "they" : "it"
	return capitalized ? capitalize(txt) : txt

/obj/item/hardpoint/support/proc/loco_deactivate()
	if(!is_locomotion())
		return
	if(owner)
		owner.move_delay = initial(owner.move_delay)
		owner.move_max_momentum = initial(owner.move_max_momentum)
		owner.move_momentum_build_factor = initial(owner.move_momentum_build_factor)
		owner.move_turn_momentum_loss_factor = initial(owner.move_turn_momentum_loss_factor)
		owner.next_move = world.time + move_delay

/obj/item/hardpoint/support/on_install(obj/vehicle/multitile/V)
	..()
	if(is_locomotion())
		if(move_delay) V.move_delay = move_delay
		if(move_max_momentum) V.move_max_momentum = move_max_momentum
		if(move_momentum_build_factor) V.move_momentum_build_factor = move_momentum_build_factor
		if(move_turn_momentum_loss_factor) V.move_turn_momentum_loss_factor = move_turn_momentum_loss_factor
		owner.next_move = world.time + move_delay
	if(is_turret())
		for(var/obj/item/hardpoint/H in hardpoints)
			H.owner = V
			H.on_install(V)

/obj/item/hardpoint/support/on_uninstall(obj/vehicle/multitile/V)
	if(is_locomotion())
		loco_deactivate()
	if(is_turret() && V)
		for(var/obj/item/hardpoint/H in hardpoints)
			H.on_uninstall(V)
			H.owner = null
	..()

/obj/item/hardpoint/support/proc/handle_acid_damage(atom/A)
	if(!is_locomotion())
		return
	if(health <= 0)
		return

	var/take_damage = 0
	if(istype(A, /obj/effect/xenomorph/spray))
		var/obj/effect/xenomorph/spray/acid = A
		take_damage = acid.damage_amount
		if(acid.cause_data.cause_name == "resin acid trap")
			take_damage = floor(take_damage / 3)
	else if(istype(A, /obj/effect/blocker/toxic_water))
		take_damage = 10

	if(acid_resistant)
		take_damage = take_damage / 2

	health -= take_damage

	if(!(world.time % 3))
		playsound(A, 'sound/bullets/acid_impact1.ogg', 10, 1)

	if(owner)
		owner.healthcheck()

//-------------------------------------------------------------------------------//
//---------------------------------- Turret -------------------------------------//
//-------------------------------------------------------------------------------//

/obj/item/hardpoint/support/Destroy()
	if(is_turret())
		QDEL_NULL_LIST(hardpoints)
	. = ..()

/obj/item/hardpoint/support/update_icon()
	..()
	if(is_turret())
		overlays.Cut()
		for(var/obj/item/hardpoint/H in hardpoints)
			var/image/I = H.get_hardpoint_image()
			overlays += I

/obj/item/hardpoint/support/proc/find_hardpoint(name)
    if(!is_turret())
        return null
    for(var/obj/item/hardpoint/H in hardpoints)
        if(H.name == name)
            return H
    return null

/obj/item/hardpoint/support/attackby(obj/item/O, mob/user)
	if(!is_turret())
		return ..()

	if(HAS_TRAIT(O, TRAIT_TOOL_CROWBAR))
		if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
			to_chat(user, SPAN_WARNING("You don't know what to do with \the [O] on \the [src]."))
			return

		var/chosen_hp = tgui_input_list(user, "Select a hardpoint to remove", "Vehicle Hardpoint Removal", (hardpoints + "Cancel"))
		if(chosen_hp == "Cancel")
			return
		var/obj/item/hardpoint/old = chosen_hp

		// 5 second delay
		user.visible_message(
			SPAN_NOTICE("[user] begins removing \the [old] from the [old.slot] hardpoint slot of \the [src]."),
			SPAN_NOTICE("You begin removing \the [old] from the [old.slot] hardpoint slot of \the [src].")
		)
		if(!do_after(user, 50 * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
			user.visible_message(
				SPAN_WARNING("[user] stops removing \the [old] from \the [src]."),
				SPAN_WARNING("You stop removing \the [old] from \the [src].")
			)
			return

		uninstall(old, user)
		return

	if(istype(O, /obj/item/hardpoint))
		if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
			to_chat(user, SPAN_WARNING("You don't know what to do with \the [O] on \the [src]."))
			return

		var/obj/item/hardpoint/H = O
		if(!(H.type in accepted_hardpoints))
			to_chat(user, SPAN_WARNING("You don't know what to do with \the [O] on \the [src]."))
			return

		install(H, user)
		return

	..()

/obj/item/hardpoint/support/get_examine_text(mob/user)
	. = ..()
	if(is_turret())
		if(health <= 0)
			. += "It's busted!"
		else if(isobserver(user) || (ishuman(user) && (skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_NOVICE) || skillcheck(user, SKILL_VEHICLE, SKILL_VEHICLE_CREWMAN))))
			. += "It's at [round(get_integrity_percent(), 1)]% integrity!"
		for(var/obj/item/hardpoint/H in hardpoints)
			. += "There is \a [H] module installed on [src]."
			. += H.get_examine_text(user, TRUE)

/obj/item/hardpoint/support/get_tgui_info()
	var/list/data = ..()
	if(is_turret())
		for(var/obj/item/hardpoint/H in hardpoints)
			data += list(H.get_tgui_info())
	return data

/obj/item/hardpoint/support/take_damage(damage)
	..()
	if(is_turret())
		for(var/obj/item/hardpoint/H in hardpoints)
			H.take_damage(damage)

/obj/item/hardpoint/support/proc/can_install(obj/item/hardpoint/H)
	if(!is_turret())
		return FALSE
	if(LAZYLEN(hardpoints))
		for(var/obj/item/hardpoint/HP in hardpoints)
			if(HP.slot == H.slot)
				return FALSE
	return LAZYISIN(accepted_hardpoints, H.type)

/obj/item/hardpoint/support/proc/install(obj/item/hardpoint/H, mob/user)
	if(!is_turret())
		return
	if(health <= 0)
		to_chat(user, SPAN_WARNING("All the mounting points on \the [src] are broken!"))
		return

	if(user)
		user.visible_message(
			SPAN_NOTICE("[user] begins installing \the [H] on the [H.slot] hardpoint slot of \the [src]."),
			SPAN_NOTICE("You begin installing \the [H] on the [H.slot] hardpoint slot of \the [src].")
		)
		if(!do_after(user, 50 * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
			user.visible_message(
				SPAN_WARNING("[user] stops installing \the [H] on \the [src]."),
				SPAN_WARNING("You stop installing \the [H] on \the [src].")
			)
			return
	user.temp_drop_inv_item(H, 0)
	add_hardpoint(H)
	update_icon()

/obj/item/hardpoint/support/proc/get_activatable_hardpoints(seat)
	if(!is_turret())
		return list()
	var/list/hps = list()
	for(var/obj/item/hardpoint/H in hardpoints)
		if(!H.is_activatable() || (seat && seat != H.allowed_seat))
			continue
		hps += H
	return hps

/obj/item/hardpoint/support/proc/uninstall(obj/item/hardpoint/H, mob/user)
	if(!is_turret())
		return
	if(!LAZYISIN(hardpoints, H))
		return

	if(user)
		user.visible_message(
			SPAN_NOTICE("[user] begins removing \the [H] from the [H.slot] hardpoint slot of \the [src]."),
			SPAN_NOTICE("You begin removing \the [H] from the [H.slot] hardpoint slot of \the [src].")
		)
		if(!do_after(user, 50 * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
			user.visible_message(
				SPAN_WARNING("[user] stops removing \the [H] from \the [src]."),
				SPAN_WARNING("You stop removing \the [H] from \the [src].")
			)
			return

	remove_hardpoint(H, get_turf(user))
	update_icon()

/obj/item/hardpoint/support/proc/add_hardpoint(obj/item/hardpoint/H)
    if(!is_turret())
        return
    H.owner = owner
    H.forceMove(src)
    LAZYADD(hardpoints, H)
    H.on_install(owner)
    H.dir = SOUTH
    H.rotate(turning_angle(H.dir, dir))

/obj/item/hardpoint/support/proc/remove_hardpoint(obj/item/hardpoint/H, turf/uninstall_to)
	if(!is_turret() || !hardpoints)
		return
	H.forceMove(uninstall_to ? uninstall_to : get_turf(src))
	H.on_uninstall(owner)
	H.dir = SOUTH
	H.reset_rotation()

	hardpoints -= H
	H.owner = null
	if(H.health <= 0)
		qdel(H)

/obj/item/hardpoint/support/proc/get_hardpoints_with_ammo(seat)
    if(!is_turret())
        return list()
    var/list/hps = list()
    for(var/obj/item/hardpoint/H in hardpoints)
        if(!H.ammo || (seat && seat != H.allowed_seat))
            continue
        hps += H
    return hps

/obj/item/hardpoint/support/get_hardpoint_image()
	var/image/I = ..()
	if(!is_turret())
		return I

	var/list/images = list(I)
	for(var/obj/item/hardpoint/H in hardpoints)
		var/image/HI = H.get_hardpoint_image()
		if(LAZYLEN(px_offsets) && loc && HI)
			HI.pixel_x += px_offsets["[loc.dir]"][1]
			HI.pixel_y += px_offsets["[loc.dir]"][2]
		images += HI
	return images

/obj/item/hardpoint/support/rotate(deg)
    if(is_turret())
        for(var/obj/item/hardpoint/H in hardpoints)
            H.rotate(deg)

    ..()
