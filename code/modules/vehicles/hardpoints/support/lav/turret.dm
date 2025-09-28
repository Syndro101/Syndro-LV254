/obj/item/hardpoint/support/lav/lav_turret
	name = "\improper M620-A Multipurpose Turret"
	desc = "The centerpiece of the M620 LAV. Designed to support quick installation and deinstallation of various modules."

	icon = 'icons/obj/vehicles/lav.dmi'
	icon_state = "lav_turret_0"
	disp_icon = "lav"
	disp_icon_state = "lav_turret"
	pixel_x = -48
	pixel_y = -48

	density = TRUE //come on, it's huge

	w_class = SIZE_MASSIVE
	anchored = TRUE

	allowed_seat = VEHICLE_GUNNER

	slot = HDPT_TURRET

	// big beefy chonk of metal
	health = 450
	damage_multiplier = 0.1
	point_cost = 500

	accepted_hardpoints = list(
		// primaries
		/obj/item/hardpoint/primary/lav/chaingun,
		/obj/item/hardpoint/primary/lav/plasma
	)

	hdpt_layer = HDPT_LAYER_TURRET
	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	var/gyro = FALSE

	// How long the windup is before the turret rotates
	var/rotation_windup = 4 // Decently quick
	// Used during the windup
	var/rotating = FALSE

	scatter = 4
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.6 SECONDS

/obj/item/hardpoint/support/lav/lav_turret/update_icon()
	var/broken = (health <= 0)
	icon_state = "lav_turret_[broken]"

	if(health <= initial(health))
		var/image/damage_overlay = image(icon, icon_state = "damaged_turret")
		damage_overlay.alpha = 255 * (1 - (health / initial(health)))
		overlays += damage_overlay

	..()

/obj/item/hardpoint/support/lav/lav_turret/get_icon_image(x_offset, y_offset, new_dir)
	var/icon_state_suffix = "0"
	if(health <= 0)
		icon_state_suffix = "1"

	var/image/I = image(icon = disp_icon, icon_state = "[disp_icon_state]_[icon_state_suffix]", pixel_x = x_offset, pixel_y = y_offset, dir = new_dir)

	if(health <= initial(health))
		var/image/damage_overlay = image(icon, icon_state = "damaged_turret")
		damage_overlay.alpha = 255 * (1 - (health / initial(health)))
		I.overlays += damage_overlay

	return I

// no picking this big beast up
/obj/item/hardpoint/support/lav/lav_turret/attack_hand(mob/user)
	return

/obj/item/hardpoint/support/lav/lav_turret/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/powerloader_clamp))
		var/obj/item/powerloader_clamp/PC = I
		if(!PC.linked_powerloader)
			qdel(PC)
			return TRUE

		if(health < 1)
			visible_message(SPAN_WARNING("\The [src] disintegrates into useless pile of scrap under the damage it suffered!"))
			qdel(src)
			return TRUE

		PC.grab_object(user, src, "vehicle_module", 'sound/machines/hydraulics_2.ogg')
		update_icon()
		return TRUE
	..()

/obj/item/hardpoint/support/lav/lav_turret/get_tgui_info()
	var/list/data = list()

	for(var/obj/item/hardpoint/H in hardpoints)
		data += list(H.get_tgui_info())

	return data

//gyro ON locks the turret in one direction, OFF will make turret turning when tank turns
/obj/item/hardpoint/support/lav/lav_turret/proc/toggle_gyro(mob/user)
	if(health <= 0)
		to_chat(user, SPAN_WARNING("\The [src]'s stabilization systems are busted!"))
		return

	gyro = !gyro
	to_chat(user, SPAN_NOTICE("You toggle \the [src]'s gyroscopic stabilizer [gyro ? "ON" :"OFF"]."))

/obj/item/hardpoint/support/lav/lav_turret/proc/user_rotation(mob/user, deg)
	var/soundfile = 'sound/mecha/powerloader_turn2.ogg'

	// no rotating a broken turret
	if(health <= 0)
		return

	if(rotating)
		return

	rotating = TRUE
	to_chat(user, SPAN_NOTICE("You begin rotating the turret towards the [dir2text(turn(dir,deg))]."))

	if(!do_after(user, rotation_windup, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		rotating = FALSE
		return
	rotating = FALSE

	playsound(loc, soundfile, 25, 1)
	rotate(deg, TRUE)

/obj/item/hardpoint/support/lav/lav_turret/rotate(deg, override_gyro = FALSE)
	if(gyro && !override_gyro)
		return

	..(deg)

/obj/item/hardpoint/support/lav/lav_turret/try_fire(atom/target, mob/living/user, params)
	var/turf/L
	var/turf/R
	switch(owner.dir)
		if(NORTH)
			L = locate(owner.x - 2, owner.y + 4, owner.z)
			R = locate(owner.x + 2, owner.y + 4, owner.z)
		if(SOUTH)
			L = locate(owner.x + 2, owner.y - 4, owner.z)
			R = locate(owner.x - 2, owner.y - 4, owner.z)
		if(EAST)
			L = locate(owner.x + 4, owner.y + 2, owner.z)
			R = locate(owner.x + 4, owner.y - 2, owner.z)
		else
			L = locate(owner.x - 4, owner.y + 2, owner.z)
			R = locate(owner.x - 4, owner.y - 2, owner.z)

	if(shots_fired)
		target = R
	else
		target = L

	return ..()
