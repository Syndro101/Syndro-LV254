/obj/vehicle/multitile/civtruck
	name = "civilian truck"
	desc = "A rather cheap hunk of metal with some wheels, you know what to do. Entrance on the sides."

	layer = ABOVE_XENO_LAYER
	vehicle_flags = VEHICLE_CLASS_WEAK
	vehicle_pen_armor = VEHICLE_ARMOR_SOFT

	icon = 'icons/obj/vehicles/civtruck.dmi'
	icon_state = "civtruck_1"

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	passengers_slots = 3
	xenos_slots = 2
	flatbed = TRUE
	max_stored_cargo = 1

	interior_map = /datum/map_template/interior/truck
	entrances = list(
		"left" = list(2, 0),
		"right" = list(-1, 0)
	)

	movement_sound = 'sound/vehicles/tank_driving.ogg'

	luminosity = 6

	move_max_momentum = 3
	move_turn_momentum_loss_factor = 1

	hardpoints_allowed = list(
		/obj/item/hardpoint/support/locomotion/civtruck
	)

/obj/vehicle/multitile/civtruck/civtruck_2
	name = "civilian truck"
	icon_state = "civtruck_2"
	passengers_slots = 6
	xenos_slots = 6
	flatbed = FALSE
	interior_map = /datum/map_template/interior/civtruck

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-1, 0),
		"back_left" = list(1, 2),
		"back_right" = list(0, 2)
	)


/obj/vehicle/multitile/civtruck/civtruck_3
	name = "civilian truck"
	icon_state = "civtruck_3"
	interior_map = /datum/map_template/interior/truck
	flatbed = FALSE
	entrances = list(
		"left" = list(2, 0),
		"right" = list(-1, 0)
	)

/obj/effect/vehicle_spawner/spawner/civtruck
	name = "flatbed spawner"
	icon = 'icons/obj/vehicles/civtruck.dmi'
	icon_state = "civtruck_1"
	pixel_x = -16
	pixel_y = -16

/obj/effect/vehicle_spawner/civtruck/Initialize()
	. = ..()
	dir = pick(NORTH,SOUTH,EAST,WEST)
	spawn_vehicle()
	qdel(src)

//civtruck fixed
/obj/effect/vehicle_spawner/civtruck
	name = "Civilian flatbed"
	icon_state = "civtruck"

/obj/effect/vehicle_spawner/civtruck/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/civtruck/civtruck = new (loc)

	load_misc(civtruck)
	load_hardpoints(civtruck)
	handle_direction(civtruck)
	civtruck.update_icon()

/obj/effect/vehicle_spawner/civtruck/fixed/load_hardpoints(obj/vehicle/multitile/civtruck/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/locomotion/civtruck)
