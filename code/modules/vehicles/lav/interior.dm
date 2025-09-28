// LAV interior stuff

//wall

/obj/structure/interior_wall/lav/Initialize()
	. = ..()

	if(loc.opacity)
		loc.opacity = FALSE

/obj/structure/interior_exit/vehicle/lav
	name = "LAV side door"
	icon = 'icons/obj/vehicles/interiors/apc.dmi'
	icon_state = "exit_door"

/obj/structure/interior_exit/vehicle/lav/rear
	name = "LAV rear ramp"
	icon_state = "door_rear_center"

/obj/structure/interior_exit/vehicle/lav/rear/left
	icon_state = "door_rear_left"

/obj/structure/interior_exit/vehicle/lav/rear/right
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
