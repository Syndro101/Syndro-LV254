/obj/vehicle/multitile/lav
	name = "M620 Light Armored Vehicle"
	desc = "An M620 six-wheeled LAV, a nimble vehicle designed for infantry support. Entrance is in the back."

	icon = 'icons/obj/vehicles/lav.dmi'
	icon_state = "lav_base"
	pixel_x = -48
	pixel_y = -48

	bound_width = 96
	bound_height = 96

	bound_x = -32
	bound_y = -32

	interior_map = /datum/map_template/interior/lav

	passengers_slots = 15
	xenos_slots = 8

	entrances = list(
		"rear left" = list(1, 2),
		"rear center" = list(0, 2),
		"rear right" = list(-1, 2)
	)

	entrance_speed = 0.5 SECONDS

	required_skill = SKILL_VEHICLE_LARGE
	vehicle_pen_armor = VEHICLE_ARMOR_MEDIUM_ARMOR

	movement_sound = 'sound/vehicles/tank_driving.ogg'

	hardpoints_allowed = list(
		/obj/item/hardpoint/support/lav/lav_turret,
		/obj/item/hardpoint/primary/lav/chaingun,
		/obj/item/hardpoint/support/lav/lav_wheels,
		/obj/item/hardpoint/support/lav/smoke_launcher,
		/obj/item/hardpoint/support/lav/flare_launcher
	)

	seats = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	vehicle_flags = VEHICLE_CLASS_LIGHT

	mob_size_required_to_hit = MOB_SIZE_XENO

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.5,
		"slash" = 0.7,
		"bullet" = 0.7,
		"explosive" = 1,
		"blunt" = 0.7,
		"abstract" = 1
	)

	move_max_momentum = 3
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.8

	vehicle_ram_multiplier = VEHICLE_TRAMPLE_DAMAGE_APC_REDUCTION

/obj/vehicle/multitile/lav/Initialize()
	. = ..()

	var/turf/gotten_turf = get_turf(src)
	if(gotten_turf && gotten_turf.z)
		SSminimaps.add_marker(src, gotten_turf.z, MINIMAP_FLAG_USCM, "apc", 'icons/ui_icons/map_blips_large.dmi')

/obj/vehicle/multitile/lav/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_WO_CREWMAN, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN)
	RRS.total = 2
	role_reserved_slots += RRS

	RRS = new
	RRS.category_name = "Synthetic Unit"
	RRS.roles = list(JOB_SYNTH, JOB_WO_SYNTH)
	RRS.total = 1
	role_reserved_slots += RRS

/obj/vehicle/multitile/lav/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/support/lav/lav_turret)

/obj/vehicle/multitile/lav/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide
	))
	if(seat == VEHICLE_DRIVER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
			/obj/vehicle/multitile/proc/name_vehicle
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/name_vehicle
		))

/obj/vehicle/multitile/lav/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
	))
	SStgui.close_user_uis(M, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
			/obj/vehicle/multitile/proc/name_vehicle,
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/name_vehicle,
		))

/obj/vehicle/multitile/lav/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/support/lav/lav_turret/T = null
	for(var/obj/item/hardpoint/support/lav/lav_turret/TT in hardpoints)
		T = TT
		break
	if(!T)
		return FALSE

	if(direction == GLOB.reverse_dir[T.dir] || direction == T.dir)
		return FALSE

	T.user_rotation(user, turning_angle(T.dir, direction))
	update_icon()

	return TRUE

/obj/vehicle/multitile/lav/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] M620 \"[nickname]\" LAV"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior"
	else
		camera.c_tag = "#[rand(1,100)] M620 LAV"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior"

/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/lav
	name = "LAV Transport Spawner"
	icon = 'icons/obj/vehicles/lav.dmi'
	icon_state = "lav_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/lav/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/lav/spawn_vehicle()
	var/obj/vehicle/multitile/lav/LAV = new (loc)

	load_misc(LAV)
	load_hardpoints(LAV)
	handle_direction(LAV)
	LAV.update_icon()

//PRESET: wheels installed
/obj/effect/vehicle_spawner/lav/plain/load_hardpoints(obj/vehicle/multitile/lav/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/lav_wheels)

//PRESET: default hardpoints, destroyed (this one spawns on VASRS elevator for VCs)
/obj/effect/vehicle_spawner/lav/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/lav/LAV = new (loc)

	load_misc(LAV)
	load_hardpoints(LAV)
	handle_direction(LAV)
	load_damage(LAV)
	LAV.update_icon()

/obj/effect/vehicle_spawner/lav/decrepit/load_hardpoints(obj/vehicle/multitile/lav/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/lav_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/lav_wheels)

//PRESET: chaingun
/obj/effect/vehicle_spawner/lav/chaingun/load_hardpoints(obj/vehicle/multitile/lav/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/lav_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/lav_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/flare_launcher)

	for(var/obj/item/hardpoint/support/lav/lav_turret/LT in V.hardpoints)
		LT.add_hardpoint(new /obj/item/hardpoint/primary/lav/chaingun)
		break

//PRESET: plasma
/obj/effect/vehicle_spawner/lav/plasma/load_hardpoints(obj/vehicle/multitile/lav/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/lav_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/lav_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/support/lav/flare_launcher)

	for(var/obj/item/hardpoint/support/lav/lav_turret/LT in V.hardpoints)
		LT.add_hardpoint(new /obj/item/hardpoint/primary/lav/plasma)
		break

/obj/effect/vehicle_spawner/lav/load_hardpoints(obj/vehicle/multitile/lav/V)
	return

/obj/effect/vehicle_spawner/lav/broken/spawn_vehicle()
	var/obj/vehicle/multitile/lav/LAV = ..()
	load_damage(LAV)
	LAV.update_icon()
