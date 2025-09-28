/obj/item/hardpoint/support/jeep/jeep_turret
	name = "\improper M220 CTM Upgrade"
	desc = "The main upgrade for Armat M48 Military Jeeps, allows installation of a variety of weapons."

	icon = 'icons/obj/vehicles/jeep.dmi'
	icon_state = "jeep_cupola_0"
	disp_icon = "jeep"
	disp_icon_state = "jeep_cupola"
	pixel_x = -48
	pixel_y = -48

	density = TRUE //come on, it's huge

	w_class = SIZE_MASSIVE
	density = TRUE
	anchored = TRUE

	allowed_seat = VEHICLE_GUNNER

	slot = HDPT_TURRET
	point_cost = 400

	// basically just a ring and motor
	health = 200
	damage_multiplier = 0.6

	accepted_hardpoints = list(
		/obj/item/hardpoint/primary/jeep/m56,
		/obj/item/hardpoint/primary/jeep/m56/hmg,
		/obj/item/hardpoint/primary/jeep/small_flamer,
		/obj/item/hardpoint/primary/jeep/towlauncher,
		/obj/item/hardpoint/primary/jeep/grenade_launcher,
		/obj/item/hardpoint/primary/jeep/grenade_launcher/riot
	)

	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	var/gyro = FALSE

	// How long the windup is before the turret rotates
	var/rotation_windup = 2  // Very quick
	// Used during the windup
	var/rotating = FALSE

	scatter = 4
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.6 SECONDS

/obj/item/hardpoint/support/jeep/jeep_turret/update_icon()
	var/broken = (health <= 0)
	icon_state = "jeep_turret_[broken]"

	if(health <= initial(health))
		var/image/damage_overlay = image(icon, icon_state = "damaged_turret")
		damage_overlay.alpha = 255 * (1 - (health / initial(health)))
		overlays += damage_overlay

	..()

/obj/item/hardpoint/support/jeep/jeep_turret/get_icon_image(x_offset, y_offset, new_dir)
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
/obj/item/hardpoint/support/jeep/jeep_turret/attack_hand(mob/user)
	return

/obj/item/hardpoint/support/jeep/jeep_turret/attackby(obj/item/I, mob/user)
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

/obj/item/hardpoint/support/jeep/jeep_turret/get_tgui_info()
	var/list/data = list()

	for(var/obj/item/hardpoint/H in hardpoints)
		data += list(H.get_tgui_info())

	return data

//gyro ON locks the turret in one direction, OFF will make turret turning when tank turns
/obj/item/hardpoint/support/jeep/jeep_turret/proc/toggle_gyro(mob/user)
	if(health <= 0)
		to_chat(user, SPAN_WARNING("\The [src]'s stabilization systems are busted!"))
		return

	gyro = !gyro
	to_chat(user, SPAN_NOTICE("You toggle \the [src]'s gyroscopic stabilizer [gyro ? "ON" :"OFF"]."))

/obj/item/hardpoint/support/jeep/jeep_turret/proc/user_rotation(mob/user, deg)
	var/soundfile = 'sound/machines/scanning.ogg'

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

/obj/item/hardpoint/support/jeep/jeep_turret/rotate(deg, override_gyro = FALSE)
	if(gyro && !override_gyro)
		return

	..(deg)

/obj/item/hardpoint/support/jeep/jeep_turret/try_fire(atom/target, mob/living/user, params)
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
