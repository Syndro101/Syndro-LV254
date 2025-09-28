// APC interior stuff

//wall

/obj/structure/interior_wall/Initialize()
	. = ..()

	if(loc.opacity)
		loc.opacity = FALSE

/obj/structure/interior_wall/apc
	name = "\improper APC interior wall"
	icon = 'icons/obj/vehicles/interiors/apc.dmi'
	icon_state = "apc_right_1"

/obj/structure/interior_exit/vehicle/apc
	name = "APC side door"
	icon = 'icons/obj/vehicles/interiors/apc.dmi'
	icon_state = "exit_door"

/obj/structure/interior_exit/vehicle/apc/rear
	name = "APC rear hatch"
	icon_state = "door_rear_center"

/obj/structure/interior_exit/vehicle/apc/rear/left
	icon_state = "door_rear_left"

/obj/structure/interior_exit/vehicle/apc/rear/right
	icon_state = "door_rear_right"

/obj/structure/prop/vehicle
	name = "Generic vehicle prop"
	desc = "Adds more flavour to vehicle interior."

	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = ""

	unacidable = TRUE
	unslashable = TRUE
	breakable = FALSE
	explo_proof = TRUE

/obj/structure/prop/vehicle/sensor_equipment
	name = "Data Analyzing Nexus"
	desc = "This machinery collects and analyzes data from the M577 CMD APC's sensors cluster and then feeds the results to Almayer's tactical map display network. Better not touch it."

	icon = 'icons/obj/vehicles/interiors/apc.dmi'
	icon_state = "sensors_equipment"
