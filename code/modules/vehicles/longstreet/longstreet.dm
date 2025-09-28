/obj/vehicle/multitile/longstreet
	name = "M34A2 Longstreet Light Tank"
	desc = "The lightest tank fielded by the USCMC, the Longstreet is an agile platform with less importance placed on armor. Entrance in the back."

	icon = 'icons/obj/vehicles/longstreet.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

	bound_width = 96
	bound_height = 96

	bound_x = -32
	bound_y = -32

	interior_map = /datum/map_template/interior/longstreet

	//tank always has 2 crewmen slot reserved and 1 general slot for other roles.
	passengers_slots = 2
	//this is done in case VCs die inside the tank, so that someone else can come in and take them out.
	revivable_dead_slots = 2
	xenos_slots = 4

	entrances = list(
		"back" = list(0, 2)
	)

	movement_sound = 'sound/vehicles/tankdriving.mp3'
	honk_sound = 'sound/vehicles/honk_3_ambulence.ogg'

	required_skill = SKILL_VEHICLE_LARGE

	vehicle_flags = VEHICLE_CLASS_MEDIUM
	vehicle_pen_armor = VEHICLE_ARMOR_HEAVY_ARMOR

	move_max_momentum = 3
	move_momentum_build_factor = 1.8
	move_turn_momentum_loss_factor = 0.6

	vehicle_light_range = 7

	// Rest (all the guns) is handled by the tank turret hardpoint
	hardpoints_allowed = list(
		/obj/item/hardpoint/support/longstreet/tank_turret,
		/obj/item/hardpoint/support/longstreet/sensor,
		/obj/item/hardpoint/support/longstreet/overdrive,
		/obj/item/hardpoint/support/longstreet/ballistic,
		/obj/item/hardpoint/support/longstreet/caustic,
		/obj/item/hardpoint/support/longstreet/concussive,
		/obj/item/hardpoint/support/longstreet/snowplow,
		/obj/item/hardpoint/support/longstreet/treads
	)

	seats = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.5, // Acid melts the tank
		"slash" = 0.7, // Slashing a massive, solid chunk of metal does very little except leave scratches
		"bullet" = 0.4,
		"explosive" = 0.8,
		"blunt" = 0.8,
		"abstract" = 1
	)

	explosive_resistance = 400

/obj/vehicle/multitile/longstreet/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] M34A2 \"[nickname]\" Tank" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] M34A2 Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list

/obj/vehicle/multitile/longstreet/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_WO_CREWMAN, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN)
	RRS.total = 2
	role_reserved_slots += RRS

/obj/vehicle/multitile/longstreet/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/support/longstreet/tank_turret)

/obj/vehicle/multitile/longstreet/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	if(seat == VEHICLE_DRIVER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))


/obj/vehicle/multitile/longstreet/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
		/obj/vehicle/multitile/proc/switch_hardpoint,
	))
	SStgui.close_user_uis(M, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

//Called when players try to move vehicle
//Another wrapper for try_move()
/obj/vehicle/multitile/longstreet/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/support/longstreet/tank_turret/T = null
	for(var/obj/item/hardpoint/support/longstreet/tank_turret/TT in hardpoints)
		T = TT
		break
	if(!T)
		return FALSE

	if(direction == GLOB.reverse_dir[T.dir] || direction == T.dir)
		return FALSE

	T.user_rotation(user, turning_angle(T.dir, direction))
	update_icon()

	return TRUE

/obj/vehicle/multitile/longstreet/MouseDrop_T(mob/dropped, mob/user)
	. = ..()
	if((dropped != user) || !isxeno(user))
		return

	if(health > 0)
		to_chat(user, SPAN_XENO("We can't jump over [src] until it is destroyed!"))
		return

	var/turf/current_turf = get_turf(user)
	var/dir_to_go = get_dir(current_turf, src)
	for(var/i in 1 to 3)
		current_turf = get_step(current_turf, dir_to_go)
		if(!(current_turf in locs))
			break

		if(current_turf.density)
			to_chat(user, SPAN_XENO("The path over [src] is obstructed!"))
			return

	// Now we check to make sure the turf on the other side of the tank isn't dense too
	current_turf = get_step(current_turf, dir_to_go)
	if(current_turf.density)
		to_chat(user, SPAN_XENO("The path over [src] is obstructed!"))
		return

	to_chat(user, SPAN_XENO("We begin to jump over [src]..."))
	if(!do_after(user, 3 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
		to_chat(user, SPAN_XENO("We stop jumping over [src]."))
		return

	user.forceMove(current_turf)
	to_chat(user, SPAN_XENO("We jump to the other side of [src]."))
/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/longstreet
	name = "Longstreet Tank Spawner"
	icon = 'icons/obj/vehicles/longstreet.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/longstreet/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: turret, no hardpoints (not the one without turret for convenience, you still expect to have turret when you spawn "no hardpoints tank")
/obj/effect/vehicle_spawner/longstreet/spawn_vehicle()
	var/obj/vehicle/multitile/longstreet/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/longstreet/load_hardpoints(obj/vehicle/multitile/longstreet/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/longstreet/tank_turret)

//PRESET: turret, treads installed
/obj/effect/vehicle_spawner/longstreet/plain/load_hardpoints(obj/vehicle/multitile/longstreet/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/longstreet/tank_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/longstreet/treads)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/longstreet/hull/load_hardpoints(obj/vehicle/multitile/longstreet/V)
	return

//Just the hull and it's broken TOO, you get the full experience
/obj/effect/vehicle_spawner/longstreet/hull/broken/spawn_vehicle()
	var/obj/vehicle/multitile/longstreet/tonk = ..()
	load_damage(tonk)
	tonk.update_icon()

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/longstreet/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/longstreet/TANK = new (loc)

	load_misc(TANK)
	handle_direction(TANK)
	load_hardpoints(TANK)
	load_damage(TANK)
	TANK.update_icon()

/obj/effect/vehicle_spawner/longstreet/decrepit/load_hardpoints(obj/vehicle/multitile/longstreet/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/longstreet/treads)
	V.add_hardpoint(new /obj/item/hardpoint/support/longstreet/tank_turret)
	for(var/obj/item/hardpoint/support/longstreet/tank_turret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/longstreet/cannon)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/longstreet/m56cupola)
		break

//PRESET: default hardpoints
/obj/effect/vehicle_spawner/longstreet/fixed/load_hardpoints(obj/vehicle/multitile/longstreet/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/longstreet/treads)
	V.add_hardpoint(new /obj/item/hardpoint/support/longstreet/tank_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/longstreet/overdrive)
	for(var/obj/item/hardpoint/support/longstreet/tank_turret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/longstreet/cannon)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/longstreet/m56cupola)
		break
