GLOBAL_LIST_EMPTY(command_apc_list)

/obj/vehicle/multitile/apc
	name = "M577 Armored Personnel Carrier"
	desc = "An M577 Armored Personnel Carrier. An armored transport with four big wheels. Entrances on the sides and back."

	icon = 'icons/obj/vehicles/apc.dmi'
	icon_state = "apc_base"
	pixel_x = -48
	pixel_y = -48

	bound_width = 96
	bound_height = 96

	bound_x = -32
	bound_y = -32

	interior_map = /datum/map_template/interior/apc

	passengers_slots = 15
	xenos_slots = 8

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-2, 0),
		"rear left" = list(1, 2),
		"rear center" = list(0, 2),
		"rear right" = list(-1, 2)
	)

	entrance_speed = 0.5 SECONDS

	required_skill = SKILL_VEHICLE_LARGE
	vehicle_pen_armor = VEHICLE_ARMOR_MEDIUM_ARMOR

	movement_sound = 'sound/vehicles/tank_driving.ogg'

	var/gunner_view_buff = 10

	hardpoints_allowed = list(
		/obj/item/hardpoint/primary/apc/dualcannon,
		/obj/item/hardpoint/secondary/apc/frontalcannon,
		/obj/item/hardpoint/support/apc/flare_launcher,
		/obj/item/hardpoint/support/apc/apc_wheels,
	)

	seats = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
		VEHICLE_SUPPORT_GUNNER_ONE = null,
		VEHICLE_SUPPORT_GUNNER_TWO = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
		VEHICLE_SUPPORT_GUNNER_ONE = null,
		VEHICLE_SUPPORT_GUNNER_TWO = null,
	)

	vehicle_flags = VEHICLE_CLASS_LIGHT

	mob_size_required_to_hit = MOB_SIZE_XENO

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.6,
		"slash" = 0.8,
		"bullet" = 0.6,
		"explosive" = 0.7,
		"blunt" = 0.7,
		"abstract" = 1
	)

	move_max_momentum = 2
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.8

	vehicle_ram_multiplier = VEHICLE_TRAMPLE_DAMAGE_APC_REDUCTION

/obj/vehicle/multitile/apc/Initialize()
	. = ..()

	var/turf/gotten_turf = get_turf(src)
	if(gotten_turf && gotten_turf.z)
		SSminimaps.add_marker(src, gotten_turf.z, MINIMAP_FLAG_USCM, "apc", 'icons/ui_icons/map_blips_large.dmi')

/obj/vehicle/multitile/apc/load_role_reserved_slots()
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

/obj/vehicle/multitile/apc/add_seated_verbs(mob/living/M, seat)
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

/obj/vehicle/multitile/apc/remove_seated_verbs(mob/living/M, seat)
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

/obj/vehicle/multitile/apc/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] M777 \"[nickname]\" APC"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior"
	else
		camera.c_tag = "#[rand(1,100)] M777 APC"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior"

/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/apc
	name = "APC Transport Spawner"
	icon = 'icons/obj/vehicles/apc.dmi'
	icon_state = "apc_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/apc/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/apc/spawn_vehicle()
	var/obj/vehicle/multitile/apc/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

//PRESET: wheels installed
/obj/effect/vehicle_spawner/apc/plain/load_hardpoints(obj/vehicle/multitile/apc/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/apc/apc_wheels)

//PRESET: default hardpoints, destroyed (this one spawns on VASRS elevatorfor VCs)
/obj/effect/vehicle_spawner/apc/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/apc/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	load_damage(APC)
	APC.update_icon()

/obj/effect/vehicle_spawner/apc/decrepit/load_hardpoints(obj/vehicle/multitile/apc/V)
	V.add_hardpoint(new /obj/item/hardpoint/primary/apc/dualcannon)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/apc/frontalcannon)
	V.add_hardpoint(new /obj/item/hardpoint/support/apc/flare_launcher)
	V.add_hardpoint(new /obj/item/hardpoint/support/apc/apc_wheels)

//PRESET: default hardpoints
/obj/effect/vehicle_spawner/apc/fixed/load_hardpoints(obj/vehicle/multitile/apc/V)
	V.add_hardpoint(new /obj/item/hardpoint/primary/apc/dualcannon)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/apc/frontalcannon)
	V.add_hardpoint(new /obj/item/hardpoint/support/apc/flare_launcher)
	V.add_hardpoint(new /obj/item/hardpoint/support/apc/apc_wheels)
